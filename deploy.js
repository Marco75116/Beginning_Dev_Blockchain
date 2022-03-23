const HDWaletteProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const {abi,evm} = require('./compile');

const provider = new HDWaletteProvider(
    'put motion math warfare furnace verify tuition nut annual punch cost loud',
    'https://rinkeby.infura.io/v3/00e46f3ce2d8433daecdd8006aaf1c95',
);

const web3 = new Web3(provider);

const deploy = async() => {
    const accounts = await web3.eth.getAccounts();
    console.log(accounts[0]);
    let balance = await web3.eth.getBalance(accounts[0]);
    console.log(balance);

    const result = await new web3.eth.Contract(abi).deploy( {data:evm.bytecode.object})
    .send({from : accounts[0], gas:'1000000'});

    //console.log(result);
    console.log('Contract deployed to', result.options.address);
    console.log('ABI : ------------------------------');
    console.log(abi);
    console.log('---------------------');
    
    provider.engine.stop();
}

deploy();