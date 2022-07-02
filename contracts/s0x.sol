// SPDX-License-Identifier: GPL-3.0
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//
//              .d8888.  .d88b.  db    db d888888b d88888b d888888b db    db
//              88'  YP .8P  88. `8b  d8'   `88'   88'     `~~88~~' `8b  d8'
//              `8bo.   88  d'88  `8bd8'     88    88ooooo    88     `8bd8'
//                `Y8b. 88 d' 88  .dPYb.     88    88~~~~~    88       88
//              db   8D `88  d8' .8P  Y8.   .88.   88.        88       88
//              `8888Y'  `Y88P'  YP    YP Y888888P Y88888P    YP       YP
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//                                                                                                                                                                                  //
//      @dev            ::              stereoIII6.dao                                                                                                                                          //
//      @msg            ::              type.stereo@pm.me                                                                                                                                    //
//      @github         ::              @stereoIII6
//      @twitter        ::              @stereoIII6                                                                                                                                              //
//                                                                                                                                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//                                                                                                                                                                                  //
//      @dev            ::              Juan Xavier Valverde                                                                                                                                    //
//      @msg            ::              juanxaviervm@hotmail.com                                                                                                                               //
//      @twitter        ::              @JuanXavier                                                                                                                                             //
//      @github         ::              @JuanXavier                                                                                                                                             //
//                                                                                                                                                                                  //                                                                                                                                                                                 //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//  *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//      @title          ::              s0xiety Connect                                                                                                                             //
//      @description    ::              decentral s0xiety                                                                                                                           //
//      @version        ::              0.0.1                                                                                                                                       //
//      @purpose        ::              Refer friennds on the blockchain                                                                                                            //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
//  *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   //
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
/*

 MOCK USER TAG ::: "{'name':'s0x user','email':'type.stereo@pm.me','image':'https://ipfs.io/ipfs/QmXNciGvGJGRV2HHE82oLoicvwatB8sqsydxn7P3NSP1nW'}"

*/

/* 

INSTRUCTIONS 

*/
pragma solidity ^0.8.7;

// Open Zeppelin Imports
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

// mathematical function for conglomerate
contract MathFnx {
    // division function for solidity 
    function divide(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 rem = _a % _b;
        return ((_a - rem) / _b);
    }
    // generates unique id nr
    function uniqID(string memory _inf) internal pure returns(uint256){
        bytes32 BHash = keccak256(abi.encode(_inf));
        return uint256(BHash);
    }
    // gives back the smaller wallet address 
    function smaller(address _a, address _b) internal pure returns(address s, address l){
        if(_a < _b){ s = _a; l = _b;}
        else if(_a > _b){ s = _b; l = _a;}
        
    }

}
// user data storage for conglomerate
contract Users {
    address private s0x; // s0x admin
    constructor(){
        s0x = msg.sender; // admin initialization
        makeUser(s0x,'{"name":"s0x admin","email":"type.stereo@pm.me","image":"https://ipfs.io/ipfs/QmXNciGvGJGRV2HHE82oLoicvwatB8sqsydxn7P3NSP1nW"}',99); // admin user account setup
    }
    struct Impact{
        uint256 action;
        uint256 connection;
        uint256 liquidity;
    }
    // user profile array // user# => dias%
    mapping(address => bytes) public users;
    mapping(address => bool) private isUser;
    // role // user# => role$
    mapping(address => uint256) private roles;
    // only admin allowed function modifier
    mapping(address => Impact) public impx;
    modifier isAdmin(){
        require(msg.sender == s0x);
        _;
    }
    // takes address , dias , and role to create and store a user profile in user mapping
    function makeUser(address _adr, bytes memory _dias, uint256 _r) internal returns(bool){
        users[_adr] = _dias;
        roles[_adr] = _r;
        impx[_adr] = Impact(0,0,0);
        return true;
    }
    // takes dias to create guest user profile
    function createUserAccount(string memory _dias) external returns(bool){
        return makeUser(msg.sender, bytes(_dias), 2);
    }
    // takes address , dias , and role to admin edit and store a user profile in user mapping
    function adminEditUser(address _adr, string memory _dias, uint256 _r) external isAdmin() returns(bool){
        return makeUser(_adr, bytes(_dias), _r);
    }
    // takes address , dias , and role to edit and store your user profile in user mapping
    function editUser(string memory _dias) external returns(bool){
        return makeUser(msg.sender, bytes(_dias), 2);
    }
    // shows user dias by address input
    function showUser(address _adr) external view returns(string memory){
        return string(users[_adr]);
    }
    function showImpx(address _adr) external view returns(uint256, uint256, uint256){
        return (impx[_adr].action, impx[_adr].connection, impx[_adr].liquidity);
    }
    // shows role by address input
    function getRole(address _adr) external view returns(uint256){
        return roles[_adr];
    }
    function isU(address _adr) external view returns(bool){
        return isUser[_adr];
    }
}

