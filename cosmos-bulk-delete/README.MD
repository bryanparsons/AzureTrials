# Overview
Demonstrates how to use *ComosDB* PowerShell module for bulk CRUD operations on Cosmos

# How to install the Powershell module?
- Install-Module -Scope CurrentUser -Name CosmosDB

# Accompanying scripts
- DeleteAllRecords.ps1
- PopulateCollection.ps1

# Essential parameters in Common.ps1
Remember to change the following to suit your environment
- Set-StrictMode -Version "2.0"
- $ErrorActionPreference="Stop"
- $Global:CosmosResourceGroup="rg-demo-cosmos-serverless"
- $Global:CosmosAccountName="democosmosserverless"
- $Global:CosmosDatabase="CustomerManagement"
- $Global:CosmosContainer="customers"
- $Global:Location="uksouth"

# How to run the accompanying PowerShell scripts?
- Clone this repo to your PC
- Navigate to the folder which contains this README.MD file
- Launch PowerShell Core
- Ensure you have the core modules installed (see below)
- Change the variables in *Common.ps1* to point to your Cosmos account
- Authenticate to Azure using Azconnect (the account must have permissions to Cosmos and the IP address you are connecting from may need to be whitelisted)

## Populate the container with JSON
- Populate your json documents into the subfolder nameed json
- Run **PopulateCollection.ps1**. You should now see 2 documents created

## Purge all documents in the container
- Edit **DeleteRecords.ps1**, editing the query to return the documents you wish to delete
- Run **DeleteRecords.ps1**

# PowerShell modules neccessary
- Az.Accounts - to install run: Install-Module -Scope CurrentUser -Name Az.Accounts
- Az.Resources - to install run: Install-Module -Scope CurrentUser -Name Az.Resources
- Az.CosmosDb - to install run: Install-Module -Scope CurrentUser -Name Az.CosmosDb
- CosmosDb - to install run: Install-Module -Scope CurrentUser -Name CosmosDB