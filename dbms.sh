#!/bin/bash

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
