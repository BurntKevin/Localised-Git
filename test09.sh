# Testing shrug-merge

# Setting up environment
sh shrug-init > /dev/null
sh shrug-branch b1 > /dev/null
sh shrug-checkout b1 > /dev/null
touch a
sh shrug-checkout master > /dev/null

# Obtaining current branch
current_branch=`cat .shrug/current_branch`

sh shrug-merge b1 -m Commit_0 > /dev/null

# Ensuring current branch is still the same
if [ $current_branch != "$(cat .shrug/current_branch)" ]
then
    echo Branch has been shifted due to merge
    exit
fi

# Checking if items were commited
sh shrug-checkout b1 > /dev/null
if ! test -e .shrug/branches/b1/0/saved/a
then
    echo File was not successfully commited with merge - a
    exit
fi

echo Test09 Complete
