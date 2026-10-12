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

Then import the existing `yogistorage` resource group if it is not already in
state:

```sh
terraform import azurerm_resource_group.storage /subscriptions/<AZURE_SUBSCRIPTION_ID>/resourceGroups/yogistorage
```

If the `yogialphastorage321` storage account already exists and is not in state,
import it as well:

```sh
terraform import azurerm_storage_account.main /subscriptions/<AZURE_SUBSCRIPTION_ID>/resourceGroups/yogistorage/providers/Microsoft.Storage/storageAccounts/yogialphastorage321
```

After importing, run `terraform plan` and confirm the proposed changes before
allowing the pipeline to apply them.