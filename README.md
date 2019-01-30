swygue.backuppc_client
===============

Configures a system to be a BackupPC client.
 - Adds the backuppc server public ssh key to the client system
 - Adds the client to the servers /etc/BackupPC/pc/
 - Modifies /etc/BackupPC/pc/hosts

Requirements
------------

The role most likely only works on RHEL based systems.

- The SSH keys for the backuppc server user.

Role Variables
--------------
|                                                    	| Required 	| Default Value                	| Options                                                                                           	| Description                                        	|
|----------------------------------------------------	|:----------	|:------------------------------|:---------------------------------------------------------------------------------------------------	|----------------------------------------------------:|
| backuppc_server                                    	| yes      	|                              	|                                                                                                   	| Inventory name of the BackupPC server              	|
| backuppc_server_ssh_key                            	| yes      	|                              	|                                                                                                   	| Path to backuppc user ssh pub file                 	|
| backuppc_client_user                               	| yes      	| root                         	|                                                                                                   	| BackupPC will ssh to the client as this user       	|
| backup_schedule_status                             	| yes      	| enabled                      	| enabled/disabled                                                                                  	| Enable or disable the client from schedule backups 	|
| backuppc_server_user                               	| yes      	| backuppc                     	|                                                                                                   	| User BackupPC runs as                              	|
| backuppc_hosts   - hostname:     alias:     state: 	| yes      	| state=present                	| hostname: FQDN for the backup client alias: alternative name for the client state: present/absent 	| Sets up /etc/BackupPC/pc/hosts                     	|
| backuppc_test_command                              	| yes      	| yes, check defaults/main.yml 	| modify to your needs                                                                              	| BackupPC command executed to verify setup          	|

Dependencies
------------

None.

Example Playbook
----------------

Example 1: Setup a Client and add to BackupPC server

```
- hosts: client
  remote_user: root
  become: true

  roles:
    - { role: swygue-backuppc-client, tags: [ 'backup' ] }
```


License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
