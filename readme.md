````
maxibuild --version
=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=

Info: Maxibuild is a bash script to manage packages.

Version: 0.1-alpha

Author: Arafat Ali | Email: arafat@sofibox.com | (C) 2019-2022

=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
````

This script is very useful to check for one or more missing packages and install them automatically. It will do nothing if the package exist.

There are two ways to use it:

1) Download a single file maxibuild script and source it in your script or,
2) Run install.sh to install maxibuild in your system (recommended for maintainability)

# Source it in your script

````

source maxibuild

and then you can use it in your script like this

# YOUR CODE
maxibuild "git" "htop" "vim"
# YOUR CODE
````

# Download and run install.sh

````
wget https://raw.githubusercontent.com/sofibox/maxibuild/master/install.sh
chmod +x install.sh
./install.sh

and then you can use it in your script and terminal like this

# YOUR CODE
maxibuild "git" "htop" "vim"
# YOUR CODE

````