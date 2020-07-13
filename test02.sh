# Setting up repository
sh shrug-init > /dev/null

# Comitting one item
touch a b c
sh shrug-add a > /dev/null
sh shrug-commit -m 0 > output.txt

# Checking output information
if [ "$(cat output.txt | tr -d "\n")" != "Committed as commit 0" ]
then
    echo "Did not sucessfully notify user of successful commit"
    exit
fi

# Checking commit message
if [ "$(cat .shrug/branches/master/0/message.txt | tr -d "\n")" != "0" ]
then
    echo "Did not sucessfully make commit message for single item"
    exit
fi

# Checking commit counter
if [ "$(cat .shrug/commit_number | tr -d "\n")" != "1" ]
then
    echo "Did not sucessfully increment commit number"
    exit
fi

# Checking commit file
if ! test -e .shrug/branches/master/0/saved/a
then
    echo "Did not successfully commit 1 item"
    exit
fi

# Comitting one items
sh shrug-commit -a -m test_1 > output.txt

# Checking output information
if [ "$(cat output.txt | tr -d "\n")" != "Committed as commit 1" ]
then
    echo "Did not sucessfully notify user of successful commit"
    exit
fi

# Checking commit message
if [ "$(cat .shrug/branches/master/1/message.txt | tr -d "\n")" != "test_1" ]
then
    echo "Did not sucessfully make commit message for multiple items"
    exit
fi

# Checking commit counter
if [ "$(cat .shrug/commit_number | tr -d "\n")" != "2" ]
then
    echo "Did not sucessfully increment commit number"
    exit
fi

# Checking commit file
if ! test -e .shrug/branches/master/1/saved/a
then
    echo "Altered file a"
    exit
fi
if ! test -e .shrug/branches/master/1/saved/b
then
    echo "Did not successfully commit file b"
    exit
fi
if ! test -e .shrug/branches/master/1/saved/c
then
    echo "Did not successfully commit file c"
    exit
fi

# Committing nothing
sh shrug-commit -m test_2 > output.txt

# Testing if nothing to commit warning is correct
if [ "$(cat output.txt | tr -d "\n")" != "nothing to commit" ]
then
    echo "Did not warn user of them committing nothing"
    exit
fi

echo "Test02 Complete"
