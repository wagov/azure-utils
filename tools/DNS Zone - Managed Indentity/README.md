# Azure DNS Zone Cert Deployment - Managed Identity

A simple bash script to authenticate against a exisiting A records in Azure DNS Zones to a authorised Azure VMs for Let Encrypts SSL Certs Generation (Certbot) via Azure Managed Indentity.

## Prerequisite
- Azure VM - Linux
- Azure DNS Zones

## Setup

### Azure VM

1. Deploy a new [Azure VM](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal) or use existing.
1. Once VM is setup, in Azure portal, navigate to the desired Virtual Machine and select **Identity**.
1. Under System assigned, **Status**, select **On** and then click **Save**.

>Take note of the ***Public IP address*** resource name associated to the VM. This will be used to for A record association to Azure DNS zones.

### Azure DNS Zones

1. Deploy a new [Azure DNS Zones](https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-portal) service or use existing.
1. Once Azure DNS Zones is set, in Azure Portal, navigate to the top of the **DNS zone** page, select **+ Record set**.
1. On the **Add record set** page, type or select the following values:

   - **Name**: Add a Domain Name.
   - **Type**: Select **A**. 
   - **Alias record set**: Select *Yes*.
     - **Alias Type**: Select **Azure Resource**.
     - **Choose a subscription**: Select **DGov Sentinel**.
     - **Azure Resoruce**: Under **Public IP Address** tab, Select the resoruce associated to the previously mentioned VM.
   - **TTL**: Type **5**.
   - **TTL Unit**: Select **Minutes**.
1. Once the record is filled, click **OK**.
1. Naviuagte to the **IAM** blade, select **+ Add**, then **add new role assignment**.
1. Select role of **DNS Zone Contributor**.
1. In the **Assign access to**, select **Managed Indentity**
1. Click **+ Sleect Members**, type the Azure VM managed Indentity (VM Name), click **Select**.
1. Finalise by Clicking **Review + assign**.

## Deployment

1. Once ready to deploy script, [connect to the Azure VM](https://docs.microsoft.com/en-us/azure/virtual-machines/ssh-keys-portal#connect-to-the-vm)
1. Run the following command in the VM terminal ```sudo git clone https://raw.githubusercontent.com/wagov/azure-utils/main/tools/DNS%20Zone%20-%20Managed%20Indentity/azure_dns_vm_cert.sh | chmod +x azure_dns_vm_cert.sh | ./azure_dns_vm_cert.sh```
1. Follow the prompts to fill in the required Azure credentials to finalise Certbot deployment.