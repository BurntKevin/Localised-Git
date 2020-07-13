# Testing shrug-branch

# Setting up environment
sh shrug-init > /dev/null

# Testing an empty no commit branch
sh shrug-branch > output.txt

if [ "$(cat output.txt)" != "shrug-branch: error: your repository does not have any commits yet" ]
then
    echo Did not successfully print branch
    exit
fi

# Creating a branch
sh shrug-branch b1 > output.txt

if [ "$(cat output.txt)" != "" ]
then
    echo While creating a branch, something was outputted which was not meant to output anything
    exit
fi

# Creating a duplicate branch
sh shrug-branch b1 > output.txt

if [ "$(cat output.txt)" != "shrug-branch: error: branch 'b1' already exists" ]
then
    echo Did not notify user that a branch already exists while trying to create
    exit
fi

# Deleting non-master branch
sh shrug-branch -d b1 > output.txt
if [ "$(cat output.txt)" != "Deleted branch 'b1'" ]
then
    echo Did not successfully delete non-master branch
    exit
fi

# Deleting non-existent branch
sh shrug-branch -d b1 > output.txt
if [ "$(cat output.txt)" != "shrug-branch: error: branch 'b1' does not exist" ]
then
    echo Did not successfully delete non-master branch
    exit
fi

# Deleting master branch
sh shrug-branch -d master > output.txt
if [ "$(cat output.txt)" != "shrug-branch: error: can not delete branch 'master'" ]
then
    echo Did not successfully delete non-master branch
    exit
fi

# Final test to ensure only master branch is left
sh shrug-branch > output.txt

if [ "$(cat output.txt)" != "shrug-branch: error: your repository does not have any commits yet" ]
then
    echo Did not successfully print branch
    exit
fi

echo Test07 Complete
