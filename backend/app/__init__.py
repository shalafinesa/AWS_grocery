import logging
import shutil
import zipfile
from logging.handlers import RotatingFileHandler
import os
from flask import Flask, send_from_directory, render_template, request
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from sqlalchemy import text
from flask_migrate import Migrate
from dotenv import load_dotenv
from datetime import timedelta
import requests
from dateutil import parser

load_dotenv()
db = SQLAlchemy()

DEPLOYMENT_ENV = os.getenv("DEPLOYMENT_ENV", "local")
GITHUB_USERNAME = "AlejandroRomanIbanez"
REPO_NAME = "AWS_grocery"
FRONTEND_BUILD_ZIP = "frontend-build.zip"
FRONTEND_BUILD_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../frontend/build"))
TMP_ZIP_PATH = "/tmp/frontend-build.zip"
GITHUB_RELEASE_URL = f"https://github.com/{GITHUB_USERNAME}/{REPO_NAME}/releases/latest/download/{FRONTEND_BUILD_ZIP}"


class Config:
    """App configuration variables."""
    if os.getenv("FLASK_ENV") == "development":
        SQLALCHEMY_DATABASE_URI = "sqlite:///" + os.path.join(os.path.abspath(os.path.dirname(__file__)), "local.db")
    else:
        POSTGRES_URI = os.getenv("POSTGRES_URI")
        SQLALCHEMY_DATABASE_URI = POSTGRES_URI
    print(SQLALCHEMY_DATABASE_URI)

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY")
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(hours=4)


def fetch_frontend():
    """
    Fetches the latest frontend build from GitHub Releases if it's missing or outdated.
    """
    if os.path.exists(FRONTEND_BUILD_PATH):
        print("Frontend build is already present. Checking for updates...")

        latest_release_timestamp = get_github_release_timestamp()
        local_build_timestamp = get_local_build_timestamp()

        if latest_release_timestamp and local_build_timestamp:
            if local_build_timestamp >= latest_release_timestamp:
                print("Frontend build is up to date.")
                return
            print("Frontend build is outdated. Fetching the latest version...")

    else:
        print("Frontend build not found. Fetching the latest version...")

    try:
        response = requests.get(GITHUB_RELEASE_URL, stream=True)
        if response.status_code == 200:
            with open(TMP_ZIP_PATH, "wb") as f:
                f.write(response.content)

            if os.path.exists(FRONTEND_BUILD_PATH):
                shutil.rmtree(FRONTEND_BUILD_PATH)
                print("Old frontend build removed.")

            os.makedirs(FRONTEND_BUILD_PATH, exist_ok=True)

            with zipfile.ZipFile(TMP_ZIP_PATH, 'r') as zip_ref:
                temp_extract_path = os.path.join(os.path.dirname(FRONTEND_BUILD_PATH), "frontend_temp")
                shutil.rmtree(temp_extract_path, ignore_errors=True)
                os.makedirs(temp_extract_path, exist_ok=True)

                zip_ref.extractall(temp_extract_path)

                extracted_files = os.listdir(temp_extract_path)
                if "build" in extracted_files:
                    extracted_build_path = os.path.join(temp_extract_path, "build")
                else:
                    extracted_build_path = temp_extract_path

                # Move extracted files into the actual build directory
                for item in os.listdir(extracted_build_path):
                    shutil.move(os.path.join(extracted_build_path, item), FRONTEND_BUILD_PATH)

                shutil.rmtree(temp_extract_path)

            print("Frontend build downloaded and extracted successfully.")
        else:
            print("Failed to download frontend build. Status Code:", response.status_code)
    except Exception as e:
        print(f"Error fetching frontend: {e}")


def get_github_release_timestamp():
    """
    Fetches the timestamp of the latest frontend release from GitHub.
    """
    release_api_url = f"https://api.github.com/repos/{GITHUB_USERNAME}/{REPO_NAME}/releases/latest"
    try:
        response = requests.get(release_api_url)
        if response.status_code == 200:
            timestamp_iso = response.json().get("published_at")
            if timestamp_iso:
                return int(parser.parse(timestamp_iso).timestamp())
    except Exception as e:
        print(f"Error fetching GitHub release timestamp: {e}")
    return None


def get_local_build_timestamp():
    """
    Retrieves the timestamp of the local frontend build.
    """
    try:
        return os.path.getmtime(FRONTEND_BUILD_PATH)
    except Exception:
        return None


def create_app():
    """
    Creates and configures the Flask app.
    """
    fetch_frontend()

    app = Flask(__name__,
                static_folder="../../frontend/build/static",
                template_folder=os.path.join(os.path.dirname(__file__), "../../frontend/build"))
    CORS(app, resources={r"/*": {"origins": "*"}})
    app.config.from_object(Config)

    db.init_app(app)

    with app.app_context():
        if app.config['SQLALCHEMY_DATABASE_URI'].startswith('sqlite'):
            db.session.execute(text('PRAGMA foreign_keys=ON'))

    JWTManager(app)
    Migrate(app, db)
    setup_logging(app)

    from .routes.auth_routes import auth_bp
    from .routes.user_routes import user_bp
    from .routes.product_routes import product_bp
    from .routes.health_routes import health_bp
    from .routes.config_routes import config_bp

    app.register_blueprint(auth_bp)
    app.register_blueprint(user_bp)
    app.register_blueprint(product_bp)
    app.register_blueprint(health_bp)
    app.register_blueprint(config_bp)

    def inject_backend_url():
        """Get the backend URL based on the current request"""
        if DEPLOYMENT_ENV == "public_ip":
            try:
                public_ip = requests.get('http://169.254.169.254/latest/meta-data/public-ipv4', timeout=1).text
                return f"http://{public_ip}:5000"
            except requests.exceptions.RequestException:
                return f"http://{request.host}"

        elif DEPLOYMENT_ENV == "load_balancer":
            # Running behind a Load Balancer
            if request.headers.get('X-Forwarded-Proto'):
                proto = request.headers.get('X-Forwarded-Proto')
                host = request.headers.get('X-Forwarded-Host', request.host)
            else:
                proto = request.scheme
                host = request.host
            return f"{proto}://{host}"

        else:
            # Default: Local development
            return f"{request.scheme}://{request.host}"

    @app.route("/", defaults={"path": ""})
    @app.route("/<path:path>")
    def serve_react_app(path):
        if path != "" and os.path.exists(os.path.join(app.static_folder, path)):
            return send_from_directory(app.static_folder, path)
        else:
            backend_url = inject_backend_url()
            return render_template(
                "index.html",
                backend_url=backend_url
            )

    return app


def setup_logging(app):
    """
    Set up logging to a file, creating the log file if it doesn't exist.
    Logs will rotate when they reach a certain size.
    """
    if not os.path.exists('logs'):
        os.mkdir('logs')

    log_file = 'logs/app.log'

    file_handler = RotatingFileHandler(log_file, maxBytes=1024 * 1024, backupCount=5)
    file_handler.setLevel(logging.INFO)

    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    file_handler.setFormatter(formatter)

    app.logger.addHandler(file_handler)
    app.logger.setLevel(logging.INFO)