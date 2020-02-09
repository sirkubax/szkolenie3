set -x

ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=apache02 role=frontend"
ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=apache01 role=frontend"
ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=backend01 role=backend"

#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress01_szk16 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress01_szk01 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress01_szk02 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress01_szk03 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress01_szk04 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress01_szk05 role=wordpress"
#
#
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk16 role=mysql"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk01 role=mysql"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk02 role=mysql"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk03 role=mysql"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk04 role=mysql"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk05 role=mysql"
#
#
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk16 role=loadbalancer"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk01 role=loadbalancer"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk02 role=loadbalancer"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk03 role=loadbalancer"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk04 role=loadbalancer"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk05 role=loadbalancer"
#
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress02_szk16 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress02_szk01 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress02_szk02 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress02_szk03 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress02_szk04 role=wordpress"
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wodrpress02_szk05 role=wordpress"
#
#for i in `seq -w 01 17`; do ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wordpress01_szk$i role=wordpress"; done
#for i in `seq -w 01 17`; do ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=mysql01_szk$i role=mysql"; done
#for i in `seq -w 01 17`; do ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=loadbalancer01_szk$i role=loadbalancer"; done
#for i in `seq -w 01 17`; do ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=wordpress02_szk$i role=wordpress"; done
#ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.large hostname=awx role=awx"

for i in `seq -w 01 8`; do ansible-playbook playbooks/create_aws_instance.yml -e "type=t2.nano hostname=naszaaplikacja01_szk$i role=naszaaplikacja"; done
