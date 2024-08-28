#!/bin/bash

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
