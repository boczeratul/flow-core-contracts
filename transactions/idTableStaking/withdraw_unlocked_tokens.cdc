import FlowIDTableStaking from 0xIDENTITYTABLEADDRESS
import FlowToken from 0xFLOWTOKENADDRESS


transaction(amount: UFix64) {

    // Local variable for a reference to the node object
    let stakerRef: &FlowIDTableStaking.NodeStaker

    let flowTokenRef: &FlowToken.Vault

    prepare(acct: AuthAccount) {
        // borrow a reference to the node object
        self.stakerRef = acct.borrow<&FlowIDTableStaking.NodeStaker>(from: /storage/flowStaker)
            ?? panic("Could not borrow reference to staking admin")

        self.flowTokenRef = acct.borrow<&FlowToken.Vault>(from: /storage/flowTokenVault)
            ?? panic("Could not borrow reference to FLOW Vault")

    }

    execute {

        self.flowTokenRef.deposit(from: <-self.stakerRef.withdrawUnlockedTokens(amount: amount))

    }
}