# Tests shrug-show

# Setting up environment
sh shrug-init > /dev/null
echo 1 > a
echo 2 > b
sh shrug-add a > /dev/null
sh shrug-commit -m "Commit_1" > /dev/null
echo 3 > a
sh shrug-commit -a -m "Commit_2" > /dev/null

# Testing unknown commit
sh shrug-show 4:a > output.txt
if [ "$(cat output.txt)" != "shrug-show: error: unknown commit '4'" ]
then
    echo Did not handle non-existent commit
    exit
fi

# Testing unknown file in index
sh shrug-show :d > output.txt
if [ "$(cat output.txt)" != "shrug-show: error: 'd' not found in index" ]
then
    echo Did not handle non-existent file in index
    exit
fi

# Testing unknown file in commit
sh shrug-show 1:d > output.txt
if [ "$(cat output.txt)" != "shrug-show: error: 'd' not found in commit 1" ]
then
    echo Did not handle non-existent file in commit
    exit
fi

# Testing if commit file information is possible to obtain
sh shrug-show 0:a > output.txt
if [ "$(cat output.txt)" != "1" ]
then
    echo Did not successfully retrieve commit a file information
    exit
fi

# Testing if it is possible to retrieve index information
sh shrug-show :a > output.txt
if [ "$(cat output.txt)" != "3" ]
then
    echo Did not successfully retrieve commit a file information
    exit
fi

echo Test06 Complete
