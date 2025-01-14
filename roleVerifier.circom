template RoleProof() {
    signal input hashedRole;          // Hash of the user's role
    signal input hashedPermission;    // Hash of the required permission
    signal output isValid;            // Boolean output

    isValid <== (hashedRole == hashedPermission); // Check if hashes match
}

component main = RoleProof();
