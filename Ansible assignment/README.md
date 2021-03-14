# Task 4 - Ansible assignment
## Initial requirements for the remote machine
* update and upgrade done or installed openssh-client 
* copied public key to /.ssh/authorized_key from ansible VM

## Some settings for the Ansible machine
Update and upgrade
```sh
 sudo apt update
 sudo apt upgrade
```
Install Ansible
```sh
 sudo apt install -y ansible
```
Create a ssh key and copy the public key to remote server. 
```sh
ssh-keygen
```
Make the directory "ansible" and copy there ansible.cfg
```sh
 mkdir /home/debian/ansible
```
Create a file hosts  where we describe information about connecting to a remote server.
Create a file playbook1.yml 
### Ansible-vault
Encrypt the password for the user in playbook.yml
```sh
 ansible-vault encrypt_string
```
### Deploying the app
Run the deploy playbook.
```sh
 ansible-playbook playbook1.yml --ask-voult-pass
```



