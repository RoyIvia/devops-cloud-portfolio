# Linux File Management

Linux file management is the foundation of system administration. Every configuration, log, application, and service in Linux is represented as a file.

Understanding Linux file management is essential for working in server environments, containers, and production systems, as it shows how to:

- Create files and directories

- Navigate the filesystem

- Copy, move, and delete files

- Search and filter file content

- Inspect file metadata

- Manage links

- Control file visibility

## 6.1 Understanding the Linux Filesystem

Linux follows a hierarchical directory structure starting at:
```
/
```
This is called the root directory.

Important directories:

```
| Directory | Purpose                    |
| --------- | -------------------------- |
| `/home`   | User home directories      |
| `/root`   | Root user’s home           |
| `/etc`    | Configuration files        |
| `/var`    | Logs and variable data     |
| `/usr`    | User programs and binaries |
| `/bin`    | Essential command binaries |
| `/tmp`    | Temporary files            |
```
Everything in Linux is treated as a file, including devices and processes.

## 6.2 Navigating the Filesystem
Print Working Directory:
```
pwd
```
- Shows your current location.

Change Directory:

```
cd /path/to/directory
```
Examples:

```
cd /home  
cd ..          # move one level up
cd ~           # Go to home directory
cd /           # Go to root directory
```
## 6.3 Listing Files

Basic Listing:

```
ls
```
Detailed Listing:

```
ls -l
```
Shows:
- Permissions
- Owner
- Group
- Size
- Timestamp

Show Hidden Files:

```
ls -la
```
- Hidden files begin with .

## 6.4 Creating Files and Directories

Create Empty File:

```
touch file.txt
```
Create Directory:

```
mkdir myfolder
```
Create nested directories:

```
mkdir -p project/src/components
```

## 6.5 Copying Files

Copy File:

```
cp file.txt backup.txt
```

Copy Directory:

```
cp -r folder backup_folder
```
- -r = recursive

## 6.6 Moving and Renaming Files

Move File:

```
mv file.txt /home/roy/
```
Rename File:

```
mv oldname.txt newname.txt
```

## 6.7 Deleting Files and Directories

Remove File:

```
rm file.txt
```

Remove Directory:

```
rm -r folder
```

Force Delete:

```
rm -rf folder
```
- Extremely powerful as it can permanently delete system files.

## 6.8 Viewing File Content

Display Entire File:

```
cat file.txt
```

Paginated View:

```
less file.txt
```
Quit with:
```
q
```
A paginated view means:

Instead of printing the entire file at once (like cat does), the file is displayed one screen at a time.

This is extremely useful for:
- Large log files
- Configuration files
- System files
- Any file longer than your terminal screen

Basic Controls in less:
```
| Key        | Action              |
| ---------- | ------------------- |
| Space      | Next page           |
| b          | Previous page       |
| Arrow keys | Scroll line by line |
| /keyword   | Search forward      |
| n          | Next match          |
| q          | Quit                |
```

View First Lines:

```
head file.txt
```

View Last Lines:

```
tail file.txt
```

Follow log in real time:

```
tail -f /var/log/syslog
```

- Instead of just displaying the last few lines and exiting, the terminal stays open and continuously updates whenever new content is written to the file.

## 6.9 Searching Within Files

Search Text:

```
grep "keyword" file.txt
```

Case insensitive:

```
grep -i "keyword" file.txt
```

Recursive search:

```
grep -r "keyword" /etc
```
Recursive search means searching inside a directory and all of its subdirectories. Not just the current folder but everything inside it, no matter how deep.

### searching Without -r

If you run:

```
grep "keyword" file.txt
```
It searches only inside that single file.

If you try:

```
grep "keyword" /etc
```
You’ll get something like:

```
grep: /etc: Is a directory
```
Because /etc is a folder, not a file.

### Searching With -r (Recursive)

```
grep -r "keyword" /etc
```

Now Linux will:

- Open /etc

- Search every file inside it

- Then open every subdirectory

- And search every file inside those too

It keeps going down the directory tree automatically.
That is what recursive means.


## 6.10 Searching for Files

Find Command:

```
find /home -name file.txt
```

Find directories:

```
find / -type d -name "project"
```

## 6.11 File Information

Check File Type:

```
file filename
```
View Disk Usage:

```
du -h file.txt
```

View Free Disk Space:

```
df -h
```

## 6.12 Links 

Hard Link:

```
ln original.txt hardlink.txt
```
- Shares same inode
- Cannot cross filesystems
- Survives deletion of original

Soft (Symbolic) Link:

```
ln -s original.txt symlink.txt
```

- Points to path
- Can cross filesystems
- Breaks if original is deleted

# 6.13 File Ownership 

Every file has:

- Owner

- Group

- Permissions

View with:

```
ls -l
```

Change owner:

```
chown user file.txt
```

Change group:

```
chgrp group file.txt
```

## 6.14 Best Practices in Production

- Always use absolute paths in scripts
- Avoid rm -rf in production without verification
- Regularly monitor disk usage (df -h)
- Use less instead of cat for large files
- Restrict file access using proper ownership and groups

