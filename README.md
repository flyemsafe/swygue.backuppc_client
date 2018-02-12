swygue-backuppc
===============

- Installs BackupPC Server.
- Setup a host to be a BackupPC client.
- Add the host to the BackupPC Server hosts file.

Requirements
------------

The role most likely only works on RHEL based systems.

- BackupPC Server user ssh public key is needs for clients authorized_keys file.

Role Variables
--------------

### Installation Types

**backuppc_server: false**

Setting this to true will install the BackupPC server.
 - Creates BackupPC user.
 - Optional: Generates ssh-keys.
 - Installs and configure Apache.
 - Installs and configure BackupPC server from RPM.

**backuppc_client: false**

Setting this to true will setup a host to be a BackupPC client.
 - Creates BackupPC user.
 - Adds BackupPC Server user ssh public key to authorized_keys.
 - Adds sudoers rule for rsync --server.

**add_backuppc_client: false**
 - Add/Remove backup client to /etc/BackupPC/hosts
 - Creates a host.pl file under /etc/BackupPC/pc/<hostname>

### BackupPC User

Pick a system uid/gid for use on your BackupPC server and clients.
This is also useful if you are /var/lib/BackuPC is on a NFS share.
You adding this user to the NFS server takes care of uid/gid mapping.

Refer to:[What's the difference between a normal user and a system user?](https://unix.stackexchange.com/questions/80277/whats-the-difference-between-a-normal-user-and-a-system-user/80279

backuppc_uid:
backuppc_gid:
backuppc_ssh_key_comment: "BackupPC Server"
backuppc_user: backuppc
backuppc_group: backuppc
backuppc_user_comment: 'BackupPC User'
backuppc_home: /var/lib/BackupPC

**generate_ssh_key: yes**
Change this to yes to generate ssh keys for BackupPC user.

**ssh_pub_key_file:**
Set this to the BackupPC server public key. required for setting up clients.

### Shell for BackupPC user

**backuppc_shell: /sbin/nologin**
No need to change this for server installs. However, for clients, set this to a valid shell such as **/bin/bash**.

### Client Configuration

**xfermethod: rsync**

Hash with specific key/value (usefull for custom directives)

**more:**

Default files (directories) list to backup

include_files:
  - /root
  - /etc

# default files (directories) list to exclude in backup
exclude_files:
  - /cgroup
  - /data
  - /lost+found

backuppc_hosts:
  - hostname: host01.example.com
    shortname: host01
    include_files: "{{ include_files }}"
    exclude_files: "{{ exclude_files }}"
    xfermethod: "{{ xfermethod }}"
    more: "{{ more }}"
  - hostname: 192.168.3.78
    shortname: host02


Dependencies
------------

None.

Example Playbook
----------------

Example 1: Setup a Client and add to BackupPC server

```
---
- name: setup backup clients for backuppc ssh user
  hosts: linux-server
  gather_facts: false
  vars_files:
    - extra_vars/backuppc-client.yml

  tasks:
  - name: setup backuppc user and group
    include_role:
       name: swygue-backuppc
    vars:
      backuppc_client: true

#######################################
- name: add backup client to backuppc server
  hosts: backuppc
  vars_files:
    - extra_vars/backuppc-client.yml

  tasks:
  - name: run tasks to add clients on backuppc server
    include_role:
       name: swygue-backuppc
    vars:
      add_backuppc_client: true
```


License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).