# Linux File Permissions

Linux automatically sets up basic file permissions when new files and directories are created. File permissions determine who can read, write, or execute files and directories, ensuring security and accountability.

Each file and directory has three levels of permission:

- Owner (User) – Creator of the file.

- Group – Users in the file’s assigned group.

- Others – All other users on the system.

Permissions are represented as:

```
| Permission | Symbol | Value | Description                       |
| ---------- | ------ | ----- | --------------------------------- |
| Read       | r      | 4     | View contents of a file           |
| Write      | w      | 2     | Modify contents of a file         |
| Execute    | x      | 1     | Run scripts or access directories |

```

Viewing Permissions

To check file permissions:

```
ls -l filename
```

Example output:

```
-rwxr--r-- 1 user group 1234 Mar 28 10:00 myfile.sh
```


Adding Users & Checking Permissions

Create a new user:

```
sudo adduser demo
```

Verify creation:

```
cat /etc/passwd | grep demo
```

Switch to new user:

```
su - demo
```

Check directory permissions:

```
ls -ltr
```

-l → long listing format

-t → sort by modification time

-r → reverse order (oldest first, newest last)

### Explanation of ls -ltr output:

```-``` → file type (d for directory, - for regular file)

rwxr--r-- → permissions for user, group, others

1 → number of links

user → owner

group → group name

1234 → file size in bytes

Mar 28 10:00 → last modification time

myfile.sh → filename

- Note: Newly created users cannot modify files they don’t own. This demonstrates the role of permissions in accountability.

Logout from a user session:
```
logout
```

Executing Files

To execute a script:
```
./script.sh
```

- You can only if execute (x) permission is set for your user.

## Changing Permissions with chmod

Symbolic Mode

Modify permissions using symbols:

```
chmod u+x filename       # Add execute for user
chmod g-w filename       # Remove write for group
chmod o=r filename       # Set read-only for others
chmod u=rwx,g=rx,o= filename  # Set multiple permissions at once
```

- u = user (owner)

- g = group

- o = others

## Numeric (Octal) Mode

```
| Number | Permissions |
| ------ | ----------- |
| 0      | ---         |
| 1      | --x         |
| 2      | -w-         |
| 3      | -wx         |
| 4      | r--         |
| 5      | r-x         |
| 6      | rw-         |
| 7      | rwx         |

```

Example:

```
chmod 755 filename  # User rwx, Group r-x, Others r-x
chmod 644 filename  # User rw-, Group r--, Others r--
```

- Use + to add, - to remove, = to set exactly.

- NOTE : Folder permissions apply before individual file permissions inside them.


Changing Ownership

Only root can use chown:

```
sudo chown newuser filename          # Change owner
sudo chown newuser:newgroup filename # Change owner and group
sudo chown :newgroup filename        # Change only group

```

Recursive ownership change:
- A recursive ownership change modifies the owner (and/or group) of a directory and everything inside it, including all subdirectories and files.

Without recursion, only the specified directory changes, not its contents.

```
sudo chown -R newuser:newgroup folder/

```

Example:
```
sudo chown -R developer:developer ubuntu-data
```

What Happens;

-R → Recursive (applies to everything inside)

developer:developer → New owner and group

ubuntu-data → Target directory

After running this, all files and subdirectories inside ubuntu-data will belong to developer.


Recursive ownership is commonly used when:

- Fixing permission errors

- Preparing project folders

- Managing web server directories

- Resetting ownership after copying files as root

Change group only:

```
sudo chgrp newgroup filename
sudo chgrp -R newgroup folder/
```
## Special Permissions

### SetUID

- Allows users to run a file with the file owner's privileges.

Example: /usr/bin/passwd lets users change passwords.

### SetGID

Files: run with group privileges.

Directories: files created inherit the directory’s group.

```
sudo chmod g+s filename
sudo chmod g+s directory/
```

### Sticky Bit

Only the file owner can delete their files in a directory.
```
chmod +t directory/

```

Example: /tmp directory.

## Default Permissions: umask

- umask defines the default permissions for newly created files/directories.

Default file permissions: 666 → rw-rw-rw-

Default directory permissions: 777 → rwxrwxrwx

umask subtracts from these defaults:

```
umask 022
```

- Files: 666 - 022 = 644 → rw-r--r--

- Directories: 777 - 022 = 755 → rwxr-xr-x

Visual representation:

```
Default Permissions
Files:      666  → rw-rw-rw-
Directories:777 → rwxrwxrwx

Apply umask 022:
  - 0 removes nothing for owner
  - 2 removes write for group
  - 2 removes write for others

Final Permissions:
Files:       644  → rw-r--r--
Directories: 755  → rwxr-xr-x
```
## Folder Permissions Come First

Important rule:

Even if a file has full permissions, you cannot access it if the parent directory does not allow access.

Example:

If directory has:

drwx------

Other users cannot enter it, even if files inside are 777.

Directory permissions must allow:

x → to enter

r → to list

w → to create/delete files


Linux file permissions are essential for security and accountability. Understanding and managing permissions with chmod, chown, chgrp, umask, and special bits like SetUID, SetGID, and Sticky Bit ensures:

- Only authorized users can modify files

- Group access is controlled

- Default permissions are secure

- Scripts and directories behave safely


