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
Print Working Directory
```
pwd
```
Shows your current location.

Change Directory

```
cd /path/to/directory
```
Examples:

```
cd /home  
cd ..          # move one level up
cd ~
cd /
```
