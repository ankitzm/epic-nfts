// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// importing OpenZeppelin Contract
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("MarvelNFT", "ONE-OF-A-KIND") {
        console.log("Yo, my NFT contract is ready !!");
    }

    function makeEpicNFT() public {
        // Get current token Id
        uint256 newItemId = _tokenIds.current();

        // Minting
        _safeMint(msg.sender, newItemId);

        // Set NFT meta data
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiQ2FwdGFpbk5GVCIsCiAgICAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIGZyb20gdGhlIGhpZ2hseSBhY2NsYWltZWQgc3F1YXJlIGNvbGxlY3Rpb24iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBZ0lEeHpkSGxzWlQ0dVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJGdWN5MXpaWEpwWmpzZ1ptOXVkQzF6YVhwbE9pQXhOSEI0T3lCOVBDOXpkSGxzWlQ0S0lDQWdJRHh5WldOMElIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SW1Kc1lXTnJJaUF2UGdvZ0lDQWdQSFJsZUhRZ2VEMGlOVEFsSWlCNVBTSTFNQ1VpSUdOc1lYTnpQU0ppWVhObElpQmtiMjFwYm1GdWRDMWlZWE5sYkdsdVpUMGliV2xrWkd4bElpQjBaWGgwTFdGdVkyaHZjajBpYldsa1pHeGxJajVEUVZCVVFVbE9QQzkwWlhoMFBnbzhMM04yWno0Igp9"
        );

        // Increment Counter - unique id
        _tokenIds.increment();

        console.log(
            "An NFT with ID %s has been minted by %s",
            newItemId,
            msg.sender
        );
    }
}
