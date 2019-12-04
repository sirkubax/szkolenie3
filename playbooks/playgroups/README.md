#PoC MVP
# https://www.facebook.com/groups/929970120367781/permalink/2821854424512665/

Example of run dynamically some task for ALL groups defined in the inventory, one host per group at a time (in parallel for all groups)

It is like serial:1 - but for all groups 


This is achieved with async - you can print logs using results_file
Unfortunatelly I did not find a way to run (import_playbook) in a loop


RUN

```
cd szkolenie3

ansible-playbook playbooks/playgroups/play.yml -vvv --limit localhost -i etc/inv/inventory_groups
```
