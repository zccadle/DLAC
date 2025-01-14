// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the Groth16Verifier contract
import "./Verifier.sol";

contract ZKPVerifier {
    Groth16Verifier verifier;

    // Constructor to initialize the Groth16Verifier contract
    constructor(address verifierAddress) {
        verifier = Groth16Verifier(verifierAddress);
    }

    // Verify ZKP proof
    function verifyProof(
        uint[2] calldata proofA,
        uint[2][2] calldata proofB,
        uint[2] calldata proofC,
        uint256[] calldata publicInputs
    ) public view returns (bool) {
        require(publicInputs.length == 1, "Invalid publicInputs length");
        uint256[1] memory fixedInputs;
        fixedInputs[0] = publicInputs[0];

        return verifier.verifyProof(proofA, proofB, proofC, fixedInputs);
}
}