contract Friends is MathFnx {
    Users private user;
    // frenz // you# => frenz# => isfriend?
    mapping(address => mapping(address => bool)) public frenz; // people following you
    // degenz // you# => degenz# => isfriend?
    mapping(address => mapping(address => bool)) public degenz; // people you follow 
    // connection bool // smaller# => bigger# => friends$ // friends : $0=unrelated, $1=hype, $2=nest 
    uint256 c;
    mapping(address => mapping(address => uint256)) public connection;
    mapping(address => uint256) public frenzCount;
    mapping(address => uint256) public degenzCount;
    mapping(address => mapping(uint256 => address)) public frenzByCount;
    // user degenerated you
    modifier degenerated(address _adr){
        require(degenz[msg.sender][_adr] == true || msg.sender == _adr); // do you follow or is it yourself
        _;
    }
    // user frenzonned you 
    modifier frenzoned(address _adr){
        require(frenz[_adr][msg.sender] || msg.sender == _adr); // is he following or is it yourself
        _;
    }
    constructor(address _usrAdr){
        user = Users(_usrAdr);
        c = 1;
    }
    function showMe() external view returns(string memory){
        return user.showUser(msg.sender);
    }
    function showYou(address _adr) external view returns(string memory){
        return user.showUser(_adr);
    }
    function getRole(address _adr) external view returns(uint256){
        return user.getRole(_adr);
    }
    function follow(address _adr, address _sender) external returns(uint256){
        degenz[_adr][_sender] = true;
        degenzCount[_adr]++;
        frenz[_sender][_adr] = true;
        frenzByCount[_sender][frenzCount[_sender]] = _adr;
        frenzCount[_sender]++;
        (address s, address l) = smaller(_adr,_sender);
        if(connection[s][l] == 0) {
            connection[s][l] = c;
            c++;
            return (connection[s][l]);
        }
        else return (connection[s][l]);
    }
    function doShowStatus(address _adr, address _sender) external view returns(uint256, bool, bool, address, address){
        (address s, address l) = smaller(_adr,_sender);
        return (connection[s][l],frenz[_sender][_adr],degenz[_sender][_adr],s,l);
    }
    function doFrenzCount(address _adr) external view returns(uint256){
        return frenzCount[_adr];
    }
    function doDegenzCount(address _adr) external view returns(uint256){
        return degenzCount[_adr];
    }
    function doShowFrenz(address _adr, uint256 _c) external view returns(address){
        return frenzByCount[_adr][_c];
    }
    function isFrenz(address _a, address _b) external view returns(bool){
        return frenz[_a][_b];
    }

}
// groups contract stores groupmembers , posts and comments inside the group on chain
contract Groups is MathFnx{
    Users private user; // user contract reference
    Friends private friend; // friend contract reference
    address public owner; // owner address 
    string public name; // group name
    uint256 private m; // member count
    uint256 private state; // 0-private (no invite), 1-bothchecked, 2-ulike, 3-likeu, 4-bothcheckedofulike, 5-public, 9-secret, 99-admin
    mapping(uint256 => address) public members; // address by id
    mapping(address => uint256) public mNum; // id by address 
    uint256 private c; // content count 
    mapping(address => uint256) public myContent; // content count by address
    mapping(address => mapping(uint256 => bytes)) public content; // content by address => myContent counter
    mapping(uint256 => bytes) public cntnt; // contentt by cid 
    mapping(uint256 => uint256) public r; // replys by cntnt id c
    mapping(uint256 => mapping(uint256 => bytes)) public replys; // replys by cid => rply id => reply content
    mapping(address => uint256) public myRplyCount; // reply count  by useraddress 
    mapping(address => mapping(uint256 => bytes)) public myReplys; // reply content by address and myrplycount 
    mapping(address => bool) public invite;
    
    constructor(address _user, address _friend, bytes memory _name, uint256 _state, address _o){
        state = _state;
        user = Users(_user);
        friend = Friends(_friend);
        owner = _o;
        name = string(_name);
    }
    function addUser(address _adr) external returns(address){
        if(state == 0) require(m < 2); // private state one allows 2 users only 
        /*
        require(user.isU(msg.sender) == true);
        require(user.isU(_adr) == true);
        else if(state == 1) {
            require(friend.isFrenz(owner, _adr));
            require(friend.isFrenz(_adr, owner));
        } // only degenz&frenz allowed 
        else if(state == 2) {
          require(friend.isFrenz(owner, _adr));  
        } // only frenz people you like
        else if(state == 3) {
          require(friend.isFrenz(_adr, owner));  
        } // only degenz people who like you
        else if(state == 4) {
            require(friend.isFrenz(msg.sender, _adr));
            require(friend.isFrenz(_adr, msg.sender));
        } // only degenz&frenz allowed

        else if(state == 9) require(invite[_adr] == true);
        else if(state == 99) require(friend.getRole(msg.sender) == 99);
        */
        members[m] = _adr;
        mNum[_adr] = m;
        m++;
        return _adr;
    }
    function removeUser(address _adr) external returns(address){
        require(state != 0);
        members[mNum[_adr]] = 0x0000000000000000000000000000000000000000;
        mNum[_adr] = 0;
        return _adr;
    }
    function addContent(string memory _cnt) external returns(string memory){
        content[msg.sender][myContent[msg.sender]] = bytes(_cnt);
        myContent[msg.sender]++;
        cntnt[c] = bytes(_cnt);
        c++;
        return _cnt;
    }
    function addReplyToContent(string memory _rply, uint256 _c) external returns(uint256)
    {
        replys[_c][r[_c]] = bytes(_rply);
        myReplys[msg.sender][myRplyCount[msg.sender]] = bytes(_rply);
        myRplyCount[msg.sender]++;
        return r[_c]++;
    } 

}
// allows users to create groups
contract s0xFactory is Users, MathFnx {
    Friends private friends;
    Groups public groups;
    MLQ public mlq;
    address private fAdr;
    mapping(address => uint256) public groupCount;
    mapping(address => mapping(uint256 => address)) public groupByCount;
    constructor() Users() MathFnx() {
        friends = new Friends(address(this));
        fAdr = address(friends);
    }
    function setMlq(address _mlq) external returns(address){
        mlq = MLQ(_mlq);
        return address(mlq);
    }
    function createGroup(string memory _name, uint256 _state) external returns(address){
        groups = new Groups(address(this), fAdr, bytes(_name), _state, msg.sender);
        groupByCount[msg.sender][groupCount[msg.sender]] = address(groups);
        groupCount[msg.sender]++;
        return address(groups);
    }
    function createConvo(address _to, address _from,string memory _msg) external returns(address){
        (address s, address l) = smaller(_to,_from);
        return makeConvo(s,l,_msg, _from);
    }
    function makeConvo(address _s, address _l, string memory _name, address _from) internal returns(address){
        groups = new Groups(address(this), fAdr, bytes(_name), 0, _from);
        groupByCount[_s][groupCount[_s]] = address(groups);
        groupByCount[_l][groupCount[_l]] = address(groups);
        groupCount[_s]++;
        groupCount[_l]++;
        groups.addUser(_s);
        groups.addUser(_l);
        return address(groups);
    }
    function followAdr(address _adr) external returns(uint256){
        return friends.follow(_adr,msg.sender);
    }
    function showFrenz(address _adr,uint256 _c) external view returns(address){
        return friends.doShowFrenz(_adr,_c);
    }
    function countFrenz(address _adr) external view returns(uint256){
        return friends.doFrenzCount(_adr);
    }
    function countDegenz(address _adr) external view returns(uint256){
        return friends.doDegenzCount(_adr);
    }
    function showStatus(address _adr) external view returns(uint256,bool,bool,address,address){
        return friends.doShowStatus(_adr,msg.sender);
    }
}
// mlq library
library mlqLib {
    uint256 public constant mlqRate = 100;
    uint256 public constant mlqDig = 10**18;
    uint256 public constant maxSupply = 3*10**9 * mlqDig;
    uint256 public constant pubSupply = 1*10**9 * mlqDig;
    uint256 public constant poolReserve = 1*10**9 * mlqDig;
    uint256 public constant circReserve = 1*10**9 * mlqDig;
}
// mlq token contract
contract MLQ is ERC20, MathFnx {

    using mlqLib for *;
    address private admin;
    uint256 public rate;
    uint256 public pubSupply;
    mapping(address => uint256) public mlqBalance;

    constructor() ERC20("Milquidity Token", "MLQ"){
        admin = msg.sender;
        setRate(mlqLib.mlqRate);
        setSupply(mlqLib.pubSupply);
    }
    function setRate(uint256 _newRate) internal returns(uint256){
        rate = _newRate;
        return rate;
    }
    function setSupply(uint256 _newSupply) internal returns(uint256){
        pubSupply = _newSupply;
        return pubSupply;
    }
    function buyMlq(uint256 _amnt) external payable returns(uint256){
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(pubSupply >= amnt);
        require(divide(msg.value,100) >=  amnt);
        _mint(msg.sender,amnt);
        mlqBalance[msg.sender] = amnt;
        pubSupply -= amnt;
        return amnt;
    }
    function mlqBal(address _adr) external view returns(uint256){
        return mlqBalance[_adr]; 
    }
    function withdraw(uint256 _amnt) external returns(uint256){
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(admin == msg.sender);
        require(mlqBalance[address(this)] >= amnt);
        transferFrom(address(this),admin, amnt);
        return amnt;
    }
    function flush() external returns(uint256){
        require(admin == msg.sender);
        transferFrom(address(this),admin,mlqBalance[address(this)]);
        payable(admin).transfer(address(this).balance);
        return address(this).balance;
    }
}
// any coin tokeen contract
contract COIN is ERC20, MathFnx {

    using mlqLib for *;
    address private admin;
    uint256 public rate;
    uint256 public pubSupply;
    uint256 public maxSupply;
    mapping(address => uint256) public coinBalance;

    constructor(string memory _name,string memory _sym, uint256 _rate, uint256 _supply, address _admin) ERC20(_name, _sym){
        admin = _admin;
        setRate(_rate);
        setSupply(_supply);
    }
    function setRate(uint256 _newRate) internal returns(uint256){
        rate = _newRate;
        return rate;
    }
    function getRate() external view returns(uint256){
        return rate;
    }
    function getMax() external view returns(uint256){
        return maxSupply;
    }
    function setSupply(uint256 _newSupply) internal returns(uint256){
        pubSupply = divide(_newSupply, 3);
        maxSupply = _newSupply;
        return pubSupply;
    }
    function buyMlq(uint256 _amnt) external payable returns(uint256){
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(pubSupply >= amnt);
        require(divide(msg.value,100) >=  amnt);
        _mint(msg.sender,amnt);
        coinBalance[msg.sender] = amnt;
        pubSupply -= amnt;
        return amnt;
    }
    function coinBal(address _adr) external view returns(uint256){
        return coinBalance[_adr]; 
    }
    function withdraw(uint256 _amnt) external returns(uint256){
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(admin == msg.sender);
        require(coinBalance[address(this)] >= amnt);
        transferFrom(address(this),admin, amnt);
        return amnt;
    }
    function flush() external returns(uint256){
        require(admin == msg.sender);
        transferFrom(address(this),admin,coinBalance[address(this)]);
        payable(admin).transfer(address(this).balance);
        return address(this).balance;
    }
}
contract s0xPool is MathFnx{
    COIN public coin;
    COIN public main;
    COIN public sec;
    COIN[] public pool;
    uint256 p;
    struct Pool {
        uint256 id;
        address pool;
        address main;
        uint256 ethByMain;
        uint256 mainMax;
        address sec;
        uint256 ethBySec;
        uint256 secMax;
        uint256 distrib;
    }
    mapping(uint256 => Pool) public poolz;
    function addToken(address _token) external returns(address){
        coin = COIN(_token);
        return address(coin);
    }
    function createToken(string memory _name, string memory _sym, uint256 _rate, uint256 _max) external returns(address){
        coin = new COIN(_name, _sym, _rate, _max, msg.sender);
        return address(coin);
    }
    function createPool(address _main, address _sec, string memory _name, string memory _psym) external returns(address){
        // get token contracts
        main = COIN(_main);
        sec = COIN(_sec);
        // detect currency eth value per token
        uint256 mEthPrice = divide(10**18,main.getRate()); // example // 10^18 / 100 = 10^16 
        uint256 sEthPrice = divide(10**18,sec.getRate());  // example // 10^18 / 100000 = 10^13
        // detect dif ratio 
        uint256 dRate; // difference ratio 
        if(sEthPrice < mEthPrice) dRate = divide(mEthPrice,sEthPrice); // example // 10^16 / 10^13 = 1000
        else dRate = divide(sEthPrice,mEthPrice); // example // null
        // get x rate // triangleCalc( pool , main , sec )
        uint256 xRate = triangleCalc(0,mEthPrice,sEthPrice);
        pool[p] = new COIN(_name, _psym, xRate, 100*10**18, msg.sender); // example // 100 * 10^18
        poolz[p] = Pool(p,address(pool[p]),_main,mEthPrice,divide(main.getMax(),3),_sec,sEthPrice,divide(sec.getMax(),3),0);
        p++;
        return address(coin);
    }
    function addMilquidity(uint256 _p, uint256 _mIn) external returns(uint256, uint256, uint256){
        main = COIN(poolz[_p].main);
        sec = COIN(poolz[_p].sec);
        coin = COIN(poolz[_p].pool);
        uint256 weth = 10**18;
        return (_mIn, , );
    } 
    function triangleCalc(uint256 _pool, uint256 _main, uint256 _sec) internal pure returns(uint256){
        if(_pool == 0) { 
            return (divide(10**18, _main * 2)); 
            }
        if(_sec == 0) { 
            return (divide(_pool, _main)); 
            }
        if(_main == 0) { 
            return (divide(_pool, _sec)); 
            }
        else return 0;
    }

}