#!/bin/bash

# File paths
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.csv"

# Ensure the secure directory exists and set permissions
mkdir -p /var/secure
chmod 700 /var/secure
touch $PASSWORD_FILE
chmod 600 $PASSWORD_FILE

# Function to generate random password
generate_password() {
    echo $(openssl rand -base64 12)
}

# Log function
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Read input file
if [[ ! -f $1 ]]; then
    echo "Error: Input file not found!"
    exit 1
fi

while IFS=';' read -r username groups; do
    # Trim whitespace
    username=$(echo $username | xargs)
    groups=$(echo $groups | xargs)

    if id "$username" &>/dev/null; then
        log_action "User $username already exists"
        continue
    fi

    # Create the user's personal group
    groupadd "$username"
    
    # Create user with home directory and add to personal group
    useradd -m -g "$username" "$username"
    
    # Generate password and set it for the user
    password=$(generate_password)
    echo "$username:$password" | chpasswd

    # Log password securely
    echo "$username,$password" >> $PASSWORD_FILE

    # Add user to additional groups
    IFS=',' read -ra ADDR <<< "$groups"
    for group in "${ADDR[@]}"; do
        group=$(echo $group | xargs)
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
        fi
        usermod -aG "$group" "$username"
    done

    # Set permissions and ownership for home directory
    chmod 700 "/home/$username"
    chown "$username:$username" "/home/$username"
    
    log_action "User $username created with groups $groups"
done < "$1"

echo "User creation process completed. Check $LOG_FILE for details."