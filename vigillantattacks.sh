#!/bin/bash

# Colors for output
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
nc="\033[0m"  # No Color

# Function to generate a random password
generate_password() {
    local length=$1
    tr -dc 'A-Za-z0-9@#%&*+=-_!~' </dev/urandom | head -c "$length"
}

# Function to generate a random username
generate_username() {
    local prefix="user"
    local random_number=$((RANDOM % 1000 + 100))
    echo "${prefix}${random_number}"
}

# Function to check password strength
check_password_strength() {
    local password=$1

    # Check length
    if [[ ${#password} -lt 8 ]]; then
        echo -e "${red}Weak${nc} - Too short (<8 characters)"
        return 1
    fi

    # Check for lowercase, uppercase, digits, and special characters
    if [[ ! $password =~ [a-z] ]]; then
        echo -e "${yellow}Medium${nc} - Add lowercase letters"
        return 2
    fi

    if [[ ! $password =~ [A-Z] ]]; then
        echo -e "${yellow}Medium${nc} - Add uppercase letters"
        return 2
    fi

    if [[ ! $password =~ [0-9] ]]; then
        echo -e "${yellow}Medium${nc} - Add digits"
        return 2
    fi

    if [[ ! $password =~ [\@\#\$\%\^\&\*\(\)\_\+\!\~] ]]; then
        echo -e "${yellow}Medium${nc} - Add special characters (@, #, $, etc.)"
        return 2
    fi

    echo -e "${green}Strong${nc} - Password is strong!"
    return 0
}

# Main script starts here
clear
echo -e "${blue}Auto Password Generator & Strength Checker${nc}"
echo "=========================================="

# Get user input for how many accounts to generate
read -p "How many usernames and passwords to generate? " count
read -p "Enter the password length (minimum 8): " length

if [[ $length -lt 8 ]]; then
    echo -e "${red}Error:${nc} Password length must be at least 8 characters!"
    exit 1
fi

output_file="generated_accounts.txt"
> "$output_file"  # Clear or create the file

# Generate usernames and passwords
echo -e "\n${yellow}Generating usernames and passwords...${nc}"
for i in $(seq 1 "$count"); do
    username=$(generate_username)
    password=$(generate_password "$length")
    strength_output=$(check_password_strength "$password")

    echo -e "\n${blue}Username${nc}: $username"
    echo -e "${blue}Password${nc}: $password"
    check_password_strength "$password"

    # Save to file
    echo "Username: $username" >> "$output_file"
    echo "Password: $password" >> "$output_file"
    echo "Strength: $strength_output" >> "$output_file"
    echo "------------------------------" >> "$output_file"
done

echo -e "\n${green}All usernames and passwords saved to ${blue}$output_file${nc}"
echo -e "${green}Done!${nc}"
