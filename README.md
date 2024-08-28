# Bash Shell Script Database Management System (DBMS)

## Project Overview

This project is a simple Database Management System (DBMS) implemented entirely in Bash. The goal of this project is to enable users to create, store, and retrieve data from the hard disk using a command-line interface (CLI). The DBMS provides a menu-driven interface that allows users to interact with databases and tables, performing various operations such as creating, listing, updating, and deleting records.

## Features

### Main Menu
The main menu offers the following options:

- **Create Database:** Allows users to create a new database, which is stored as a directory.
- **List Databases:** Displays a list of all available databases.
- **Connect To Database:** Connect to a specific database to perform operations on its tables.
- **Drop Database:** Deletes a selected database and all its associated data.

### Database Operations Menu
Once connected to a specific database, users have the following options:

- **Create Table:** Create a new table within the database. Users can define the column names and primary key.
- **List Tables:** Display all tables within the connected database.
- **Drop Table:** Delete a specific table from the database.
- **Insert into Table:** Add a new row of data into a table.
- **Select From Table:** Retrieve and display data from a table in a formatted output.
- **Delete From Table:** Remove a specific row of data from a table based on the primary key.
- **Update Table:** Update the values of a specific row in a table, while ensuring that primary key values remain unique.

### Data Integrity Features
- **Primary Key Constraint:** Ensures that the primary key is unique for each record in the table.
- **Formatted Data Display:** Outputs selected rows in a clean and readable format.

## Project Structure

- **dbms.sh:** The main script that provides the CLI menu interface for interacting with the DBMS.
- **database_actions.sh:** Contains functions related to database operations (create, list, connect, drop).
- **table_actions.sh:** Contains functions related to table operations (create, list, drop, insert, select, delete, update).

Each database is represented as a directory, and each table within the database is represented as a file inside the corresponding database directory. The first line of each table file contains the column names, and subsequent lines contain the data rows.

## How to Use

### Prerequisites
- **Bash Shell:** This script is designed to run in a Unix-like environment with a Bash shell.

### Running the Script
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/ahmedelzagh/bash_dbms.git
   cd bash_dbms
   ```

2. **Make the Script Executable:**
   ```bash
   chmod +x dbms.sh
   ```

3. **Run the DBMS:**
   ```bash
   ./dbms.sh
   ```

### Main Menu Options
- **Create Database:** Enter the name for the new database when prompted.
- **List Databases:** View the list of all databases currently available.
- **Connect To Database:** Choose a database to connect to and perform further operations on its tables.
- **Drop Database:** Enter the name of the database you wish to delete.

### Database Operations
Once connected to a database, you can perform the following operations:

- **Create Table:** Define a new table by specifying the column names and primary key.
- **List Tables:** View the list of tables within the current database.
- **Drop Table:** Enter the name of the table you wish to delete.
- **Insert into Table:** Enter values for each column to add a new row to the table.
- **Select From Table:** Retrieve and view specific rows of data from a table.
- **Delete From Table:** Specify the primary key of the row you want to delete.
- **Update Table:** Modify the values of an existing row, ensuring that the primary key remains unique.
