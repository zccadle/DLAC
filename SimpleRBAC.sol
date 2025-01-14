// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ZKPVerifier.sol";

contract SimpleRBAC {
    ZKPVerifier public zkpVerifier;

    // Mapping from user address to role
    mapping(address => string) private roles;

    // Mapping from role to permissions
    mapping(string => mapping(string => bool)) private rolePermissions;

    // Events
    event RoleAssigned(address indexed user, string role);
    event PermissionGranted(string role, string permission);
    event PermissionRevoked(string role, string permission);

    // Constructor to initialize the ZKP Verifier
    constructor(address _zkpVerifierAddress) {
        zkpVerifier = ZKPVerifier(_zkpVerifierAddress);
    }

    // Assign a role to a user
    function assignRole(address user, string memory role) public {
        roles[user] = role;
        emit RoleAssigned(user, role);
    }

    // Grant a permission to a role
    function grantPermission(string memory role, string memory permission) public {
        rolePermissions[role][permission] = true;
        emit PermissionGranted(role, permission);
    }

    // Revoke a permission from a role
    function revokePermission(string memory role, string memory permission) public {
        rolePermissions[role][permission] = false;
        emit PermissionRevoked(role, permission);
    }

    // Check if a user has a specific role
    function hasRole(address user, string memory role) public view returns (bool) {
        return keccak256(abi.encodePacked(roles[user])) == keccak256(abi.encodePacked(role));
    }

    // Check if a role has a specific permission
    function hasPermission(string memory role, string memory permission) public view returns (bool) {
        return rolePermissions[role][permission];
    }

    // Verify access using ZKP
    function verifyAccess(
        uint[2] calldata proofA,
        uint[2][2] calldata proofB,
        uint[2] calldata proofC,
        uint256[] calldata publicInputs
    ) public view returns (bool) {
        return zkpVerifier.verifyProof(proofA, proofB, proofC, publicInputs);
    }

    // Check if the caller has a specific permission
    function hasPermissionForCaller(string memory permission) public view returns (bool) {
        string memory role = roles[msg.sender];
        return rolePermissions[role][permission];
    }
}
