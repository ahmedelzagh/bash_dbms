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

# List all databases (directories)
function list_databases() {
    echo "Databases:"
    ls -d */
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
