# Tests shrug-log

# Setting up environment
sh shrug-init > /dev/null

# Obtaining no commits
sh shrug-log > output.txt

# Testing if no commits returns the right message
if [ "$(cat output.txt | tr -d "\n")" != "" ]
then
    echo "Obtained output for no commits"
    exit
fi

# Adding a commit
touch a
sh shrug-commit -a -m "First commit" > /dev/null

sh shrug-log > output.txt

# Testing if a commit message is displayed
if [ "$(cat output.txt | tr -d "\n")" != "0 First commit" ]
then
    echo "Could not successfully obtain first commit message"
    exit
fi

# Testing multiple commits
touch b
sh shrug-commit -a -m "Second commit" > /dev/null

sh shrug-log > output.txt

# Testing if multiple commit messages are displayed
if [ "$(cat output.txt | tr -d "\n")" != "1 Second commit0 First commit" ]
then
    echo "Could not successfully obtain multiple commit messages"
    exit
fi

echo "Test05 Complete"