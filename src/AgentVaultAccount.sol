// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {BaseAccount} from "account-abstraction/core/BaseAccount.sol";
import {IEntryPoint} from "account-abstraction/interfaces/IEntryPoint.sol";

error ZeroAddress();


abstract contract AgentVaultAccount is BaseAccount {
    address public immutable owner;
    IEntryPoint private immutable entryPointRef;

    constructor(address owner, address entryPointReference) {
        if (owner == address(0) || entryPointReference == address(0)) {
            revert ZeroAddress();  
        } 
    }

    function entryPoint() public view override returns(IEntryPoint) {
        return entryPointRef;
    }


}