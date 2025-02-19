import os
import time
import psycopg2
from flask_migrate import Migrate, upgrade
from app import create_app, db, Config

app = create_app()
migrate = Migrate(app, db)

POSTGRES_URI = os.getenv("POSTGRES_URI")
IS_RDS = Config.is_rds()
IS_LOCAL = Config.is_local_postgres()


def wait_for_db():
    """Wait for PostgreSQL to be ready before starting migrations."""
    print("⏳ Waiting for database to be ready...")
    while True:
        try:
            conn = psycopg2.connect(POSTGRES_URI)
            conn.close()
            print("✅ Database is ready!")
            break
        except psycopg2.OperationalError:
            print("⚠️ Database is not ready yet. Retrying in 3 seconds...")
            time.sleep(3)


def run_migrations():
    """Run database migrations to ensure tables exist."""
    with app.app_context():
        print("🚀 Running migrations...")
        upgrade()


def seed_database():
    """Seed the database, ensuring products are inserted before reviews."""
    sql_file = "app/sqlite_dump_clean.sql"
    if os.path.exists(sql_file):
        print("📂 Seeding database with sqlite_dump_clean.sql...")

        with app.app_context():
            conn = db.engine.raw_connection()
            cursor = conn.cursor()

            with open(sql_file, "r", encoding="utf-8") as f:
                sql_commands = [cmd.strip() for cmd in f.read().split(";") if cmd.strip()]

            # 🛠️ Insert products first
            for command in sql_commands:
                if "INSERT INTO products" in command:
                    try:
                        cursor.execute(command)
                    except psycopg2.errors.UniqueViolation:
                        print("⚠️ Skipping duplicate product entry.")
                        conn.rollback()
                    except psycopg2.Error as e:
                        print(f"❌ SQL Error (Products): {e}")
                        conn.rollback()

            conn.commit()

            # 🛠️ Insert all other data (users, reviews, etc.)
            for command in sql_commands:
                if "INSERT INTO products" not in command:
                    try:
                        cursor.execute(command)
                    except psycopg2.errors.ForeignKeyViolation:
                        print("⚠️ Skipping review due to missing product reference.")
                        conn.rollback()
                    except psycopg2.errors.UniqueViolation:
                        print("⚠️ Skipping duplicate entry.")
                        conn.rollback()
                    except psycopg2.Error as e:
                        print(f"❌ SQL Error: {e}")
                        conn.rollback()

            conn.commit()
            cursor.close()
            conn.close()

        print("✅ Database seeding complete!")


if __name__ == "__main__":
    if IS_LOCAL:
        wait_for_db()
        run_migrations()
        seed_database()
    elif IS_RDS:
        print("✅ Skipping setup - Using AWS RDS (Manual Database Management).")
