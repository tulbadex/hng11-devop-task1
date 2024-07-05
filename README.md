# Create User Bash Script

## Overview

This project contains a bash script, create_users.sh, designed to automate the process of creating users and groups on a Linux system. It reads a text file containing usernames and group names, creates users and groups as specified, sets up home directories, generates random passwords, and logs all actions.

## Requirements

- Ensure the script is run with sudo to have the necessary permissions.
- The input text file should contain usernames and group names in the following format:
```bash
    username;group1,group2,group3

```
Example
```bash
    light; sudo,dev,www-data
    idimma; sudo
    mayowa; dev,www-data

```

## Usage

- **Clone the repository:**

```bash
    git clone https://github.com/tulbadex/hng11-devop-task1.git
    cd hng11/devops/stage1
```

- **Create the input file:**

-Create a text file named `users.txt` in the repository directory.
-Add the usernames and groups in the specified format.

**Run the script:**

```bash
    chmod +x create_users.sh
    sudo ./create_users.sh users.txt
```

**Log and Password Files**

- Log File: The log file contain details of all actions performed by the script and logged to /var/log/user_management.log.
- Password File: password file securely store the generated passwords in /var/secure/user_passwords.csv with secure permissions.

## Technical Article

For a detailed explanation of the script, read the accompanying (technical article)[h]. The article includes step-by-step explanations of each part of the script and links to resources for further learning.

## Acknowledgments

Special thanks to the HNG Internship program for the project idea. Learn more about HNG:

- [HNG Internship](https://hng.tech/internship)
- [HNG Hire](https://hng.tech/hire)