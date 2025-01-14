// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleRBAC.sol";

contract PatientDataStorage {
    SimpleRBAC rbac;

    struct PatientData {
        string encryptedData;
        string ownerDID;
    }

    mapping(string => PatientData) private patientRecords;

    constructor(address rbacAddress) {
        rbac = SimpleRBAC(rbacAddress);
    }

    function storeData(string memory patientDID, string memory encryptedData) public {
        require(rbac.hasRole(msg.sender, "Admin"), "Unauthorized access");
        patientRecords[patientDID] = PatientData(encryptedData, patientDID);
    }

    function retrieveData(string memory patientDID) public view returns (string memory) {
        require(rbac.hasRole(msg.sender, "Doctor"), "Unauthorized access");
        return patientRecords[patientDID].encryptedData;
    }
}
