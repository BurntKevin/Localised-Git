# Tests shrug-checkout

# Setting up environment
sh shrug-init > /dev/null

# Checking out to an unknown branch
sh shrug-checkout b1 > output.txt

if [ "$(cat output.txt)" != "shrug-checkout: error: unknown branch 'b1'"]
then
    echo Branch has been shifted due to merge
    exit
fi

# Testing a successful checkout
sh shrug-branch b1 > /dev/null
sh shrug-checkout b1 > output.txt

# Checking message given
if [ "$(cat output.txt)" != "Switched to branch 'b1'"]
then
    echo Branch change did not notify user
    exit
fi

# Checking if the branch has been updated on the file
if [ "$(cat .shrug/current_branch)" != "b1"]
then
    echo Branch was not successfully changed
    exit
fi

echo Test08 Complete