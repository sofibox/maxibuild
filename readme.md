````
maxibuild --version
=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=

Info: Maxibuild is a bash script to manage packages.

Version: stable

Author: Arafat Ali | Email: arafat@sofibox.com | (C) 2019-2022

=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
````

This script is very useful to check for one or more missing packages and install them automatically. It will do nothing if the package exist.

# Setup:

Run `install.sh` to install maxibuild in your system (recommended for maintainability)


# Download and run install.sh

````
wget https://raw.githubusercontent.com/sofibox/maxibuild/master/install.sh
chmod +x install.sh
./install.sh

and then you can use it in your script and terminal like this

# YOUR CODE
maxibuild --include "git htop vim"
# YOUR CODE

````

# How to force install a package even if it is already installed?

````
To force build and install a package use the option --force-install
maxibuild --include "git htop vim" --force-install
````