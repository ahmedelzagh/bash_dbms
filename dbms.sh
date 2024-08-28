#!/bin/bash

# Select and display rows from a table
function select_from_table() {
    echo -n "Enter table name: "
    read table_name
    if [ ! -f "$table_name" ]; then
        echo "Table does not exist!"
        return
    fi

    echo "Displaying data from table '$table_name':"
    column_names=$(head -n 1 "$table_name")
    echo "$column_names"
    echo "-------------------------------------"
    tail -n +2 "$table_name" | while IFS=',' read -r line; do
        echo "$line"
    done
}

# Insert a new row into a table
function insert_into_table() {
    echo -n "Enter table name: "
    read table_name
    if [ ! -f "$table_name" ]; then
        echo "Table does not exist!"
        return
    fi

    # Read the column names from the first line of the file
    IFS=',' read -r -a columns <<< "$(head -n 1 "$table_name")"

    # Collect data for each column
    row_data=()
    for column in "${columns[@]}"; do
        echo -n "Enter value for $column: "
        read value
        row_data+=("$value")
    done

    # Check for unique primary key (assuming first column is the primary key)
    primary_key=${row_data[0]}
    if grep -q "^$primary_key," "$table_name"; then
        echo "Error: Primary key '$primary_key' already exists!"
        return
    fi

    # Insert the new row into the table
    echo "${row_data[*]}" | tr ' ' ',' >> "$table_name"
    echo "Row inserted into table '$table_name'."
}

# Drop (delete) a specific table (file)
function drop_table() {
    echo -n "Enter table name to drop: "
    read table_name
    if [ -f "$table_name" ]; then
        rm "$table_name"
        echo "Table '$table_name' dropped successfully."
    else
        echo "Table does not exist!"
    fi
}

# List all tables (files)
function list_tables() {
    echo "Tables:"
    ls -p | grep -v /
}

# Create a new table (file)
function create_table() {
    echo -n "Enter table name: "
    read table_name
    if [ -f "$table_name" ]; then
        echo "Table already exists!"
    else
        echo -n "Enter the columns (comma-separated): "
        read columns
        echo "$columns" > "$table_name"
        echo "Table '$table_name' created with columns: $columns"
    fi
}

# Database Menu Function
function database_menu() {
    while true; do
        echo "======================"
        echo " Database Menu - $db_name"
        echo "======================"
        echo "1. Create Table"
        echo "2. List Tables"
        echo "3. Drop Table"
        echo "4. Insert into Table"
        echo "5. Select From Table"
        echo "6. Delete From Table"
        echo "7. Update Table"
        echo "8. Back to Main Menu"
        echo -n "Please enter your choice [1-8]: "
        read choice
        case $choice in
            1) create_table ;;
            2) list_tables ;;
            3) drop_table ;;
            4) insert_into_table ;;
            5) select_from_table ;;
            6) delete_from_table ;;
            7) update_table ;;
            8) break ;;
            *) echo "Invalid choice! Please select a valid option." ;;
        esac
    done
}

# Drop (delete) a specific database (directory)
function drop_database() {
    echo -n "Enter database name to drop: "
    read db_name
    if [ -d "$db_name" ]; then
        rm -r "$db_name"
        echo "Database '$db_name' dropped successfully."
    else
        echo "Database does not exist!"
    fi
}

# Connect to a specific database (enter database menu)
function connect_to_database() {
    echo -n "Enter database name: "
    read db_name
    if [ -d "$db_name" ]; then
        echo "Connected to '$db_name'."
        cd "$db_name"
        database_menu
        cd ..
    else
        echo "Database does not exist!"
    fi
}

# List all databases (directories)
function list_databases() {
    echo "Databases:"
    ls -d */
}

# Create a new database (directory)
function create_database() {
    echo -n "Enter database name: "
    read db_name
    if [ -d "$db_name" ]; then
        echo "Database already exists!"
    else
        mkdir "$db_name"
        echo "Database '$db_name' created successfully."
    fi
}

# Main Menu Function
function main_menu() {
    echo "===================="
    echo " Bash DBMS Main Menu"
    echo "===================="
    echo "1. Create Database"
    echo "2. List Databases"
    echo "3. Connect To Database"
    echo "4. Drop Database"
    echo "5. Exit"
    echo -n "Please enter your choice [1-5]: "
    read choice
    case $choice in
        1) create_database ;;
        2) list_databases ;;
        3) connect_to_database ;;
        4) drop_database ;;
        5) exit 0 ;;
        *) echo "Invalid choice! Please select a valid option." ;;
    esac
}

# Start the Main Menu
while true; do
    main_menu
done
