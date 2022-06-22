// SPDX-License-Identifier: GPL-3.0
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//   
//                                                 
//      
//      
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//      @artist ::          stereoIII6.eth                                                                                                                                          //
//      @msg ::             stereoIII6.eth.chat                                                                                                                                     //
//      @github ::          stereoIII6                                                                                                                                              //
//                                                                                                                                                                                  //
//      @dev ::             stereoIII6.eth                                                                                                                                          //
//      @msg ::             stereoIII6.eth.chat                                                                                                                                     //
//      @github ::          stereoIII6                                                                                                                                              //
//                                                                                                                                                                                  //
//      @author ::          stereoIII6.eth                                                                                                                                          //
//      @msg ::             stereoIII6.eth.chat                                                                                                                                     //
//      @github ::          stereoIII6                                                                                                                                              //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//                                                                                                                                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//      @title ::           safe contract                                                                                                                                           //
//      @description ::     Decentral Social Network Experiment                                                                                                                     //
//      @version ::         0.0.1                                                                                                                                                   //
//      @purpose ::         Bring real life into the Blockchain                                                                                                                     //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

pragma solidity ^0.8.0;

// Open Zeppelin Imports
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

// Chainlink Imports
// import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

/* 
Init Contract

Setup user account
*/
contract Init{ //
    address public author = 0x1Cd6F4D329D38043a6bDB3665c3a7b06F79B5242; // main admin address
    mapping(address => uint256) public role; // role by useraddress // 99 admin / 0 unknown / 1 guest / 
    mapping(address => bytes) public uData; // user json object storage 
    uint256 public maxSupply;   // max supply 
    uint256 public availSupply; // available Supply
    uint256 rate; // 
    uint256 digits = 1 * 10 ** 18;
    IERC20 internal Token;
    IERC20 internal MLQ;
    mapping(address => bool) public isUser;
    event Log(uint256 indexed id, address sender, address home, uint256 num, bytes message, uint256 stamp);
    event Wait(uint256 indexed id, address sender, address home, uint256 num, bytes message, uint256 stamp);
    uint256 logs;
    modifier isAdmin() {
        require(role[msg.sender] == 99, "you're not admin");
        _;
    }
    modifier isOwner() {
        require(author == msg.sender, "you're not owner");
        _;
    }
    function changeRole(address _to, uint256 _role) external isAdmin() returns(bool){ // allows admins to set users roles
        role[_to] = _role;
        return true;
    }
    function makeU(string memory _data) external returns(bool){
        isUser[msg.sender] = true;
        role[msg.sender] = 1;
        uData[msg.sender] = bytes(_data);
        return true;
    }
    function showU() external view returns(string memory, uint256){
        return(string(uData[msg.sender]),role[msg.sender]);
    }
    function approveTokens(address _contract) external returns(bool){
        Token = IERC20(_contract);
        Token.approve(address(this),Token.balanceOf(msg.sender));
        return true;
    }
    function approveTokenAmount(address _contract, uint256 _amnt) external returns(bool){
        Token = IERC20(_contract);
        Token.approve(address(this),_amnt);
        return true;
    }
    function withdrawToken(address _contract) external isAdmin() returns(bool){
        Token = IERC20(_contract);  
        Token.transfer(author,Token.balanceOf(address(this)));
        return true;
    }
    function divide(uint256 _a, uint256 _b) internal pure returns(uint256 res){
        uint256 rem = _a % _b;
        res = (_a - rem) / _b;
    }
    fallback() external{

    }
}

