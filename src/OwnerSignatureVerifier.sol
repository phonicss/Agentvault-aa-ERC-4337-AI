// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

error ZeroAddress();

contract OwnerSignatureVerifier {
    address public immutable owner;



    constructor (address _owner) {
        if(_owner == address(0)) revert ZeroAddress();
        owner = _owner;

    }

    function isValidOwnerSignature(
        bytes32 digest,
        bytes calldata signature
    ) external view returns (bool) {
        (address recovered, ECDSA.RecoverError err, ) = ECDSA.tryRecoverCalldata(digest, signature);
        bool validRecovery = err == ECDSA.RecoverError.NoError;
        bool correctSigner = recovered == owner;
        bool accepted = validRecovery && correctSigner;
        return accepted;
    }

}