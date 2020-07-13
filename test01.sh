# Testing when shrug has yet to be initalised
sh shrug-add a > output.txt
if [ "$(cat output.txt | tr -d "\n")" != "shrug-add: error: no .shrug directory containing shrug repository exists" ]
then
    echo "Failed to detect that there was no .shrug repository"
    exit
fi

# Setting up repositry
sh shrug-init > /dev/null
touch a

# Testing adding a normal file
sh shrug-add a
if ! test -e .shrug/branches/master/index/a
then
    echo "Adding a single file failed"
    exit
fi

# Testing removing a file
rm a
sh shrug-add a
if test -e .shrug/branches/master/index/a
then
    echo "Removing a single file failed"
    exit
fi

# Testing multiple adding
touch a b
sh shrug-add a b
if ! test -e .shrug/branches/master/index/a || ! test -e .shrug/branches/master/index/b
then
    echo "Adding multiple files at once failed"
    exit
fi

# Adding a non-existent file
sh shrug-add c > output.txt
if [ "$(cat output.txt | tr -d "\n")" != "shrug-add: error: can not open 'c'" ]
then
    echo "File does not handle non-existent files"
    exit
fi

echo Test01 Complete
