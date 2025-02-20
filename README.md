## GroceryMate


### Overview

#### GroceryMate is a comprehensive e-commerce platform offering the following features:

    User Authentication: Register and login functionality.
    Protected Routes: All the routes that need to be authenticated will redirect to /auth
    Product Search: Search for products, sort them by price, and filter by categories.
    Favorites: Add products to your favorites list.
    Shopping Basket: Add products to your basket and manage them.
    Check-out Process: Complete the checkout process with billing and shipping information, choose payment methods, and calculate the total price.

### Features

    Register, Login, and Logout: Secure user authentication system.
    Product Search and Sorting: Search for products, and sort them by price or name in both ASC and DESC.
    Product Category and Price Range: Get the product by categories or range of price
    Favorites: Manage your favorite products.
    Shopping Basket: Add products to your basket, view, and modify the contents.
    Check-out Process:
        Billing and Shipping Information
        Payment Method Selection
        Total Price Calculation

## Screenshots and videos


![imagen](https://github.com/user-attachments/assets/ea039195-67a2-4bf2-9613-2ee1e666231a)
![imagen](https://github.com/user-attachments/assets/a87e5c50-5a9e-45b8-ad16-2dbff41acd00)
![imagen](https://github.com/user-attachments/assets/589aae62-67ef-4496-bd3b-772cd32ca386)
![imagen](https://github.com/user-attachments/assets/2772b85e-81f7-446a-9296-4fdc2b652cb7)

https://github.com/user-attachments/assets/d1c5c8e4-5b16-486a-b709-4cf6e6cce6bc


## Requirements
To make this app work make sure you have this installed on your computer:
- Python(use `pyenv` to install and manage compatible versions [3.12/3.11])
- PostgreSQL(Ensure it is running locally)
- Git


## Installation

Follow these steps to set up the application locally.

## 1️⃣ Clone repository

Clone the repository:

    git clone --branch version2 https://github.com/AlejandroRomanIbanez/AWS_grocery.git
    

## 2️⃣ Install pyenv and python (if you haven't yet)
We use pyenv to manage Python versions, ensuring compatibility


### On macOS/Linux:

Follow the instructions [here](https://github.com/pyenv/pyenv-installer) to install pyenv.

### On Windows:

Use pyenv-win, you can find it [here](https://github.com/pyenv-win/pyenv-win), follow the instructions to install it

### Install Python with `pyenv` (if you don't have it on your machine yet)

Install Python 3.12.x (or 3.11.x): 

    pyenv install 3.12.1
    pyenv global 3.12.1

Check Python version now using:

    python3 --version

You should see the version you installed (e.g., `3.12.1`).

## 3️⃣ Set Up PostgreSQL Database
PostgreSQL is our database where we store users, products, orders, etc.

Make sure is running before continuing.

### Start PostgreSQL Service
    sudo service postgresql start  # On Linux/MacOS
    net start postgresql  # On Windows

### Create the Database and User
Now we need to create our database and assign a user to manage it.
Follow this command, it will ask you for a password, the default one for postgres is `postgres`:

    psql -U postgres 

Run the following commands inside PostgreSQL, you can change the USER and PASSWORD to your own preferences:

    CREATE DATABASE grocerymate_db;
    CREATE USER grocery_user WITH ENCRYPTED PASSWORD 'grocery_user';
    ALTER USER grocery_user WITH SUPERUSER;
    \q  # Exit PostgreSQL CLI

This creates a Database called grocerymate_db and
ensures that grocery_user has full access to the grocerymate_db database.


## 4️⃣ Backend Installation

Navigate to the backend folder:

    cd backend

Create a virtual environment:

A virtual environment isolates dependencies for this project.

    python3 -m venv venv

Activate the virtual environment: 
 - On macOS/Linux: 


    source venv/bin/activate  
- On Windows use


    venv\Scripts\activate

Install Requirements:

Now we install all required Python packages:

    pip install -r requirements.txt

Create an `.env` file for the backend:

The .env file stores environment variables used by the app.

- On macOS:

  - Use nano to create the `.env` file:

        touch .env

- On Windows:

  - Use ni to create the `.env` file

        ni .env -Force
       
  
Generate the JWT Secret Key 
- To generate a secure `JWT_SECRET_KEY`, run the following command:

      python -c "import secrets; print(secrets.token_hex(32))"

Example:
  `094bb15924a8a63d82f612b978e8bc758d5c3f0330a41beefb36f45b587411d4`
- This key will be used to secure user sessions
- Copy the generated key from your terminal

Edit the .env file

- On macOS:

      nano .env

  Paste your copied JWT Secret Key into the file like this
`JWT_SECRET_KEY=094bb15924a8a63d82f612b978e8bc758d5c3f0330a41beefb36f45b587411d4`


  Also generate the enviroment variables for PostgresSQL to make the app correctly access to your DB:
  
  - Make sure to replace this example with your created user, password and DB you created before


      POSTGRES_USER=grocery_user
      POSTGRES_PASSWORD=grocery_test
      POSTGRES_DB=grocerymate_db
      POSTGRES_HOST=localhost

      POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
  Exit and save.


- On Windows:
  
      notepad .env

  Paste your copied JWT Secret Key into the file like this
`JWT_SECRET_KEY=094bb15924a8a63d82f612b978e8bc758d5c3f0330a41beefb36f45b587411d4`

  Also generate the enviroment variables for PostgresSQL to make the app correctly access to your DB:
  
  - Make sure to replace this example with your created user, password and DB you created before


      POSTGRES_USER=grocery_user
      POSTGRES_PASSWORD=grocery_test
      POSTGRES_DB=grocerymate_db
      POSTGRES_HOST=localhost

      POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
  Exit and save.


## 5️⃣ Populate the Database with Initial Data
After running migrations, we populate the database with test data(Make sure to use the correct user, DB and password).

    psql -U grocery_user -d grocerymate_db -f app/sqlite_dump_clean.sql

Verify that data has been inserted:

    psql -U grocery_user -d grocerymate_db
    SELECT * FROM users;
    SELECT * FROM products;

If you see rows, the import was successful!

You can exit the PostgreSQL CLI by typing `\q`


### Start the Application:

        python3 run.py

### Navigate and get familiar with the app

    Register or Login:
        Open the application in your browser ---> http://localhost:5000
        Register a new account or log in with your existing credentials.

    Upload avatars:
        Upload an image and use it as the avatar of the user

    Search for Products:
        Use the search bar to find products.
        Sort products by price or filter by categories in store.

    Products:
        Add, edit, or delete reviews of products you buyed

    Add to Favorites and Basket:
        Add products to your favorites list for quick access.
        Add products to your basket to proceed with the purchase.

    Checkout:
        Go to your basket and click on the checkout button.
        Fill in your billing and shipping information.
        Choose your preferred payment method.
        Review the total cost and confirm your purchase.
