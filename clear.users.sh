for i in `seq -w 01 17`; do rm /home/szkolenie$i/.ssh/vault_pass_11.txt; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/szkolenie3 -rf; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/facts_cache -rf; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/.bash_history; done
for i in `seq -w 01 17`; do echo > /home/szkolenie$i/.ssh/vault_pass_11.txt; done
for i in `seq -w 01 17`; do chmod 666 /home/szkolenie$i/.ssh/vault_pass_11.txt; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/test_git -rf; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/*git* -rf; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/*stworz* -rf; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/*playbooks* -rf; done
for i in `seq -w 01 17`; do rm /home/szkolenie$i/*szkolenie* -rf; done

