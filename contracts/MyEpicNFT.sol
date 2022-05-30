// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// importing OpenZeppelin Contract
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // This is our SVG code. All we need to change is the word that's displayed. Everything else stays the same.
    // So, we make a baseSvg variable here that all our NFTs can use.
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    
    // I create three arrays, each with their own theme of random words.
    // Pick some random funny words, names of anime characters, foods you like, whatever!
    string[] firstWords = ["weight", "presidest","ore","fumbling","subsequent","eatable","fish","sleep","temporary","save","juvenile""wind"];
    string[] secondWords = ["opposite","tight","build","cheek","sheep","collar","buffet","constraint","reaction","pawn","survey","meeting"];
    string[] thirdWords = ["bomber","dead","freight","security","paralyzed","accurate","relax","feminist","eat","crevice","negative","easy"];

    constructor() ERC721("wordNFT", "ONE-OF-A-KIND") {
        console.log("Yo, my NFT contract is ready !!");
    }

    function pickRandomFirstWord(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));

        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    // get random number
    function random(string memory input) internal pure returns(uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeEpicNFT() public {
        // Get current token Id
        uint256 newItemId = _tokenIds.current();

        // We go and randomly grab one word from each of the three arrays.
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory finalText = string(abi.encodePacked(first, " ", second, " ", third));
        
        // I concatenate it all together, and then close the <text> and <svg> tags.
        string memory finalSvg = string(abi.encodePacked(baseSvg, first, " ", second, " ", third, "</text></svg>"));

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name": "',
                // We set the title of our NFT as the generated word.
                finalText,
                '", "description": "Only you have the power to hold this NFT, its as uniique as you","image": "data:image/svg+xml;base64,',
                // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                Base64.encode(bytes(finalSvg)),
                '"}'
            )
        );

        // appending 'data:application/json;base64' in the front od JSON
        string memory finalTokenURI = string(
            abi.encodePacked("data:application/json;base64,",json)
        );

        console.log("\n--------------------");
        console.log(finalTokenURI);
        console.log("--------------------\n");


        // Minting
        _safeMint(msg.sender, newItemId);

        // Set NFT meta data
        _setTokenURI(
            newItemId,
            finalTokenURI
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
