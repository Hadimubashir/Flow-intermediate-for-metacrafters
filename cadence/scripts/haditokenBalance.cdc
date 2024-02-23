import FungibleToken from 0x05
import haditoken from 0x05

pub fun main(account: Address) {

    // Attempt to borrow PublicVault capability
    let publicVault: &haditoken.Vault{FungibleToken.Balance, FungibleToken.Receiver, haditoken.CollectionPublic}? =
        getAccount(account).getCapability(/public/Vault)
            .borrow<&haditoken.Vault{FungibleToken.Balance, FungibleToken.Receiver, haditoken.CollectionPublic}>()

    if (publicVault == nil) {
        // Create and link an empty vault if capability is not present
        let newVault <- haditoken.createEmptyVault()
        getAuthAccount(account).save(<-newVault, to: /storage/VaultStorage)
        getAuthAccount(account).link<&haditoken.Vault{FungibleToken.Balance, FungibleToken.Receiver, haditoken.CollectionPublic}>(
            /public/Vault,
            target: /storage/VaultStorage
        )
        log("Empty vault created")
        
        // Borrow the vault capability again to display its balance
        let retrievedVault: &haditoken.Vault{FungibleToken.Balance}? =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&haditoken.Vault{FungibleToken.Balance}>()
        log(retrievedVault?.balance)
    } else {
        log("Vault already exists and is properly linked")
        
        // Borrow the vault capability for further checks
        let checkVault: &haditoken.Vault{FungibleToken.Balance, FungibleToken.Receiver, haditoken.CollectionPublic} =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&haditoken.Vault{FungibleToken.Balance, FungibleToken.Receiver, haditoken.CollectionPublic}>()
                ?? panic("Vault capability not found")
        
        // Check if the vault's UUID is in the list of vaults
        if haditoken.vaults.contains(checkVault.uuid) {
            log(publicVault?.balance)
            log("This is a haditoken vault")
        } else {
            log("This is not a haditoken vault")
        }
    }
}