contract Trees is ERC20, Init{

    constructor(address _mlq) ERC20("Impact Tree Token", "IMPCTrees"){
        require(msg.sender == author);
        role[msg.sender] = 99;
        uData[msg.sender] = bytes('{"username":"@stereoiii6","email":"type.stereo@pm.me"}');
        maxSupply = 5000000000000 * 10 ** 18;
        emit Log(logs,msg.sender,address(this),999,bytes("contract created"),block.timestamp);
        rate = 35;
        logs++;
        MLQ = IERC20(_mlq);   
    }

    function plantTree(uint256 _amount) external payable returns(bool){
        require(msg.value >= _amount * rate * 10 ** 12);
        require(availSupply < maxSupply);
        availSupply += msg.value*10000;
        _mint(msg.sender, _amount * 10 ** 18);
        emit Log(logs,msg.sender,address(this),_amount,bytes("trees minted"),block.timestamp);
        logs++;
        return true;
    }

    function plantTreeMLQ(uint256 _amount) external payable returns(bool){
        require(MLQ.balanceOf(msg.sender) >= 100 * _amount * rate * 10 ** 12);
        require(availSupply < maxSupply);
        MLQ.transferFrom(msg.sender,address(this), 100 * _amount * rate * 10 ** 12);
        availSupply += msg.value*10000;
        _mint(msg.sender, _amount * 10 ** 18);
        emit Log(logs,msg.sender,address(this),_amount,bytes("trees minted"),block.timestamp);
        logs++;
        return true;
    }

    function donateTrees(uint256 _amount) external returns(bool){
        require(balanceOf(msg.sender) > _amount * 10 ** 18);
        _burn(msg.sender, _amount * 10 ** 18);
        emit Log(logs,msg.sender,address(this),_amount,bytes("trees burned"),block.timestamp);
        logs++;
        return true;
    }

    function approveContract(address _contract) external returns(bool){
        approve(_contract, balanceOf(msg.sender));
        emit Log(logs,msg.sender,_contract,999,bytes("approve contract"),block.timestamp);
        logs++;
        return true;
    }

    function trimTreesl(uint256 _newPrice) isAdmin() external returns(bool){
        rate = _newPrice;
        return true;
    }

    function withdraw(uint256 _eth, uint256 _tree) isAdmin() external returns(bool){
        require(_tree * 10 ** 18 <= balanceOf(address(this)));
        require(_eth * 10 ** 18 <= address(this).balance);
        transfer(payable(author), _tree * 10 ** 18);
        payable(author).transfer(_eth * 10 ** 18);
        emit Log(logs,msg.sender,address(this),_tree,bytes("contract withdraw"),block.timestamp);
        logs++;
        return true;
    }
}

