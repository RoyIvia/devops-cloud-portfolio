# Disk and Storage Management in Linux

Disk and storage management is an essential skill for Linux system administrators and DevOps engineers. Servers rely heavily on proper storage configuration to maintain performance, reliability, and data availability.

Linux provides a rich set of tools for inspecting disks, creating partitions, formatting filesystems, mounting storage devices, and managing logical volumes.

This section documents commonly used Linux commands for managing disk storage in both traditional servers and cloud environments.

---

# Viewing Disk Information

Before modifying storage devices, always inspect the available disks.

## List Block Devices

```bash
lsblk
```

Shows disks, partitions, and mount points.

Example output:

```
NAME    SIZE TYPE MOUNTPOINT
sda     100G disk
├─sda1   96G part /
└─sda2    4G part [SWAP]
sdb      20G disk
```

---

## View Partition Table

```bash
fdisk -l
```

Displays detailed disk partition information.

---

## Display Filesystem UUIDs

```bash
blkid
```

Useful when configuring persistent mounts in `/etc/fstab`.

---

## Check Disk Space Usage

```bash
df -h
```

Shows available and used disk space.

Example output:

```
Filesystem      Size  Used Avail Use%
/dev/xvda1      100G   25G   70G  26%
```

---

## Check Directory Size

```bash
du -sh /var/log
```

Used to identify large directories.

---

# Partition Management

Disk partitioning divides a disk into separate sections.

## Create a Partition Using fdisk

```bash
sudo fdisk /dev/sdX
```

Inside the interactive menu:

```
n → create new partition
p → primary partition
w → write changes
```

Verify the result:

```bash
lsblk
```

---

## Partition GPT Disks with parted

```bash
sudo parted /dev/sdX
```

`parted` is preferred for disks larger than **2TB**.

---

# Formatting a Partition

After creating a partition, it must be formatted with a filesystem.

## Format ext4

```bash
sudo mkfs.ext4 /dev/sdX1
```

## Format XFS

```bash
sudo mkfs.xfs /dev/sdX1
```

XFS is commonly used in **enterprise and cloud systems such as Amazon Linux**.

---

# Mounting and Unmounting Filesystems

## Mount a Partition

```bash
sudo mount /dev/sdX1 /mnt
```

Verify mount:

```bash
df -h
```

---

## Unmount a Partition

```bash
sudo umount /mnt
```

---

## Remount Filesystem

```bash
sudo mount -o remount,rw /mnt
```

Used when switching from read-only to read-write.

---

# Persistent Mounts Using `/etc/fstab`

To automatically mount disks at boot, edit `/etc/fstab`.

Example:

```
UUID=abcd-1234   /data   ext4   defaults   0 0
```

Find UUID:

```bash
blkid
```

Test configuration before reboot:

```bash
sudo mount -a
```

---

# Logical Volume Management (LVM)

LVM provides flexible storage management and allows resizing volumes without repartitioning.

## Create a Physical Volume

```bash
sudo pvcreate /dev/sdb
```

---

## Create Volume Group

```bash
sudo vgcreate vg_data /dev/sdb
```

---

## Create Logical Volume

```bash
sudo lvcreate -L 10G -n lv_storage vg_data
```

---

## Format Logical Volume

```bash
sudo mkfs.ext4 /dev/vg_data/lv_storage
```

---

## Mount Logical Volume

```bash
sudo mount /dev/vg_data/lv_storage /mnt
```

---

# Swap Management

Swap acts as overflow memory when RAM is exhausted.

## Create Swap Partition

```bash
sudo mkswap /dev/sdX
```

---

## Enable Swap

```bash
sudo swapon /dev/sdX
```

Check swap:

```bash
swapon --show
```

---

## Disable Swap

```bash
sudo swapoff /dev/sdX
```

---

# Finding Large Files

When troubleshooting disk space issues:

```bash
sudo find / -type f -size +500M
```

Find files larger than 500MB.

---

# Disk Usage Analysis

## ncdu

Interactive disk usage viewer.

```bash
ncdu /
```

Useful for quickly locating large directories.

---

# Expanding Disks in Cloud Environments

In cloud environments such as AWS EC2, disks can be expanded without recreating servers.

Typical workflow:

## 1. Check Disk Size

```bash
lsblk
```

---

## 2. Extend Partition

```bash
sudo growpart /dev/xvda 1
```

---

## 3. Resize Filesystem

For ext4:

```bash
sudo resize2fs /dev/xvda1
```

For XFS:

```bash
sudo xfs_growfs /
```

---

# When to Use Each Tool

| Task                 | Command      |
| -------------------- | ------------ |
| View disks           | `lsblk`      |
| View partition table | `fdisk -l`   |
| Partition disk       | `fdisk`      |
| Format filesystem    | `mkfs`       |
| Mount storage        | `mount`      |
| Persistent mount     | `/etc/fstab` |
| Analyze disk usage   | `du`, `ncdu` |
| Flexible storage     | `LVM`        |

---

# Example Full Disk Setup Workflow

Provision a new disk from start to finish.

```bash
# Check available disks
lsblk

# Create partition
sudo fdisk /dev/sdb

# Format disk
sudo mkfs.ext4 /dev/sdb1

# Create mount point
sudo mkdir /data

# Mount disk
sudo mount /dev/sdb1 /data
```

---

# Key Takeaways

Disk management is critical for maintaining system stability and performance. Linux provides powerful tools for inspecting disks, managing partitions, mounting storage, and expanding capacity.

DevOps engineers frequently use these tools when managing infrastructure, debugging disk usage issues, and scaling storage in cloud environments.
