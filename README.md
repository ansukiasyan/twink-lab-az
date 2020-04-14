# Get started with Azure vm setup and configuration using Terraform and cloud-config

The goal of the project is to set multiple virtual machines up and running using Terraform and do a post-install configuration on them using cloud-config in Azure. The project has implemented terraform best practices and is being continuously improved.

## Set Terraform up and running

Current environment used to execute this project code is the WSL. So all the steps and commands described below will be specific to the WSL environment.

To setup terraform on WSL, please follow the appropriate section in the [Terraform official installation guide](https://learn.hashicorp.com/terraform/getting-started/install.html). 

Another option for installing terraform on the WSL environment is the tfenv terraform version manager. This tool provides you the opportunity to execute code written in any version of terraform on your environment. Please, see the [tfenv github repo](https://github.com/tfutils/tfenv) for further details. 

## Login to Azure

There are multiple ways of giving terraform access to your Azure account. The one that seemed the easiest and the most secure one, that doesn't require storing the credentials in the code, is running terraform code from a shell after logging to your Azure account with the Azure CLI. 

To login to Azure, run the following command using [Azure Cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest). This command will open a browser window to perform the authentication. 

```bash
$ az login
```
After you sign in to your Microsoft account a message will appear saying: "You have logged into Microsoft Azure!"

To see some alternative methods of authentication for Azure using Terraform, please reffer to the [Terraform official documentation](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html). 

## Execute the terraform code to create the VMs

Clone the current repo to your local environment by executing the command below after replacing the github_url placeholder with this repository url. 

```bash
$ git clone github_url
```

The next step is to run the code by executing the following commands in the given order

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

If all 3 commands run successfully, all resources will be created in your Azure account and you will be able to see them in the [Azure portal](https://portal.azure.com/). 



  
