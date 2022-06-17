//////////////////////////////////////////
//                                      //
//          MAIN CONTRACT               //
//          III6 LifeAnd.Eth            //
//          stereoIII6                  //
//          stereodocbush@gmail.com      //
//                                      //
//////////////////////////////////////////

import { ethers } from "ethers"
import detectEthereumProvider from "@metamask/detect-provider"
import "../public/app.scss"
import { sha256 } from "crypto-hash"
import UAuth from '@uauth/js'
let accounts
let network
let user
const client = require("ipfs-http-client")
const ipfs = client.create({
  host: "ipfs.infura.io",
  port: "5001",
  protocol: "https",
})
const uauth = new UAuth({
    clientID: '101df3a0-41df-4c22-8edf-0cf4db92a61c',
    redirectUri: 'http://127.0.0.1:5000/callback',
  })

  uauth.user()
  .then((user) => {
    // user exists
    console.log("User information:", user)
  })
  .catch(() => {
    // user does not exist
  })
  
const affilly8 = require("../build/contracts/Affilly8.json")
const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
// links & buttons

// main navbar
const campaigns_btn = document.getElementById("campaigns_btn")
const links_btn = document.getElementById("links_btn")
const trxs_btn = document.getElementById("trxs_btn")
// defi navbar
const profile_btn = document.getElementById("profile_btn")
const wallet_btn = document.getElementById("wallet_btn")
const net_btn = document.getElementById("net_btn")

// subnav bar

// pagination

// stages
const campaign_stage = document.getElementById("campaign_stage")
const link_stage = document.getElementById("link_stage")
const tx_stage = document.getElementById("tx_stage")
const profile_stage = document.getElementById("tx_stage")
const wallet_stage = document.getElementById("tx_stage")
const net_stage = document.getElementById("tx_stage")

// navigation functions
const goCampaigns = (e) => {
  e.preventDefault()
  console.log("campaigns stage opened")
  campaign_stage.style.display = "grid"
  link_stage.style.display = "none"
  tx_stage.style.display = "none"
}

const goLinks = (e) => {
  e.preventDefault()
  console.log("links stage opened")
  campaign_stage.style.display = "none"
  link_stage.style.display = "grid"
  tx_stage.style.display = "none"
}

const goTxs = (e) => {
  e.preventDefault()
  console.log("txs stage opened")
  campaign_stage.style.display = "none"
  link_stage.style.display = "none"
  tx_stage.style.display = "grid"
}

const goProfile = (e) => {
  e.preventDefault()
  console.log("connected")
}

const onClickConnect = async (e) => {
  e.preventDefault()
  try {
    // set label for profile button
    console.log("connecting ...")
    profile_btn.innerHTML = "connecting ..."
    // set eventlistener for profile button
    profile_btn.removeEventListener("click", onClickConnect)
    profile_btn.addEventListener("click", goProfile)
    // get wallet address and account data of client and store in main state accounts
    accounts = await ethereum.request({ method: "eth_requestAccounts" })
    // get network data
    network = await ethereum.request({ method: "net_version" })
    var networkTag = "Switch Network"
    // evaluate legal networks
    if (Number(network) === 1) networkTag = "ETH"
    if (Number(network) === 137) networkTag = "Polygon"
    if (Number(network) === 100) networkTag = "xDai"
    if (Number(network) === 10) networkTag = "Optimism"
    if (Number(network) === 200) networkTag = "Arbitrum"
    if (Number(network) === 43224) networkTag = "Avalanche"
    if (Number(network) === 1312) networkTag = "ACAB"
    if (Number(network) === 80001) networkTag = "Mumbai"
    net_btn.innerHTML = networkTag;
    user = await log()
  } catch (error) {
    console.error("connect error", error)
    profile_btn.innerText = "Connect"
  }
}
const afl8Data = async () => {
  const deploymentKey = await Object.keys(affilly8.networks)[0];
  // console.log(affilly8.abi);
  return new ethers.Contract(
    affilly8.networks[deploymentKey].address,
    affilly8.abi,
    provider,
    signer
  );
};
 const log = async () => {
  console.log("logging ...")
  profile_btn.innerHTML = "logging ..."
  const afl8 = await afl8Data();
  // console.log(accounts[0]);
  // ask contract about user
  const isU = await afl8.amIuser().then(result => {
    console.log(result);
    return result;
  }).catch(err => {console.log(err)});
  console.log(isU);
  if (isU) {
    // is a user
    const user = await afl8.uData(signer)
    const role = await afl8.role(signer)
    console.log("loading data ...", user)
    profile_btn.innerHTML = "loading ..."
    console.log(user);
    if (false) {
      // user is admin
      
    }
    if (false) {
      // user is producer
    }
    if (false) {
      // user is promoter
    }
    if (false) {
      // user is guest
    } else {
      // user is new
    }
  }
  else{
      // is not a user
      console.log("try again ...", user)
    profile_btn.innerHTML = "try again ..."
  }
}
// unstoppable login tool
window.login = async () => {
    try {
      const authorization = await uauth.loginWithPopup()
   
      console.log(authorization)
    } catch (error) {
      console.error(error)
    }
  }