contract Co2s is ERC20, Init {

    IERC20 internal trees;

    struct Bond{
        uint256 id;
        address adr;
        uint256 amount;
        uint256 region;
        uint256 stamp;
        uint256 duration;
        uint256 co2;
    }

    mapping(address => uint256) public myBonds;
    mapping(address => mapping(uint256 => uint256)) public myBondedCo2;

    Bond[] public bonds;
    uint256 c;
    uint256 b;
    uint256 per;
    constructor(address _contract, uint256 _percent, address _mlq) ERC20("Carbon token", "CO2"){
        require(msg.sender == author);
        role[msg.sender] = 99;
        uData[msg.sender] = bytes('{"username":"@stereoiii6","email":"type.stereo@pm.me"}');
        maxSupply = 25000000000000 * 10 ** 18;
        trees = IERC20(_contract);  
        per = _percent;
        emit Log(logs,msg.sender,address(this),_percent,bytes("contract created"),block.timestamp);
        MLQ = IERC20(_mlq);  
        logs++;
    }

    function growTrees(uint256 _trees, uint256 _region, uint256 _duration) external payable returns(bool){
        require(msg.value >= _trees * 10 ** 14 , "not enough funds for asset");
        require(_trees <= trees.balanceOf(msg.sender), "insufficient balance");
        require(5 * _trees * 10 ** 18 <= maxSupply - availSupply, "insufficient supply");
        bonds.push(Bond(b ,msg.sender ,_trees * 10 ** 18 ,_region ,block.timestamp ,_duration ,5 * _trees * 10 ** 18));
        availSupply += 5 * _trees * 10 ** 18;  
        myBondedCo2[msg.sender][myBonds[msg.sender]] = b;
        myBonds[msg.sender]++;
        trees.transferFrom(msg.sender,payable(address(this)), _trees * 10 ** 18);
        b++;
        emit Log(logs,msg.sender,address(this),_trees,bytes("trees staked"),block.timestamp);
        logs++;
        return true;
    }

    function growMoreTrees(uint256 _trees, uint256 _b) external payable returns(bool){
        require(msg.value >= _trees * 10 ** 14);
        require(_trees <= trees.balanceOf(msg.sender));
        uint256 treez = _trees * 10 ** 18;
        require(5 * treez <= maxSupply - availSupply);
        uint256 p = divide(100,bonds[_b].amount) * treez;
        bonds[_b].amount += treez;
        bonds[_b].co2 += 5 * treez;
        bonds[_b].duration += bonds[_b].duration * p;
        uint256 fee = divide(treez,(100/per));
        trees.transfer(payable(address(this)), treez - fee);
        trees.transfer(payable(address(this)), fee);
        emit Log(logs,msg.sender,address(this),_trees,bytes("trees addeed to stake"),block.timestamp);
        logs++;
        return true;
    }

    function growLessTrees(uint256 _trees, uint256 _b) external payable returns(bool){
        require(msg.value >= _trees * 10 ** 15);
        uint256 treez = _trees * 10 ** 18;
        require(treez <= bonds[myBondedCo2[msg.sender][myBonds[msg.sender]]].amount);
        bonds[_b].amount -= treez;
        bonds[_b].co2 -= 5 * treez; 
        uint256 fee = divide(treez,(100/per));
        trees.transfer(payable(msg.sender), treez - fee);
        trees.transfer(payable(address(this)), fee);
        emit Log(logs,msg.sender,address(this),_trees,bytes("trees removed from stake"),block.timestamp);
        logs++;
        return true;
    }

    function calcFreeCo2(uint256 _b) internal returns(uint256,uint256){
        uint256 total = bonds[_b].duration * 60 * 60 * 24 * 365;
        uint256 passed = block.timestamp - bonds[_b].stamp;
        uint256 pDur = divide(100*10**18 , total) * passed;
        uint256 freeCo2 = divide(100*10**18 , bonds[_b].co2) * pDur;
        emit Log(logs,msg.sender,address(this),freeCo2,bytes("free co2 calculated"),block.timestamp);
        logs++;
        return (freeCo2, passed);
    }

    function releaseFreeCo2(uint256 _m) external returns(bool){
        uint256 _b = myBondedCo2[msg.sender][_m]; // get b_id
        (uint256 free, uint256 passed) = calcFreeCo2(_b); // get free co2 & passed time
        require(1 * 10 ** 18 <= free); // check amount
        bonds[_b].co2 -= free;          // edit bonds data subtract
        bonds[_b].stamp = block.timestamp;
        uint256 addTime = divide(passed,(100 / per));
        bonds[_b].duration += addTime;

        uint256 fee = divide(free,(100/per));
        _mint(msg.sender,(free - fee)); // mint free co2
        _mint(address(this),fee);
        emit Log(logs,msg.sender,address(this),free,bytes("free co2 minted"),block.timestamp);
        logs++;
        return true;
    }

    function withdraw(uint256 _eth, uint256 _co2, uint256 _tree) isAdmin() external returns(bool){
        require(_co2 * 10 ** 18 <= balanceOf(address(this)));
        require(_tree * 10 ** 18 <= trees.balanceOf(address(this)));
        require(_eth * 10 ** 18 <= address(this).balance);
        transfer(payable(author), _co2 * 10 ** 18);
        trees.transfer(payable(author), _tree * 10 ** 18);
        payable(author).transfer(_eth * 10 ** 18);
        emit Log(logs,msg.sender,address(this),999,bytes("contract fund balances 0"),block.timestamp);
        logs++;
        return true;
    }
}

