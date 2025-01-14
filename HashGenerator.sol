// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HashGenerator {
    // Hash a role using keccak256
    function hashRole(string memory role) public pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(role)));
    }

    // Hash a permission using keccak256
    function hashPermission(string memory permission) public pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(permission)));
    }
}
