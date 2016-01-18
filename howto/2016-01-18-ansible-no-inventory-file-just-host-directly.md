# Run Ansible without inventory file
I want to run Ansible without specifying the inventory file through (ANSIBLE_HOST)

##  The trick is to append a ,

#### Host and IP address
ansible all -i example.com,

## OR

#### Requires 'hosts: all' in your playbook
ansible-playbook -i example.com, playbook.yml 
