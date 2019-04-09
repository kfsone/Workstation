#! /bin/bash
##
## DEPRECATED
##

echo "~~~ NOTE: DEPRECATED"
echo "~~~ NOTE: DEPRECATED"
echo "~~~ NOTE: DEPRECATED"
echo

DEFAULT_VENV="${DEFAULT_VENV:-.venv3}"

. "${WSHOME:-$HOME/Workstation}/lib/shell-utils.sh"

set_behavior -o

cd "${HOME}"

if [ "${1}" = "-y" ]; then
  APT_ACK="$1" ; shift
fi

chmod go-rwx "${HOME}/.ssh/"*

#### Configure apt proxy
#
proxy_file="/etc/apt/apt.conf.d/02proxy"
if [ ! -f "${proxy_file}" ]; then
  color_message 2 "* Configuring ${proxy_file}"
  echo "Acquire::Http::Proxy \"http://wafer.lan:3142/\";" | sudo tee "${proxy_file}"
fi


#### Fetch packages
#
color_message 2 "Apt Update"
sudo apt-get update -q || die "apt update failed"
color_message 2 "Apt Install"
sudo apt-get install ${APT_ACK} -q $(cat ${HOME}/etc/apt-packages.lst) || die "apt install failed"
color_message 2 "Apt Upgrade"
sudo apt-get upgrade ${APT_ACK} -q || die "apt upgrade failed"


#### Python and virtualenv setup
#
for ver in 2 3; do
  color_message 2 "Updating Python${ver} packages"
  sudo -H pip${ver} install -q --upgrade $(pip${ver} list --format=columns | awk '{print $1}') \
    || die "pip${ver} install failed"

  venv=".venv${ver}"
  color_message 2 "Setting up Python${ver}'s ${venv}"
  if [ ! -d "${venv}" ]; then
    virtualenv -p python${ver} "${venv}"
  fi
  set_behavior +o
  . "${venv}"/bin/activate
  pip install -q --upgrade $(pip list -o --format=columns | awk '{print $1}')
  pip install -q --upgrade ipython jupyter[notebook] numpy scipy nose
  pip install -q --upgrade Cython matplotlib pandas psutil urllib3 requests
  pip install -q --upgrade fire flashtext scikit-learn
  deactivate
  set_behavior -o
done

if [ ! -f ".defenv" ]; then
  color_message 2 "Setting ${DEFAULT_VENV} as default venv"
  echo "${DEFAULT_VENV}" >.defenv
fi

if [ ! -d "Projects" ]; then mkdir Projects; fi
if [ ! -d "Dev" ]; then mkdir Dev; fi

if [ ! -f ".vim/plugin/editorconfig" ]; then
  color_message 2 "Enabling vim editorconfig"
  vim-addons install editorconfig
fi

for ver in 2 3; do
  color_message 2 "Installing fancy python packages"
done

