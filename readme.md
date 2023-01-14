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

# How do I update maxibuild?

````
Yes, you do not need to visit this github page to update the script. To update maxibuild use the option --update and accept the update when prompted.

maxibuild --update

# Sample output:

root@MAXIWORK:~# maxibuild update
[maxibuild->check_update]: Checking maxibuild for update...
 [ OK ]

Installed version is: v0.3.0
Online version is: v0.3.1

[maxibuild->check_update]: A new version of maxibuild is available.
[maxibuild->check_update->input]: Do you want to update maxibuild to version 0.3.1? [default:Y] [Y/n]: y
[maxibuild->script_update]: Updating maxibuild to latest version ...

START git update information:
Fetching origin
 [ OK ]
HEAD is now at 038f751 Added suricata installation with 4 modes
 [ OK ]
END git update information:

[maxibuild->script_update]: Updating maxibuild configuration file ...
 [ OK ]
[maxibuild->script_update]: Running maxibuild -V ...
 [ OK ]
root@MAXIWORK:~# maxibuild -V
=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=

Info: Maxibuild is a bash script to manage packages.

Version: 0.3.1-alpha

Author: Arafat Ali | Email: arafat@sofibox.com | (C) 2019-2022

=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
root@MAXIWORK:~# maxibuild update
[maxibuild->check_update]: Checking maxibuild for update...
 [ OK ]

Installed version is: v0.3.1
Online version is: v0.3.1

[maxibuild->check_update]: You are using the latest version of maxibuild.
````