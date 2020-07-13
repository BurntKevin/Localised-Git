# Tests shrug-checkout

# Setting up environment
sh shrug-init > /dev/null

# Checking out to an unknown branch
sh shrug-checkout b2 > output.txt

if [ "$(cat output.txt)" != "shrug-checkout: error: unknown branch 'b2'" ]
then
    echo Branch should not checkout to an unknown branch
    exit
fi

# Testing a successful checkout
sh shrug-branch b1 > /dev/null
sh shrug-checkout b1 > /dev/null

# Checking if the branch has been updated on the file
if [ "$(cat .shrug/current_branch)" != "b1" ]
then
    echo Branch was not successfully changed
    exit
fi

echo Test08 Complete