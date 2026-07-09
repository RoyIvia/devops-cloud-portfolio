# Amazon Machine Images (AMI)

An Amazon Machine Image (AMI) is a preconfigured template used to launch Amazon EC2 instances. It serves as the blueprint for an EC2 instance by defining the operating system, software, configurations, storage mappings, and launch permissions. 
AMIs enable organizations to deploy identical EC2 instances repeatedly, ensuring consistency, scalability, and operational efficiency.

AMIs are fundamental to Infrastructure as Code (IaC), Auto Scaling Groups, disaster recovery strategies, golden image pipelines, and automated infrastructure provisioning.

An AMI consists of several components:

 - Operating System
   - Amazon Linux
   - Ubuntu
   - Windows Server
   - Red Hat Enterprise Linux
   - SUSE Linux
   - Custom operating systems

- Amazon EBS Snapshots
   - Snapshots of the root volume
   - Snapshots of additional EBS volumes (if included)
    
- Launch Permissions
   - Private
   - Shared with specific AWS accounts
   - Public
    
- Block Device Mapping - Defines which EBS volumes or instance store volumes are attached during launch.


AMI Architecture:

                   Amazon Machine Image

        +--------------------------------------+
        |           AMI Metadata               |
        +--------------------------------------+
        | Operating System                     |
        | Installed Applications               |
        | Configuration Files                  |
        | Boot Loader                          |
        | Block Device Mapping                 |
        +--------------------------------------+
                       │
                       ▼
              Amazon EBS Snapshots
                       │
                       ▼
                Launch EC2 Instance

                
