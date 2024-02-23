# Flow Fungible Token Project Repository

Welcome! This repository is your one-stop solution for implementing a complete Fungible Token contract on the Flow blockchain. It houses a collection of transactions and scripts, neatly organized into various sections, each addressing a different aspect of token management and interaction.

## Core Contract Implementation

The core contract, named FlowToken, includes:

- An owner-controlled minting process.
- A Vault resource that maintains token balances.
- A comprehensive array of transactions and scripts for efficient token management.

The deposit function within the Vault resource is a key feature, ensuring secure token transfer and preventing double-counting.

## Fundamental Transactions and Scripts

### Transactions

- MINT: Enables the minting of tokens to specified recipients.
- SETUP: Simplifies the process of initializing a user's vault in account storage.
- TRANSFER: Allows users to transfer tokens to various addresses.

### Scripts

- READ BALANCE: Fetches the token balance in a user’s vault.
- SETUP VALIDATION: Verifies the correct setup of the vault.
- TOTAL SUPPLY CHECK: Displays the total circulating supply of tokens.

## Transaction and Script Enhancements

We have improved the SETUP transaction to fix improperly set up vaults and enhanced the READ BALANCE script for compatibility with non-standard vault setups.

## Key Features

- Resource identifiers for token type verification.
- Resource capabilities for validating vault authenticity.

## Contract and Transaction Augmentation

### Admin Capabilities

The Admin has the power to withdraw tokens from user vaults and deposit equivalent $FLOW tokens.

### New Transaction

- Admin Withdraw and Deposit: This is an Admin-exclusive transaction for managing tokens.

## Advanced Scripting

### Scripts

- BALANCE SUMMARY: Provides a summary of a user’s $FLOW and custom token vault balances.
- VAULT OVERVIEW: Gives a detailed overview of all recognized Fungible Token vaults in a user’s storage.

## Swap Contract Integration

The Swap Contract allows users to exchange $FLOW tokens for custom tokens, based on the duration since their last exchange. It uses a custom identity resource and the user's $FLOW vault reference to authenticate user identity and facilitate secure token swaps.

## Project Conclusion

This repository serves as a comprehensive guide to deploying a Fungible Token contract on the Flow blockchain. It systematically outlines functionalities, including token minting, vault setup, token transfer, and token swapping, ensuring enhanced comprehensibility and ease of navigation.
