// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {OwnerSignatureVerifier} from "../src/OwnerSignatureVerifier.sol";

contract OwnerSignatureVerifierTest is Test {
    OwnerSignatureVerifier verifier;

    uint256 alicePrivateKey = 111;
    uint256 bobPrivateKey = 222;

    function setUp() public {
        address alice = vm.addr(alicePrivateKey);
        address bob = vm.addr(bobPrivateKey);
        verifier = new OwnerSignatureVerifier(address(alice));
    }

    function testValidOwnerSignature() public view {
        bytes32 digest = keccak256("hello");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(alicePrivateKey, digest);
        bytes memory signature = abi.encodePacked(r, s, v);
        bool result = verifier.isValidOwnerSignature(digest, signature);
        assertTrue(result);
    }

    function testInvalidOwnerSignature() public {
        bytes32 digest = keccak256("124343382744744");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(bobPrivateKey, digest);
        bytes memory signature = abi.encodePacked(r, s, v);
        bool result = verifier.isValidOwnerSignature(digest, signature);
        assertFalse(result);
    }
}
