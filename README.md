# GIt300

## Terraform state

Terraform state is stored in the `tfstate` container of the `terformyogistorage`
storage account in `terraform-state-rg`. Create the storage account and container
before initializing Terraform. The GitHub Actions service principal must have
`Storage Blob Data Contributor` access to the container, in addition to the
permissions it needs to manage the Azure resources.

Before the first pipeline run, initialize this backend using the same Azure
credentials configured for GitHub Actions. If you have an existing local state
file, migrate it into the backend:

```sh
terraform init -migrate-state
```

If there is no existing local state, initialize the backend with:

```sh
terraform init -reconfigure
```

The configuration looks up the existing `yogistorage` resource group and creates
only an App Service plan and Linux web app in it; it does not manage or recreate
the resource group or storage account. Both App Service resources are deployed
to `Southeast Asia`. The web app name `yogiwebapp` must be globally unique across Azure.
Confirm the Terraform plan shows only the App Service plan and web app before
allowing the pipeline to apply it.