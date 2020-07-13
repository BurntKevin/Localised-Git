#!/bin/sh
# Tests init

# Testing successful case
sh shrug-init > output.txt

# Checking if shrug was created
if ! test -d ".shrug"
then
    echo Test failed: .shrug does not exist
    exit
fi

# Checking if branches was created
if ! test -d ".shrug/branches"
then
    echo Test failed: .shrug/branches does not exist
    exit
fi

# Checking if branch information is correct
if [ $(cat .shrug/current_branch) != "master" ]
then
    echo Test failed: Branch name not created
    exit
fi

# Checking if commit number was added
if [ $(cat .shrug/commit_number) != "0" ]
then
    echo Test failed: Commit number does not exist
    exit
fi

# Checking if branch sub-directories were created - main
if ! test -d .shrug/branches/master
then
    echo Test failed: Branch was not created
    exit
fi

# Checking if branch sub-directories were created - index
if ! test -d .shrug/branches/master/index
then
    echo Test failed: Branch index was not created
    exit
fi

# Checking if branch sub-directories were created - stash
if ! test -d .shrug/branches/master/stash
then
    echo Test failed: Branch stash was not created
    exit
fi

# Checking if success output is correct
if [ "$(cat output.txt | tr -d "\n")" != "Initialized empty shrug repository in .shrug" ]
then
    echo Test failed: User progress update was not shown correctly of successful creation
    exit
fi

# Testing unsuccessful case
sh shrug-init > output.txt

# # Checking if failure output is correct
if [ "$(cat output.txt | tr -d "\n")" != "shrug-init: error: .shrug already exists" ]
then
    echo Test failed: User progress update was not shown correctly or another .shrug was created
    exit
fi

echo Test00 Complete
