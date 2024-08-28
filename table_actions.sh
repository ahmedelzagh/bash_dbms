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

# List all tables (files)
function list_tables() {
    echo "Tables:"
    ls -p | grep -v /
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

# Delete a specific row from a table based on primary key
function delete_from_table() {
    echo -n "Enter table name: "
    read table_name
    if [ ! -f "$table_name" ]; then
        echo "Table does not exist!"
        return
    fi

    echo -n "Enter primary key value to delete: "
    read primary_key

    # Check if the row exists
    if ! grep -q "^$primary_key," "$table_name"; then
        echo "Error: No row found with primary key '$primary_key'."
        return
    fi

    # Delete the row
    grep -v "^$primary_key," "$table_name" > temp_file && mv temp_file "$table_name"
    echo "Row with primary key '$primary_key' deleted from table '$table_name'."
}

# Update a specific row in a table based on primary key
function update_table() {
    echo -n "Enter table name: "
    read table_name
    if [ ! -f "$table_name" ]; then
        echo "Table does not exist!"
        return
    fi

    echo -n "Enter primary key value to update: "
    read primary_key

    # Check if the row exists
    if ! grep -q "^$primary_key," "$table_name"; then
        echo "Error: No row found with primary key '$primary_key'."
        return
    fi

    # Read the column names from the first line of the file
    IFS=',' read -r -a columns <<< "$(head -n 1 "$table_name")"

    # Collect new data for each column
    new_data=()
    index=0
    for column in "${columns[@]}"; do
        echo -n "Enter new value for $column (leave blank to keep current value): "
        read value
        if [ -z "$value" ]; then
            # Retain current value if no new value is provided
            value=$(grep "^$primary_key," "$table_name" | cut -d ',' -f $((index+1)))
        elif [ $index -eq 0 ]; then
            # Check if the new primary key is unique
            if grep -q "^$value," "$table_name" && [ "$value" != "$primary_key" ]; then
                echo "Error: Primary key '$value' already exists!"
                return
            fi
        fi
        new_data+=("$value")
        index=$((index+1))
    done

    # Update the row
    grep -v "^$primary_key," "$table_name" > temp_file
    echo "${new_data[*]}" | tr ' ' ',' >> temp_file
    mv temp_file "$table_name"
    echo "Row with primary key '${new_data[0]}' updated in table '$table_name'."
}
