# Setting up environment
sh shrug-init > /dev/null
touch a b c d e f
sh shrug-commit -a -m commit_0 > /dev/null

# Removing one file
sh shrug-rm a > /dev/null

# Checking if the file is removed in working area
if test -e "a"
then
    echo "Did not delete single file in working area"
    exit 1
fi

# Checking if the file is removed in the index
if test -e ".shrug/branches/master/index/a"
then
    echo "Did not delete single file in staged area"
fi

# Removing multiple files
sh shrug-rm b c

# Checking if the file is removed in working area
if test -e "b"
then
    echo "Did not delete multiple files in working area - b"
    exit
fi
if test -e "c"
then
    echo "Did not delete multiple files in working area - c"
    exit
fi

# Checking if the file is removed in the index
if test -e ".shrug/branches/master/index/b"
then
    echo "Did not delete multiple files in staged area - b"
fi
if test -e ".shrug/branches/master/index/c"
then
    echo "Did not delete multiple file in staged area - c"
fi

# Checking cache deletion
sh shrug-rm --cached d > /dev/null
# Checking if the file is removed in working area
if ! test -e "d"
then
    echo "Deleted single file in working area under cached"
    exit
fi

# Checking if the file is removed in the index
if test -e ".shrug/branches/master/index/d"
then
    echo "Did not delete single file in staged area under cached"
fi

# Checking force deletion
sh shrug-rm --force e > /dev/null
# Checking if the file is removed in working area
if test -e "e"
then
    echo "Did not delete single file in working area under force"
    exit
fi

# Checking if the file is removed in the index
if test -e ".shrug/branches/master/index/e"
then
    echo "Did not delete single file in staged area under force"
fi

# Checking force and cache deletion
sh shrug-rm --force --cached f > /dev/null
# Checking if the file is removed in working area
if ! test -e "f"
then
    echo "Deleted single file in working area under force and cached"
    exit
fi

# Checking if the file is removed in the index
if test -e ".shrug/branches/master/index/f"
then
    echo "Did not delete single file in staged area under force and cached"
fi

# Deleting non-existent file
sh shrug-rm g > output.txt

# Checking message notification
if [ "$(cat output.txt | tr -d "\n")" != "shrug-rm: error: 'g' is not in the shrug repository" ]
then
    echo "Did not notify user that they cannot delete a non-existent file"
    exit
fi

echo "Test03 Complete"
