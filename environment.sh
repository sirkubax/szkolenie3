#! /bin/bash
export ANS_ROOT_DIR="$(readlink -m $(readlink -m "$(dirname "${BASH_SOURCE[0]}")"))"
export EC2_INI_PATH=$ANS_ROOT_DIR/etc/inv/ec2.ini
export ANSIBLE_VAULT_PASSWORD_FILE=~/.ssh/vault_pass_11.txt
#export ANSIBLE_SSH_CONTROL_PATH="/tmp/ansible-ssh-$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c8)-%%h-%%p-%%r"
export ANSIBLE_CONFIG="$(pwd)/ansible.cfg"
#export ANSIBLE_KEEP_REMOTE_FILES=1


while getopts ":i" __optarg; do
  case "$__optarg" in
    i)
      __install_requirements=true
      ;;
  esac
done


if [ -z "$VIRTUAL_ENV" ]; then
  if ! [ -d $ANS_ROOT_DIR/venv ]; then
    echo '-- No virtualenv detected; creating'
    virtualenv $ANS_ROOT_DIR/venv --python=python3 || (echo '!!! virtualenv creation failed' && return)
    mkdir ~/.ansible
    mkdir ~/facts_cache
    touch ~/.ssh/vault_pass_11.txt
    __venv_created=true
  fi
  source $ANS_ROOT_DIR/venv/bin/activate
fi


if [ "$__venv_created" = true ] || [ "$__install_requirements" = true ]; then
  echo '-- Installing requirements'
  pip install -r $ANS_ROOT_DIR/requirements.txt || (echo '!!! pip install failed' && return)
fi


if ! declare -f __old_deactivate 2>&1 > /dev/null; then
  __old_deactivate_source=$(declare -f deactivate)
  eval "__old_deactivate${__old_deactivate_source#deactivate}"
  function deactivate {
    __old_deactivate
    unset ANS_ROOT_DIR
    unset EC2_INI_PATH
    unset __old_deactivate
  }
fi


unset OPTIND
unset __optarg
unset __venv_created
unset __install_requirements
