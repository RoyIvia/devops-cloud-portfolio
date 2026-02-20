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

 useradd 

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
adduser (Debian-based systems) 

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