// navigation event listeners
campaigns_btn.addEventListener("click", goCampaigns)
links_btn.addEventListener("click", goLinks)
trxs_btn.addEventListener("click", goTxs)

/* IMPORTANT FUNCTION WEB3INIT DO NOT EDIT  //
//////////////////////////////////////////
//                                      //
//          Init Metamask               //
//                                      //
//////////////////////////////////////////


Function initializes dapp for Defi interaction

requirements :
- a button with id:'profile_btn'
- a button with id:'net_btn'
- a button with id: 'wallet_btn' 
- a div with class: 'stage' and id: 'profile_stage'

*/
const web3init = async () => {
  const isMetaMaskInstalled = () => {
    //Have to check the ethereum binding on the window object to see if it's installed
    const { ethereum } = window
    return Boolean(ethereum && ethereum.isMetaMask)
  }
  const clickInstall = (e) => {
    e.preventDefault()
    alert(
      "You are being redirected to the official download of Metamask.io ... Please Follow their installation instructions."
    )
    window.open("https://metamask.io")
  }
  const MetaMaskClientCheck = () => {
    //Now we check to see if MetaMask is installed
    if (!isMetaMaskInstalled()) {
      //If it isn't installed we ask the user to click to install it
      profile_btn.innerText = "install metamask!"
      profile_btn.addEventListener("click", clickInstall)
    } else {
      //If it is installed we change our button text
      profile_btn.innerText = "connect"
      profile_btn.addEventListener("click", onClickConnect)
    }
  }
  MetaMaskClientCheck()
}
// IMPRTANT INITIAL FUNCTION CALL
web3init()
// IMPORTANT FUNCTION WEB3INIT DO NOT EDIT END //
/*







const initialize = () => {
    //Basic Actions Section
    mlqButton.innerHTML =  " " + count;
    const isMetaMaskInstalled = () => {
        //Have to check the ethereum binding on the window object to see if it's installed
        const { ethereum } = window;
        return Boolean(ethereum && ethereum.isMetaMask);
    };
    const clickInstall = () => {
        alert("You are being redirected to the official download of Metamask.io ... Please Follow their installation instructions.");
        window.open("https://metamask.io");
    };
    const MetaMaskClientCheck = () => {
        //Now we check to see if MetaMask is installed
        if (!isMetaMaskInstalled()) {
        //If it isn't installed we ask the user to click to install it
        onboardButton.innerText = 'Click here to install MetaMask!';
        onboardButton.addEventListener("click",clickInstall);
        } else {
        //If it is installed we change our button text
        onboardButton.innerText = 'Connect';
        onboardButton.addEventListener("click",onClickConnect);
        }
    };
    MetaMaskClientCheck();
}
const onClickConnect = async () => {
    try {
      // Will open the MetaMask UI
      onboardButton.innerHTML = 'Connecting ...';
      // You should disable this button while the request is pending!
      await ethereum.request({ method: 'eth_requestAccounts' });
     // console.log("what");
     // const accounts = await ethereum.request({ method: 'eth_accounts' });
      const network = await ethereum.request({method: 'net_version'});
      var networkTag = "Switch Network";
    //We take the first address in the array of addresses and display it
                        if(Number(network) === 80001) networkTag =  "Mumbai";
                        if(Number(network) === 1) networkTag =  "ETH";
                        if(Number(network) === 137) networkTag =  "Polygon";
                        if(Number(network) === 100) networkTag =  "xDai";
                        if(Number(network) === 10) networkTag =  "Optimism";
                        if(Number(network) === 200) networkTag =  "Arbitrum";
                        if(Number(network) === 43224) networkTag =  "Avalanche";
                        if(Number(network) === 1312) networkTag = "ACAB";
    networkButton.innerHTML = networkTag;
    const UserData = await log();
    // console.log(UserData);
    
    } catch (error) {
      console.error(error);
      onboardButton.innerText = 'Connect';
    }
    
};
const onClickCreate = async () => {
    try {
        const memDat = await memData();
        const rando = await memDat.getRandomResult().then(result => { console.log(BigInt(result._hex)); return result; });
        fuid.value = rando._hex;
        // console.log(fuid.value);
        form.style.display = "block";

        formBtn.addEventListener("click",makeAMember);

    } catch (error) {
        console.error(error);
        onboardButton.innerText = 'Connect';
        onboardButton.removeEventListener("click",onClickCreate);
        onboardButton.addEventListener("click",onClickConnect);
      }
    
};
const makeAMember = async (e) => {
    try{
        const accounts = await ethereum.request({ method: 'eth_accounts' });
        const memDat = await memData();
        const dias = {
            id: fuid.value,
            name: fname.value,
            rank: frank.value,
            status: fstatus.value,
            bday: new Date(fbday.value).getTime(),
        }
        const DIAS = JSON.stringify(dias);
        console.log(DIAS);
        const membership = await memDat.makeMember(dias.name,dias.rank,dias.bday, DIAS ,dias.status).then(result => { return result; });
        form.style.display = "none";
        onboardButton.innerHTML = "<b>"+accounts[0].slice(0,5)+"..."+accounts[0].slice(38,42)+"</b>"; 
        onboardButton.removeEventListener("click",onClickCreate);
        // onboardButton.addEventListener("click",onClickGoPro);
    } catch (error) {
        console.error(error);
        form.style.display = "none";
        onboardButton.innerText = 'Connect';
        onboardButton.removeEventListener("click",onClickCreate);
        onboardButton.addEventListener("click",onClickConnect);
    }
};
const tellRank = (rank) => {
    let title;
    if(rank >= 11) title = "USER";
    if(rank >= 11) title = "MEMBER";
    if(rank >= 22) title = "AMATEUR";
    if(rank >= 33) title = "PRO";
    if(rank >= 44) title = "EXPERT";
    if(rank >= 55) title = "VIRTU0X0";
    if(rank >= 66) title = "MODERATOR";
    if(rank >= 77) title = "PARTNER";
    if(rank >= 88) title = "MANAGER";
    if(rank == 99) title = "ADMIN";
    return title;
};
const goMyPro = async (e) => {
    try {
        const accounts = await ethereum.request({ method: 'eth_accounts' });
        const memDat = await memData();
        myPro.style.display = "block";
        allMem.style.display = "none";
        const id = await memDat.slotId(accounts[0]).then(result => {return Number(result._hex);});
        console.log("my pro", id);
        const proData = await memDat.members(id - 1).then(result => {return result;});

        

        myPro.innerHTML = "<div id='board'><div id='proCard'><div id='name'>"+ proData.name +
                            "</div><div id='status'>"+ proData.status  +
                            "</div><div id='rank'>"+ tellRank(proData.rank)  +
                            "</div><div id='bday'>"+ proData.bday  +
                            "</div><div id='dias'>"+ proData.dias  +
                            "</div><div id='since'>"+ proData.since  +"</div><div id='steps'>"+ count   + " steps</div></div></div>";
        proCard.style.gridRow = 2;
        proCard.style.gridColumn = id;


    } catch(error) {
        console.error(error);
    }
};
const goAllMem = async (e) => {
    try {
        const memDat = await memData();
        allMem.style.display = "block";
        myPro.style.display = "none";
        const count = await memDat.countMem().then(result => {return Number(result._hex);});
        let addi = "";
        for(let i = 0; i < count-1; i++){
            console.log("all mem", i + 1);   
            const proData = await memDat.members(i).then(result => {return result;});
            addi += "<div id='proCard'>"+ (i + 1) + ' | '+ proData.name + " - "+ tellRank(proData.rank) +"</div>";
        }
        allMem.innerHTML = "<div id='board'>"+ addi +"</div>";
        
    } catch(error) {
        console.error(error);
    }
};
const log = async () => {
   
    const accounts = await ethereum.request({ method: 'eth_accounts' });
    const memDat = await memData();
    // const verify = await memDat.verify(accounts[0],"dynMem",);
    const sign = signer.signMessage("dynMem");
    const isUser = await memDat.isSigned().then(result => { console.log(result); return result; });
    const userId = Number(isUser._hex);
    // console.log(userId);
    if(userId === 0){
        // generate new random number 
        const vrfReq = await memDat.doRand().then(result => { return result; });
        onboardButton.innerHTML = "<b style='color:red'>create account</b>";  
        onboardButton.removeEventListener("click",onClickConnect);
        onboardButton.addEventListener("click",onClickCreate);
        onboardButton.disabled;
    }
    else {
        links.style.display = "block";
        onboardButton.innerHTML = "<b>"+accounts[0].slice(0,5)+"..."+accounts[0].slice(38,42)+"</b>"; 
        myProBtn.addEventListener("click",goMyPro);
        allMemBtn.addEventListener("click",goAllMem);
    }
    


   
};
/*
const s0xData = async () => {
    
    const deploymentKey = Object.keys(s0xiety.networks)[0];
    // console.log(s0xiety.abi,provider);
    return new ethers.Contract(
            s0xiety
            .networks[deploymentKey]
            .address, s0xiety.abi, signer
    );
}

const memData = async () => {
    
    const deploymentKey = Object.keys(dynMem.networks)[0];
    // console.log(s0xiety.abi,provider);
    return new ethers.Contract(
            dynMem
            .networks[deploymentKey]
            .address, dynMem.abi, signer
    );
}


const checkNameIn = (e) => {
    let nowChar = e.target.value[e.target.value.length-1];
    if(nowChar === "("||nowChar === ")"||nowChar === ","||nowChar === ";"||nowChar === "."||nowChar === ":"||nowChar === "&"||nowChar === "|"||nowChar === "$"||nowChar === "<"||nowChar === ">"||nowChar === "?"||nowChar === "!"||nowChar === "-"||nowChar === "+"||nowChar === "*"||nowChar === "/"||nowChar === "%") {
        nameInput.value = nameInput.value.substring(0, nameInput.value.length - 1)
    }
    if(e.target.value.length < 4 ||nowChar ===  e.target.value.length > 12) nameInput.style.borderColor = "red";
    else nameInput.style.borderColor = "mediumseagreen";  
}
const checkMailIn = (e) => {
    let nowChar = e.target.value[e.target.value.length-1];
    if(nowChar === "("||nowChar === ")"||nowChar === ","||nowChar === ";"||nowChar === ":"||nowChar === "&"||nowChar === "|"||nowChar === "$"||nowChar === "<"||nowChar === ">"||nowChar === "?"||nowChar === "!"||nowChar === "+"||nowChar === "*"||nowChar === "/"||nowChar === "%") {
        emailInput.value = emailInput.value.substring(0, emailInput.value.length - 1)
    }
    if(e.target.value.length < 10 ||nowChar ===  e.target.value.length > 32) emailInput.style.borderColor = "red";
    else emailInput.style.borderColor = "mediumseagreen";
}




//////////////////////////////////////////
//                                      //
//          Connect Web3                //
//                                      //
//////////////////////////////////////////

document.addEventListener('DOMContentLoaded', () => {
    initialize();
});

*/