contract GardenPool is ERC1155, Init {
    IERC20 internal TR3EZ;
    IERC20 internal CO2;
    IERC20 internal WETH;
    IERC20 internal lowC;
    IERC20 internal highC;
    uint256 private per;
    uint256 public collectedFees;
    struct Garden{
        uint256 id;
        address low;
        uint256 lowTotal;
        address high;
        bytes description;
        uint256 low4high; 
        uint256 maxSize;
        uint256 currentSize;
    }
    Garden[] public gardens;
    uint256 g;
    constructor(address _trees, address _co2, address _weth, uint256 _percent) ERC1155("IMgardens") {
        require(msg.sender == author);
        role[msg.sender] = 99;
        uData[msg.sender] = bytes('{"username":"@stereoiii6","email":"type.stereo@pm.me"}');
        TR3EZ = IERC20(_trees);
        CO2 = IERC20(_co2);
        WETH = IERC20(_weth);
        per = _percent;
        emit Log(logs,msg.sender,address(this),_percent,bytes("contract created"),block.timestamp);
        logs++;
    }

    function createGarden(string memory _name, address _hi, address _lo) external returns(bool){
        _setURI(_name);
        _mint(address(this),g,100*10**6,bytes(_name)); // 1 : 10 000 // 100 000 weth : 1 000 000 000 trees = 100% // 1 weth : 10 000 trees = 0,001% of max pool size
        gardens.push(Garden(g,_hi,1000000000,_lo,bytes(_name),10000,100000,0));
        g++;
        return true;   
    }

    function addliquidity(uint256 _id, uint256 _low) external payable returns(bool){
        uint256 low = _low * 10 ** 6;
        uint256 high = gardens[_id].low4high * low;    
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(lowC.balanceOf(msg.sender) >= low);
        require(highC.balanceOf(msg.sender) >= high);
        lowC.transferFrom(msg.sender, address(this), low);
        highC.transferFrom(msg.sender, address(this), high);
        uint256 gardenDrops = divide(100 * 10 ** 6 , gardens[_id].lowTotal) * low;
        safeTransferFrom(address(this),msg.sender,gardens[_id].id,gardenDrops,gardens[_id].description);
        gardens[_id].currentSize += gardenDrops;
        return true;
    }

    function removeLiquidity(uint256 _id, uint256 _gardenDrops) external payable returns(bool){
        uint256 low = divide(100 * 10 ** 6 , gardens[_id].lowTotal) * _gardenDrops;
        uint256 high = low * gardens[_id].low4high;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(lowC.balanceOf(address(this)) >= low);
        require(highC.balanceOf(address(this)) >= high);
        lowC.transferFrom(address(this), msg.sender, low);
        highC.transferFrom(address(this),msg.sender, high);
        safeTransferFrom(msg.sender,address(this),gardens[_id].id,_gardenDrops,gardens[_id].description);
        gardens[_id].currentSize -= _gardenDrops;
        return true;
    }

    function swapLowHigh(uint256 _id, uint256 _low) external payable returns(bool){
        uint256 low = _low * 10 ** 6;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(lowC.balanceOf(msg.sender) >= low);
        uint256 fee = divide(100 * 10 ** 6, low) * (100/per);
        uint256 get = gardens[_id].low4high * (low - fee);
        require(highC.balanceOf(address(this)) >= get);
        lowC.transferFrom(msg.sender, address(this), low);
        highC.transferFrom( address(this), msg.sender, get);
        collectedFees += fee;
        return true;
    }

    function swapHighLow(uint256 _id, uint256 _high) external payable returns(bool){
        uint256 high = _high * 10 ** 6;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(highC.balanceOf(msg.sender) >= high);
        uint256 fee = divide(100 * 10 ** 6, high) * (100/per);
        uint256 get = divide(high - fee ,gardens[_id].low4high);
        require(highC.balanceOf(address(this)) >= get);
        highC.transferFrom(msg.sender, address(this), high);
        lowC.transferFrom(address(this), msg.sender, get);
        collectedFees += fee;
        return true;
    }

    function waterGardens(uint256 _id) external payable returns(uint256){
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        uint256 lBal = lowC.balanceOf(address(this));
        uint256 hBal = highC.balanceOf(address(this));
        uint256 rRatio = divide(hBal , lBal);
        uint256 eRatio = divide(gardens[_id].low4high, 1);
        uint256 difRatio = divide(100,eRatio) * rRatio;
        return difRatio;
    }

}