#PoC MVP

Example of run dynamically some task for ALL groups defined in the inventory, one host per group at a time (in parallel for all groups)

It is like serial:1 - but for all groups 


This is achieved with async - you can print logs using results_file
Unfortunatelly I did not find a way to run (import_playbook) in a loop
