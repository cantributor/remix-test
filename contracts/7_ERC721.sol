// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.26;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact alexeychub@gmail.com
contract CanNft is ERC721, Ownable {
    constructor(address initialOwner)
        ERC721("CanNft", "CFT")
        Ownable(initialOwner)
    {
        for (uint256 i = 0; i < 100; i++) {
            _safeMint(initialOwner, i);
        }

    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://cryptopunks.app/cryptopunks/details/";
    }
}