# Tests shrug-status

# Setting up environment
sh shrug-init > /dev/null
touch a b c d e f g h
sh shrug-add a b c d e f > /dev/null
sh shrug-commit -m 'first commit' > /dev/null

# Creating all types of file issues
echo hello >a
echo hello >b
echo hello >c
sh shrug-add a b
echo world >a
rm d
sh shrug-rm e
sh shrug-add g

# Obtaining status'
sh shrug-status > output.txt

# Checking if a is file changed, different changes staged for commit
if [ $(cat output.txt | egrep "a - file changed, different changes staged for commit" | wc -l) = 0 ]
then
    echo "a did not get file changed, different changes staged for commit"
fi

# Checking if b is file changed, changes staged for commit
if [ $(cat output.txt | egrep "b - file changed, changes staged for commit" | wc -l) = 0 ]
then
    echo "b did not get file changed, changes staged for commit"
fi

# Checking if c is file changed, changes not staged for commit
if [ $(cat output.txt | egrep "c - file changed, changes not staged for commit" | wc -l) = 0 ]
then
    echo "c did not get file changed, changes not staged for commit"
fi

# Checking if d is file deleted
if [ $(cat output.txt | egrep "d - file deleted" | wc -l) = 0 ]
then
    echo "d did not get file deleted"
fi

# Checking if e is deleted
if [ $(cat output.txt | egrep "e - deleted" | wc -l) = 0 ]
then
    echo "e did not get deleted"
fi

# Checking if f is same as repo
if [ $(cat output.txt | egrep "f - same as repo" | wc -l) = 0 ]
then
    echo "f did not get same as repo"
fi

# Checking if g is added to index
if [ $(cat output.txt | egrep "g - added to index" | wc -l) = 0 ]
then
    echo "g did not get added to index"
fi

# Checking if h is untracked
if [ $(cat output.txt | egrep "h - untracked" | wc -l) = 0 ]
then
    echo "h did not get untracked"
fi

# Checking if a is file changed, different changes staged for commit
if [ $(cat output.txt | egrep "a - file changed, different changes staged for commit" | wc -l) = 0 ]
then
    echo "a did not get file changed, different changes staged for commit"
fi

echo "Test04 Complete"
