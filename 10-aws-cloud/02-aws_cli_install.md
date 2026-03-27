## Installing AWS CLI v2 on Ubuntu (Including Containers)

In modern Ubuntu environments (especially Ubuntu 24.04 and ARM-based systems), the `awscli` package may not be available via `apt`. 
To ensure a consistent and up-to-date installation, AWS CLI v2 should be installed using the official AWS distribution.

This method works reliably in:
- local Linux machines
- Docker containers
- cloud instances (EC2, etc.)

## Install required dependencies:

```bash
apt update
apt install -y curl unzip
```

## Installation Steps (ARM64 Systems)

### 1. Download AWS CLI v2

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
```

### 2. Extract the Installer

```bash
unzip awscliv2.zip
```

### 3. Run the Installer

```bash
./aws/install
```

### 4. Verify Installation

```bash
aws --version
```

Expected output:

```bash
aws-cli/2.x.x Python/3.x Linux/... exe/...
```

## Installation Steps (x86_64 Systems)

If running on x86 (non-ARM systems), use:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

The remaining steps are the same.

## Optional: Clean Up Installation Files

```bash
rm -rf aws awscliv2.zip
```

## Notes

- AWS CLI v2 is not always available via `apt` in newer Ubuntu releases
- Installing via the official AWS package ensures:
  - latest version
  - consistent behaviour across environments
  - compatibility with AWS services
