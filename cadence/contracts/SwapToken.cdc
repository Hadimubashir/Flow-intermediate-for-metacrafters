import FungibleToken from 0x05
import FlowToken from 0x05
import haditoken from 0x05

// SwapToken contract: Facilitates token swapping between Vstoken and FlowToken
pub contract SwapToken {

    // Store the last swap timestamp for the contract
    pub var lastSwapTimestamp: UFix64
    // Store the last swap timestamp for each user
    pub var userLastSwapTimestamps: {Address: UFix64}

    // Function to swap tokens between Vstoken and FlowToken
    pub fun swapTokens(signer: AuthAccount, swapAmount: UFix64) {

        // Borrow haditoken and FlowToken vaults from the signer's storage
        let haditokenVault = signer.borrow<&haditoken.Vault>(from: /storage/VaultStorage)
            ?? panic("Could not borrow haditoken Vault from signer")

        let flowVault = signer.borrow<&FlowToken.Vault>(from: /storage/FlowVault)
            ?? panic("Could not borrow FlowToken Vault from signer")  

        // Borrow Minter capability from AlpToken
        let minterRef = signer.getCapability<&haditoken.Minter>(/public/Minter).borrow()
            ?? panic("Could not borrow reference to UhanmiToken Minter")

        // Borrow FlowToken vault capability for receiving tokens
        let autherVault = signer.getCapability<&FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider}>(/public/FlowVault).borrow()
            ?? panic("Could not borrow reference to FlowToken Vault")  

        // Withdraw tokens from FlowVault and deposit to autherVault
        let withdrawnAmount <- flowVault.withdraw(amount: swapAmount)
        autherVault.deposit(from: <-withdrawnAmount)
        
        // Get the signer's address and current timestamp
        let userAddress = signer.address
        self.lastSwapTimestamp = self.userLastSwapTimestamps[userAddress] ?? 1.0
        let currentTime = getCurrentBlock().timestamp

        // Calculate time since the last swap and minted token amount
        let timeSinceLastSwap = currentTime - self.lastSwapTimestamp
        let mintedAmount = 2.0 * UFix64(timeSinceLastSwap)

        // Mint new UhanmiTokens and deposit them to the vault
        let newVstokenVault <- minterRef.mintToken(amount: mintedAmount)
        haditokenVault.deposit(from: <-newVstokenVault)

        // Update the user's last swap timestamp
        self.userLastSwapTimestamps[userAddress] = timeSinceLastSwap
    }

    // Initialize the contract
    init() {
        // Set default values for last swap timestamp
        self.lastSwapTimestamp = 1.0
        self.userLastSwapTimestamps = {0x05: 1.0}
    }
}