const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    // Call the function
    let txn = await nftContract.makeEpicNFT()
    await txn.wait()
    console.log("Minted #0 NFT !!")

    // Mint more NFT's
    txn = await nftContract.makeEpicNFT()
    await txn.wait()
    console.log("Minted #1 NFT !!")
};


const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();