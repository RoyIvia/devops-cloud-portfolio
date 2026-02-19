# Linux Folder Structure 

A robust understanding of the Linux filesystem is critical for any DevOps engineer or systems administrator. This section demonstrates expertise in navigating Linux environments, understanding file organization, and managing users and permissions efficiently.  

The Linux folder structure is hierarchical, starting from the root `/` directory, and organizes system files, application binaries, user data, and configuration files into standard locations. Mastery of this structure ensures clarity in system management, effective troubleshooting, and secure user administration.

## 4.1 Core Navigation & File Commands

### `ls` = List Directory Contents

- Displays files and directories in the current location.

### `cd` = Change Directory

- Moves between directories.

```
| Command | Meaning                  |
| ------- | ------------------------ |
| `cd /`  | Go to root directory     |
| `cd ..` | Go up one level          |
| `cd ~`  | Go to home directory     |
| `cd -`  | Go to previous directory |

```
### `ln` = Create Links

- Creates hard or symbolic links.

#### Hard link:

```
ln file1 file2

```
- Points directly to the same inode (same underlying file data)

- Both names reference the exact same file

- If one is deleted, the other still works

- Cannot span different filesystems

  
#### Symbolic (soft) link:

```
ln -s /path/to/original /path/to/link

```
- Acts like a shortcut

- Stores the path to the original file

- Has its own inode

- Can span different filesystems

- Becomes broken if the original file is deleted

### Key Difference

- Hard link = another name for the same file

- Soft link = a pointer to a file path

### `cat` – Display File Contents

```
cat filename.txt

```
- Read file contents

- View configuration files

- Quick inspection of scripts

## 4.2 File vs Directory

```
| Type      | Purpose                                       |
| --------- | --------------------------------------------- |
| File      | Stores data (text, binaries, scripts, images) |
| Directory | Organizes files and other directories         |
```
- Files contain data.

- Directories store references to files and subdirectories.

Create a file:

```
touch file.txt
```

Create a directory:

```
mkdir folder
```

## 4.3 Advanced ls Usage

### ls -l = Long Listing Format

```
ls -l
```
Shows:

- File type (d for directory, - for regular file, l for symbolic link)

- Permissions (rwx)

- Owner and group

- File size

- Last modified date

### ls -a = Show Hidden Files

```
ls -a
```
Displays all files including hidden ones (starting with .), e.g.:
.bashrc
.profile
.git

### ls -la = Long + Hidden Files
```
ls -la
```
Combines long listing and hidden files — commonly used in Linux troubleshooting.

### ls -ltr = Sort by Time (Oldest First)

```
ls -ltr

```
Flags:
```
| Flag | Meaning                   |
| ---- | ------------------------- |
| `-l` | Long listing              |
| `-t` | Sort by modification time |
| `-r` | Reverse order             |
```

- Shows oldest files first

- Useful for tracking log updates and file changes

## 4.4 Linux Folder Structure

Linux uses a single-rooted filesystem tree starting at /

```
/
├── bin
├── boot
├── dev
├── etc
├── home
├── lib
├── proc
├── usr
└── var

```

## 4.5 System Directories


### **Important System Directories**
| Directory | Description |
|-----------|-------------|
| `/boot` | Stores files needed for booting the system (not relevant in containers). |
| `/usr` | Contains most user-installed applications and libraries. |
| `/var` | Stores logs, caches, and temporary files that change frequently. |
| `/etc` | Stores system configuration files. |

### **Symbolic Links (Less Significant)**
| Directory | Description |
|-----------|-------------|
| `/sbin -> /usr/sbin` | System binaries for administrative commands (linked to `/usr/sbin`). |
| `/bin -> /usr/bin` | Essential user binaries (linked to `/usr/bin`). |
| `/lib -> /usr/lib` | Shared libraries and kernel modules (linked to `/usr/lib`). |


### **User & Application-Specific Directories**
| Directory | Description |
|-----------|-------------|
| `/home` | Default location for user home directories. |
| `/opt` | Used for installing optional third-party software. |
| `/srv` | Holds data for services like web servers (rarely used in containers). |
| `/root` | Home directory for the root user. |

### **Temporary & Volatile Directories**
| Directory | Description |
|-----------|-------------|
| `/tmp` | Temporary files (cleared on reboot). |
| `/run` | Holds runtime data for processes. |
| `/proc` | Virtual filesystem for process and system information. |
| `/sys` | Virtual filesystem for hardware and kernel information. |
| `/dev` | Contains device files (e.g., `/dev/null`, `/dev/sda`). |

### **Mount Points**
| Directory | Description |
|-----------|-------------|
| `/mnt` | Temporary mount point for external filesystems. |
| `/media` | Mount point for removable media (USB, CDs). |
| `/data` | Likely your **mounted volume** from Windows (`C:/ubuntu-data`). |

