# Linux User Management

Linux is a multi-user operating system designed to allow multiple users and services to operate simultaneously. Effective user management ensures security, 
accountability, and controlled access to system resources.

This module demonstrates practical and administrative-level knowledge of:

- Creating and modifying users

- Understanding authentication files

- Managing passwords and policies

- Group and privilege management

- Using Vim for system configuration

- Permission enforcement and accountability

- Secure privilege escalation

## 5.1 Core User Management Files

Linux stores user and authentication data in the following system files:

```
| File           | Purpose                     |
| -------------- | --------------------------- |
| `/etc/passwd`  | Stores user account details |
| `/etc/shadow`  | Stores encrypted passwords  |
| `/etc/group`   | Stores group definitions    |
| `/etc/gshadow` | Stores secure group data    |

```

## 5.2 Creating Users

### useradd vs adduser

### (i) useradd 

- Low-level utility

- Non-interactive

- Does NOT set password automatically

- May not create home directory unless -m is used

Example:
```
useradd roy
```
Create with home directory:
```
useradd -m roy

```
Specify shell:

```
useradd -m -s /bin/bash roy

```
You must manually set password:

```
passwd roy

```
### (ii) adduser (Debian-based systems) 

- Higher-level, interactive wrapper around useradd

- Creates home directory automatically

- Prompts for password

- Assigns default group

- More user-friendly

```
adduser roy

```
### Key Difference

```
| useradd               | adduser            |
| --------------------- | ------------------ |
| Low-level             | High-level wrapper |
| Minimal configuration | Interactive setup  |
| Requires manual steps | Automates setup    |

```
## Viewing Created Users

After creating a user, verify it using:

```
cat /etc/passwd

```
Example entry:
```
roy:x:1001:1001::/home/roy:/bin/bash
```
Structure:
```
username : password_placeholder : UID : GID : comment : home_directory : shell
```
- The x indicates that the actual encrypted password is stored in /etc/shadow.

## 5.3 Managing Passwords

Set or change password:

```
passwd username

```
Confirm encrypted password creation:

```
sudo cat /etc/shadow

```
Example:

```
roy:$6$asd9f8a7sd9f8a7sd9f8a7...:19400:0:99999:7:::

```
- The long string represents a hashed password, not plaintext.

Can Passwords Be Decrypted?

- No.

Passwords in /etc/shadow are stored as one-way cryptographic hashes.

- They cannot be decrypted.

- They cannot be restored if lost.

- If forgotten, they must be reset using passwd.

This ensures system security.

## 5.4 Using Vim to View System Files

Vim (Vi Improved) is a powerful terminal-based text editor used to:

- Edit configuration files

- Modify system files

- Write scripts

- Administer servers

It is commonly used in Linux environments without a graphical interface.

### Installing Vim

On Debian/Ubuntu:

```
apt update
apt install vim

```

Opening a System File:

```
vim /etc/passwd

```

### Exiting Vim

Press Esc first.

Then:

Quit (no changes):

```
:q

```
Force quit:

```
:q!

```

Save and quit:

```
:wq

```

Alternative:

```
ZZ
```
OR 

```
x
```
If stuck recording macro:
Press:

```
q
```
## 5.5 Demonstrating Permission Enforcement

Create a new user:

```
adduser testuser

```
Switch to user:

```
su - testuser

```
Attempt to delete a system directory:

```
rm -rf /root

```
You will receive:

```
Permission denied

```
This demonstrates:

- Users do not have administrative rights by default

- Access control is enforced

- User management ensures accountability

## 5.6 Switching and Logging Out

Switch user:

```
su - username

```
Exit back:

```
exit

```
OR

```
logout

```
- Both commands terminate the current login session.

## 5.7 Modifying Users

Change username:

```
usermod -l newname oldname

```
Change home directory:

```
usermod -d /new/home -m username

```
Change default shell:

```
usermod -s /bin/zsh username

```

## 5.8 Deleting Users

Delete user only:

```
userdel username

```

Delete user and home directory:

```
userdel -r username

```

## 5.9 Group Management

A group in Linux is a collection of users that share common permissions. Instead of assigning permissions individually to every user, administrators assign permissions to a group, and then add users to that group.

This simplifies access control and improves scalability in multi-user environments.

### Why Groups Are Important

Groups provide:

- Centralized permission management

- Role-based access control

- Separation of duties

- Improved accountability

- Scalability in enterprise environments

Example:
Instead of giving 10 developers access to a project directory individually, you:

- Create a group called developers

- Assign permissions to the group

- Add users to the group

## Primary vs Secondary Groups

### (i) Primary Group

- Assigned when a user is created

- Stored in /etc/passwd

- Used by default when creating files

### (ii) Secondary (Supplementary) Groups

- Additional groups a user belongs to

- Stored in /etc/group

- Provide additional permissions

Create group:

```
groupadd developers

```

Add user to group:

```
usermod -aG developers username

```
View group membership:

```
groups username

```

Change primary group:

```
usermod -g developers username

```

## 5.10 Sudo and Privilege Escalation

Grant sudo access (Debian):

```
usermod -aG sudo username

```

RHEL:

```
usermod -aG wheel username

```
Edit sudoers safely:

```
visudo

```

## Granting Specific Command Access with sudo

In production systems, you often do not want to give full administrative privileges to a user. Instead, you may want to allow them to run only specific commands.

This is done by modifying the sudoers file.

### Why Use visudo?

Never edit /etc/sudoers directly using vim or nano.

Instead, use:
```
visudo
```
### Why?

- It performs syntax checking.

- It prevents multiple simultaneous edits.

- It protects the system from configuration errors that could break sudo access.

- If you make a syntax mistake in /etc/sudoers, you could lock yourself out of administrative access.

### Basic sudoers Rule Structure:

Grant specific command access:

```
username ALL=(ALL) NOPASSWD: /path/to/command

```
Breakdown:

```
| Part               | Meaning                              |
| ------------------ | ------------------------------------ |
| `username`         | The user receiving privileges        |
| `ALL`              | Hostname (applies to all hosts)      |
| `(ALL)`            | The user they can run the command as |
| `NOPASSWD:`        | No password required                 |
| `/path/to/command` | Exact command allowed                |

```
Example 1 – Allow Restarting Nginx Only:

```
roy ALL=(ALL) /usr/bin/systemctl restart nginx
```
This allows user roy to run:

```
sudo systemctl restart nginx
```
But NOT:

```
sudo rm -rf /
sudo apt install package
```
Only that specific command is permitted.

## Granting Group-Based Command Access

Instead of assigning permissions per user, you can assign them to a group:

```
%developers ALL=(ALL) /usr/bin/systemctl restart nginx
```
The % symbol indicates a group.

All users in the developers group inherit that permission.

### Security Best Practices

- Avoid giving full ALL=(ALL) ALL access unless necessary.

- Restrict commands to full absolute paths.

- Avoid wildcards (*) in sensitive environments.

- Use groups instead of individual user rules when possible.

- Regularly audit the sudoers file.

  
## 5.11 Account Security and Lifecycle

Lock account:

```
usermod -L username

```

Unlock account:

```
usermod -U username

```
Set expiration date:

```
chage -E YYYY-MM-DD username

```

View aging policy:

```
chage -l username

```

## 5.12 Why User Management Matters

Effective user management ensures:

- Controlled system access

- Role-based privilege separation

- Accountability of actions

- Protection of critical system directories

- Prevention of unauthorized modifications

It is foundational to:

- Production server management

- Cloud infrastructure

- Containerized environments

- DevOps security practices

Linux user management is a critical pillar of secure system administration.
