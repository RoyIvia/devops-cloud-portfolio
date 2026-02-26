# AWS Service Interactions 

This section demonstrates practical ways to interact with **AWS services** using:

1. AWS Management Console  
2. AWS CLI  
3. CloudFormation templates  
4. Shell scripting  
5. Python automation with Boto3  

It shows how a DevOps engineer can manage cloud infrastructure efficiently and automate tasks.


## 1️. AWS Management Console

The AWS Management Console is the **graphical user interface** for interacting with AWS services. While suitable for small tasks, it becomes **time-consuming for multiple resources** or automation.

**Example:**

- Launch an EC2 instance via Console:
  1. Go to EC2 → Launch Instance.  
  2. Choose an AMI (Amazon Linux 2).  
  3. Select instance type (t2.micro).  
  4. Configure key pairs, security groups, and storage.  
  5. Launch the instance.  

- Create an S3 bucket via Console:
  1. Go to S3 → Create Bucket.  
  2. Enter bucket name `royston-portfolio-demo`.  
  3. Select region and other settings.  
  4. Click Create.

💡 **Limitation:** Manual process; not scalable for multiple instances or accounts.

---

## 2️. AWS CLI

AWS CLI allows **command-line interaction with AWS services**, enabling automation and repeatability.

**Setup & Verification:**
```bash
# Check AWS CLI installation
aws --version

# Configure CLI
aws configure

# Verify credentials
aws sts get-caller-identity
```

EC2 Examples:

List all EC2 instances
```
aws ec2 describe-instances
```

Launch an EC2 instance
```
aws ec2 run-instances \
    --image-id ami-0abcdef1234567890 \
    --count 1 \
    --instance-type t2.micro \
    --key-name my-key \
    --security-group-ids sg-0abc123 \
    --subnet-id subnet-0abc123
```
Connect via SSH
```
ssh -i "my-key.pem" ec2-user@<public-ip>
```

Stop, start, terminate

```
aws ec2 stop-instances --instance-ids i-0123456789abcdef0
aws ec2 start-instances --instance-ids i-0123456789abcdef0
aws ec2 terminate-instances --instance-ids i-0123456789abcdef0
```

S3 Examples:

```
aws s3 ls                       # List buckets
aws s3 mb s3://royston-demo     # Create bucket
aws s3 cp demo.txt s3://royston-demo/   # Upload file
aws s3 cp s3://royston-demo/demo.txt ./ # Download file
aws s3 sync ./local-folder s3://royston-demo/  # Sync folder
```

Explanation :

- CLI allows fast, repeatable tasks across multiple resources.

- Ideal for automation, CI/CD pipelines, and multi-cloud environments.
  

## 3️. CloudFormation

CloudFormation allows Infrastructure as Code (IaC) — declarative creation of AWS resources.

Example Template:

```
AWSTemplateFormatVersion: '2010-09-09'
Description: Simple S3 bucket creation

Resources:
  PortfolioBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: royston-cft-demo
```

# Deploy via CLI:

```
aws cloudformation create-stack \
    --stack-name royston-demo-stack \
    --template-body file://s3_bucket_template.yaml

aws cloudformation describe-stacks --stack-name royston-demo-stack
```

Explanation :

- Allows repeatable and version-controlled infrastructure setup.

- Supports multiple AWS resources in a single deployment.


## 4️. Shell Scripting for AWS

Shell scripting can automate repetitive AWS tasks using AWS CLI commands.

Example: Launch EC2 and upload file to S3

```
#!/bin/bash

# Launch EC2
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id ami-0abcdef1234567890 \
    --instance-type t2.micro \
    --key-name my-key \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "EC2 Instance launched: $INSTANCE_ID"
```


Wait for instance to be running
```
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
```
Create S3 bucket
```
aws s3 mb s3://royston-shell-demo
```

Upload file

```
aws s3 cp demo.txt s3://royston-shell-demo/
```

Explanation:

- Combines multiple AWS operations in a single automated workflow.

- Useful for DevOps pipelines or repeated deployments.


## 5️⃣ Python Automation with Boto3

Python with Boto3 enables programmatic AWS interactions, suitable for advanced automation.

Example :

```
import boto3

# Initialize clients
ec2 = boto3.client('ec2')
s3 = boto3.client('s3')

# Launch EC2 instance
response = ec2.run_instances(
    ImageId='ami-0abcdef1234567890',
    InstanceType='t2.micro',
    KeyName='my-key',
    MaxCount=1,
    MinCount=1,
    SecurityGroupIds=['sg-0abc123']
)
instance_id = response['Instances'][0]['InstanceId']
print(f"Launched EC2: {instance_id}")
```

Create S3 bucket
```
s3.create_bucket(Bucket='royston-python-demo')
```

Upload a file
```
s3.upload_file('demo.txt', 'royston-python-demo', 'demo.txt')

```

Explanation:

- Shows full automation capability with Python.

- Useful for scripting deployments, CI/CD pipelines, and multi-service operations.

# Summary

This portfolio section demonstrates multiple ways to interact with AWS services:

Real-world relevance:

These interaction methods are used in production for provisioning infrastructure, managing environments and automating cloud operations across teams and accounts.
