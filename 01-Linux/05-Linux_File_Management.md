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

## 5.1 Understanding the Linux Filesystem

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

## 5.2 Navigating the Filesystem
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
## 5.3 Listing Files

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

## 5.4 Creating Files and Directories

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

## 5.5 Copying Files

Copy File:

```
cp file.txt backup.txt
```

Copy Directory:

```
cp -r folder backup_folder
```
- -r = recursive

## 5.6 Moving and Renaming Files

Move File:

```
mv file.txt /home/roy/
```
Rename File:

```
mv oldname.txt newname.txt
```

## 5.7 Deleting Files and Directories

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

## 5.8 Viewing File Content

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

## 5.9 Searching Within Files

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


## 5.10 Searching for Files

Find Command:

```
find /home -name file.txt
```

Find directories:

```
find / -type d -name "project"
```

## 5.11 File Information

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

## 5.12 Links 

In Linux, a link is a way to reference a file from another location without duplicating the file’s data.

There are two types of links:

- Hard Links

- Soft Links (Symbolic Links)


Hard Link:

```
ln original.txt hardlink.txt
```
A hard link is another name for the same file.

It does NOT create a copy.
It creates a second directory entry that points to the same inode (same data on disk).
Now both files will appear separate, but they share the same underlying data.

If you delete:
```
rm original.txt
```
hardlink.txt still contains the data because the data is not removed until all hard links are deleted.

### Key Characteristics

- Shares same inode
- Cannot cross filesystems
- Survives deletion of original

Soft (Symbolic) Link:

```
ln -s original.txt symlink.txt
```

A soft link is like a shortcut.

It does NOT point to the inode. It points to the file path.

You will see something like:
```
symlink.txt -> original.txt
```
If you delete:

```
rm original.txt
```

Then:

```
cat symlink.txt
```

You will get:

```
No such file or directory
```

Because the link only stored the path, not the data.

### Key Characteristics

- Points to path
- Can cross filesystems
- Breaks if original is deleted


### What Is an Inode?

An inode is a data structure that stores:

- File permissions
- Owner
- Group
- Size
- Timestamps
- Disk location

When you create a hard link, both filenames share the same inode.

Check inode numbers:

```
ls -li
```
If two files have the same inode number → they are hard links.

### Real-World Use Cases

### Soft Links

- Creating shortcuts
- Linking configuration files
- Linking current version of an application

### Hard Links

- Backup systems
- Efficient file storage
- Snapshot-style systems


# 5.13 File Ownership 

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

## 5.14 Best Practices in Production

- Always use absolute paths in scripts
- Avoid rm -rf in production without verification
- Regularly monitor disk usage (df -h)
- Use less instead of cat for large files
- Restrict file access using proper ownership and groups

# 5.15 File management Guide in Linux

### File and Directory Management
1. **`ls`** – Lists files and directories in the current location.
2. **`cd /path/to/directory`** – Changes the working directory.
3. **`pwd`** – Prints the current working directory.
4. **`mkdir new_folder`** – Creates a new directory.
5. **`rmdir empty_folder`** – Removes an empty directory.
6. **`rm file.txt`** – Deletes a file.
7. **`rm -r folder`** – Deletes a folder and its contents.
8. **`cp file1.txt file2.txt`** – Copies a file.
9. **`cp -r dir1 dir2`** – Copies a directory recursively.
10. **`mv old_name new_name`** – Moves or renames a file or directory.

### File Viewing and Editing
11. **`cat file.txt`** – Displays file content.
12. **`tac file.txt`** – Displays file content in reverse order.
13. **`less file.txt`** – Opens a file for viewing with scrolling support.
14. **`more file.txt`** – Similar to `less`, but only moves forward.
15. **`head -n 10 file.txt`** – Displays the first 10 lines of a file.
16. **`tail -n 10 file.txt`** – Displays the last 10 lines of a file.
17. **`nano file.txt`** – Opens a simple text editor.
18. **`vi file.txt`** – Opens a powerful text editor.
19. **`echo 'Hello' > file.txt`** – Writes text to a file, overwriting existing content.
20. **`echo 'Hello' >> file.txt`** – Appends text to a file without overwriting.


