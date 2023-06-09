// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract FactoryV1 {
    event Deploy(address addr, uint256 salt);

    function deploy(bytes memory code, uint256 salt) public {
        address addr;
        assembly {
            addr := create2(
                0, // amount to sent to new contract
                add(code, 0x20), // ost
                mload(code), // len
                salt // salt
            )
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        emit Deploy(addr, salt);
    }
}
