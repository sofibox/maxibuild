#!/bin/bash

# usage:
# check_status <command> <success message> <failure message> <exit_on_failed>
check_status() {
  local retval success_msg failed_msg exit_on_failed
  retval="$1"
  success_msg="$2"
  failed_msg="$3"
  exit_on_failed="$4"

  if [[ "${retval}" -eq 0 ]]; then
    if [ -n "${success_msg}" ]; then
      echo "${success_msg}"
    else
      echo " [OK]"
      return 0
    fi
  else
    if [ -n "${failed_msg}" ]; then
      echo "${failed_msg}"
    else
      echo " [FAILED]"
    fi
    if [ "${exit_on_failed}" == "exit_on_failed" ]; then
      exit 1
    fi
  fi
}

get_distro() {
  local arg distro_id distro_version distro_codename
  arg="$1"
  if [ -e /etc/os-release ]; then
    distro_id=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release | LC_ALL=C tr '[:upper:]' '[:lower:]' | tr -d "\"")
    distro_version=$(awk -F= '$1 == "VERSION_ID" {print $2}' /etc/os-release | tr -d "\"")
    distro_codename=$(awk -F= '$1 == "VERSION_CODENAME" {print $2}' /etc/os-release | tr -d "\"")
  elif type lsb_release >/dev/null 2>&1; then
    distro_id=$(lsb_release -si | LC_ALL=C tr '[:upper:]' '[:lower:]')
    distro_version=$(lsb_release -sr)
    distro_codename=$(lsb_release -sc)
  else
    distro_id=$(uname -s)
    distro_version=$(uname -r)
    distro_codename=""
  fi
  # return values here with echo
  if [ "${arg}" == "id" ]; then
    echo "${distro_id}"
  elif [ "${arg}" == "version" ]; then
    echo "${distro_version}"
  elif [ "${arg}" == "codename" ]; then
    echo "${distro_codename}"
  fi
}

# check if the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

echo "Removing previous installation..."
rm -rf /usr/local/maxicode/maxibuild /usr/local/bin/maxibuild
check_status $? " [OK]" " [FAILED]" "exit_on_failed"
echo ""

echo "Creating script installation directory ..."
mkdir -p /usr/local/maxicode/maxibuild
check_status "$?" " [OK]" "Warning"
echo ""

# Make sure git is installed
echo "Checking whether git is installed ..."
if ! command -v git &>/dev/null; then
  echo "Git is not installed. Installing git ..."
  if [[ "$(get_distro id)" == +(debian|ubuntu) ]]; then
    apt-get -y install git
  elif [[ "$(get_distro id)" == +(centos|fedora|rhel|almalinux|rocklylinux) ]]; then
    dnf -y install git
  fi
  check_status "$?" "Git installed successfully" "Failed to install git" "exit_on_failed"
else
  echo "Git is already installed."
fi

echo ""

echo "Cloning maxibuild repository ..."
git clone --depth 1 https://github.com/sofibox/maxibuild_public.git /usr/local/maxicode/maxibuild
check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
echo ""

echo "Making maxibuild executable ..."
chmod +x /usr/local/maxicode/maxibuild/maxibuild
check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
echo ""

echo "Checking whether /usr/local/bin is in PATH ..."

if [[ ":${PATH}:" != *":/usr/local/bin:"* ]]; then
  echo "Warning, the /usr/local/bin is not in PATH. Adding it to PATH..."
  export PATH="/usr/local/bin:${PATH}"
  check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
  echo ""

  # Make the change permanent by creating a file in /etc/profile.d
  echo "Making the change permanent by creating a script file in /etc/profile.d..."
  echo "export PATH=\"/usr/local/bin:${PATH}\"" >"/etc/profile.d/maxibuild.sh"
  check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
  echo ""

  # Make sure the file is executable
  echo "Making sure the script file in /etc/profile.d/maxibuild.sh is executable..."
  chmod +x "/etc/profile.d/maxibuild.sh"
  check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
  echo ""
else
  check_status 0
fi
echo ""

echo "Creating a bin directory in /usr/local/bin ..."
# Note it is safe to create this directory even if it already exists
mkdir -p /usr/local/bin
check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
echo ""

echo "Creating a symbolic link to maxibuild in /usr/local/bin ..."
ln -s /usr/local/maxicode/maxibuild/maxibuild /usr/local/bin
check_status "$?" " [OK]" " [FAILED]" "exit_on_failed"
echo ""

maxibuild --version
echo ""

# We need to reload this script to make sure that you can use the maxibuild command immediately without restarting the terminal
echo "Reloading terminal ..."
exec bash
