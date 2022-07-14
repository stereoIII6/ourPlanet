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

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
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
    function uniqID(string memory _inf) internal pure returns (uint256) {
        bytes32 BHash = keccak256(abi.encode(_inf));
        return uint256(BHash);
    }

    // gives back the smaller wallet address
    function smaller(address _a, address _b)
        internal
        pure
        returns (address s, address l)
    {
        if (_a < _b) {
            s = _a;
            l = _b;
        } else if (_a > _b) {
            s = _b;
            l = _a;
        }
    }
}

// user data storage for conglomerate
contract Users {
    address private s0x; // s0x admin

    constructor() {
        s0x = msg.sender; // admin initialization
        makeUser(
            s0x,
            '{"name":"s0x admin","email":"type.stereo@pm.me","image":"https://ipfs.io/ipfs/QmXNciGvGJGRV2HHE82oLoicvwatB8sqsydxn7P3NSP1nW"}',
            99
        ); // admin user account setup
    }

    struct Impact {
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
    modifier isAdmin() {
        require(msg.sender == s0x);
        _;
    }

    // takes address , dias , and role to create and store a user profile in user mapping
    function makeUser(
        address _adr,
        bytes memory _dias,
        uint256 _r
    ) internal returns (bool) {
        users[_adr] = _dias;
        roles[_adr] = _r;
        impx[_adr] = Impact(0, 0, 0);
        return true;
    }

    // takes dias to create guest user profile
    function createUserAccount(string memory _dias) external returns (bool) {
        return makeUser(msg.sender, bytes(_dias), 2);
    }

    // takes address , dias , and role to admin edit and store a user profile in user mapping
    function adminEditUser(
        address _adr,
        string memory _dias,
        uint256 _r
    ) external isAdmin returns (bool) {
        return makeUser(_adr, bytes(_dias), _r);
    }

    // takes address , dias , and role to edit and store your user profile in user mapping
    function editUser(string memory _dias) external returns (bool) {
        return makeUser(msg.sender, bytes(_dias), 2);
    }

    // shows user dias by address input
    function showUser(address _adr) external view returns (string memory) {
        return string(users[_adr]);
    }

    function showImpx(address _adr)
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        return (impx[_adr].action, impx[_adr].connection, impx[_adr].liquidity);
    }

    // shows role by address input
    function getRole(address _adr) external view returns (uint256) {
        return roles[_adr];
    }

    function isU(address _adr) external view returns (bool) {
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
    modifier degenerated(address _adr) {
        require(degenz[msg.sender][_adr] == true || msg.sender == _adr); // do you follow or is it yourself
        _;
    }
    // user frenzonned you
    modifier frenzoned(address _adr) {
        require(frenz[_adr][msg.sender] || msg.sender == _adr); // is he following or is it yourself
        _;
    }

    constructor(address _usrAdr) {
        user = Users(_usrAdr);
        c = 1;
    }

    function showMe() external view returns (string memory) {
        return user.showUser(msg.sender);
    }

    function showYou(address _adr) external view returns (string memory) {
        return user.showUser(_adr);
    }

    function getRole(address _adr) external view returns (uint256) {
        return user.getRole(_adr);
    }

    function follow(address _adr, address _sender) external returns (uint256) {
        degenz[_adr][_sender] = true;
        degenzCount[_adr]++;
        frenz[_sender][_adr] = true;
        frenzByCount[_sender][frenzCount[_sender]] = _adr;
        frenzCount[_sender]++;
        (address s, address l) = smaller(_adr, _sender);
        if (connection[s][l] == 0) {
            connection[s][l] = c;
            c++;
            return (connection[s][l]);
        } else return (connection[s][l]);
    }

    function doShowStatus(address _adr, address _sender)
        external
        view
        returns (
            uint256,
            bool,
            bool,
            address,
            address
        )
    {
        (address s, address l) = smaller(_adr, _sender);
        return (
            connection[s][l],
            frenz[_sender][_adr],
            degenz[_sender][_adr],
            s,
            l
        );
    }

    function doFrenzCount(address _adr) external view returns (uint256) {
        return frenzCount[_adr];
    }

    function doDegenzCount(address _adr) external view returns (uint256) {
        return degenzCount[_adr];
    }

    function doShowFrenz(address _adr, uint256 _c)
        external
        view
        returns (address)
    {
        return frenzByCount[_adr][_c];
    }

    function isFrenz(address _a, address _b) external view returns (bool) {
        return frenz[_a][_b];
    }
}

// groups contract stores groupmembers , posts and comments inside the group on chain
contract Groups is MathFnx {
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

    constructor(
        address _user,
        address _friend,
        bytes memory _name,
        uint256 _state,
        address _o
    ) {
        state = _state;
        user = Users(_user);
        friend = Friends(_friend);
        owner = _o;
        name = string(_name);
    }

    function addUser(address _adr) external returns (address) {
        if (state == 0)
            require(m < 2); // private state one allows 2 users only
            // require(user.isU(msg.sender) == true);
            // require(user.isU(_adr) == true);
        else if (state == 1) {
            require(friend.isFrenz(owner, _adr));
            require(friend.isFrenz(_adr, owner));
        } // only degenz&frenz allowed
        /*
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

    function removeUser(address _adr) external returns (address) {
        require(state != 0);
        members[mNum[_adr]] = 0x0000000000000000000000000000000000000000;
        mNum[_adr] = 0;
        return _adr;
    }

    function addContent(string memory _cnt) external returns (string memory) {
        content[msg.sender][myContent[msg.sender]] = bytes(_cnt);
        myContent[msg.sender]++;
        cntnt[c] = bytes(_cnt);
        c++;
        return _cnt;
    }

    function addReplyToContent(string memory _rply, uint256 _c)
        external
        returns (uint256)
    {
        replys[_c][r[_c]] = bytes(_rply);
        myReplys[msg.sender][myRplyCount[msg.sender]] = bytes(_rply);
        myRplyCount[msg.sender]++;
        return r[_c]++;
    }
}

// allows users to create groups
contract s0xFactory is Users, MathFnx {
    Friends public friends;
    Groups public groups;
    MLQ public mlq;
    address private fAdr;
    mapping(address => uint256) public groupCount;
    mapping(address => mapping(uint256 => address)) public groupByCount;

    constructor(address _mlq) Users() MathFnx() {
        mlq = MLQ(_mlq);
        friends = new Friends(address(this));
        fAdr = address(friends);
    }

    function createGroup(string memory _name, uint256 _state)
        external
        returns (address)
    {
        groups = new Groups(
            address(this),
            fAdr,
            bytes(_name),
            _state,
            msg.sender
        );
        groupByCount[msg.sender][groupCount[msg.sender]] = address(groups);
        groupCount[msg.sender]++;
        return address(groups);
    }

    function createConvo(
        address _to,
        address _from,
        string memory _msg
    ) external returns (address) {
        (address s, address l) = smaller(_to, _from);
        return makeConvo(s, l, _msg, _from);
    }

    function makeConvo(
        address _s,
        address _l,
        string memory _name,
        address _from
    ) internal returns (address) {
        groups = new Groups(address(this), fAdr, bytes(_name), 0, _from);
        groupByCount[_s][groupCount[_s]] = address(groups);
        groupByCount[_l][groupCount[_l]] = address(groups);
        groupCount[_s]++;
        groupCount[_l]++;
        groups.addUser(_s);
        groups.addUser(_l);
        return address(groups);
    }

    function followAdr(address _adr) external returns (uint256) {
        return friends.follow(_adr, msg.sender);
    }

    function showFrenz(address _adr, uint256 _c)
        external
        view
        returns (address)
    {
        return friends.doShowFrenz(_adr, _c);
    }

    function countFrenz(address _adr) external view returns (uint256) {
        return friends.doFrenzCount(_adr);
    }

    function countDegenz(address _adr) external view returns (uint256) {
        return friends.doDegenzCount(_adr);
    }

    function showStatus(address _adr)
        external
        view
        returns (
            uint256,
            bool,
            bool,
            address,
            address
        )
    {
        return friends.doShowStatus(_adr, msg.sender);
    }
}

// mlq library
library mlqLib {
    uint256 public constant mlqRate = 100;
    uint256 public constant mlqDig = 10**18;
    uint256 public constant maxSupply = 3 * 10**9 * mlqDig;
    uint256 public constant pubSupply = 1 * 10**9 * mlqDig;
    uint256 public constant poolReserve = 1 * 10**9 * mlqDig;
    uint256 public constant circReserve = 1 * 10**9 * mlqDig;
}

// mlq token contract
contract MLQ is ERC20, MathFnx {
    using mlqLib for *;
    address private admin;
    uint256 public rate;
    uint256 public pubSupply;
    mapping(address => uint256) public mlqBalance;

    constructor() ERC20("Milquidity Token", "MLQ") {
        admin = msg.sender;
        setRate(mlqLib.mlqRate);
        setSupply(mlqLib.pubSupply);
    }

    function setRate(uint256 _newRate) internal returns (uint256) {
        rate = _newRate;
        return rate;
    }

    function setSupply(uint256 _newSupply) internal returns (uint256) {
        pubSupply = _newSupply;
        return pubSupply;
    }

    function buyMlq(uint256 _amnt) external payable returns (uint256) {
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(pubSupply >= amnt);
        require(divide(msg.value, 100) >= amnt);
        _mint(msg.sender, amnt);
        mlqBalance[msg.sender] = amnt;
        pubSupply -= amnt;
        return amnt;
    }

    function mlqBal(address _adr) external view returns (uint256) {
        return mlqBalance[_adr];
    }

    function withdraw(uint256 _amnt) external returns (uint256) {
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(admin == msg.sender);
        require(mlqBalance[address(this)] >= amnt);
        transferFrom(address(this), admin, amnt);
        return amnt;
    }

    function flush() external returns (uint256) {
        require(admin == msg.sender);
        transferFrom(address(this), admin, mlqBalance[address(this)]);
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
    string public title;
    mapping(address => uint256) public coinBalance;

    constructor(
        string memory _name,
        string memory _sym,
        uint256 _rate,
        uint256 _supply,
        address _admin
    ) ERC20(_name, _sym) {
        admin = _admin;
        setRate(_rate);
        maxSupply = _supply;
        title = _name;
    }

    function setRate(uint256 _newRate) internal returns (uint256) {
        rate = _newRate;
        return rate;
    }

    function getRate() external view returns (uint256) {
        return rate;
    }

    function getMax() external view returns (uint256) {
        return maxSupply;
    }

    function getName() external view returns (string memory) {
        return title;
    }

    function getMinted() external view returns (uint256) {
        return pubSupply;
    }

    function buyMlq(uint256 _amnt) external payable returns (uint256) {
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(pubSupply >= amnt);
        require(divide(msg.value, 100) >= amnt);
        _mint(msg.sender, amnt);
        coinBalance[msg.sender] = amnt;
        pubSupply += amnt;
        return amnt;
    }

    function coinBal(address _adr) external view returns (uint256) {
        return coinBalance[_adr];
    }

    function withdraw(uint256 _amnt) external returns (uint256) {
        uint256 amnt = mlqLib.mlqDig * _amnt;
        require(admin == msg.sender);
        require(coinBalance[address(this)] >= amnt);
        transferFrom(address(this), admin, amnt);
        return amnt;
    }

    function flush() external returns (uint256) {
        require(admin == msg.sender);
        transferFrom(address(this), admin, coinBalance[address(this)]);
        payable(admin).transfer(address(this).balance);
        return address(this).balance;
    }
}

contract s0xPool is MathFnx {
    COIN public coin;
    COIN public main;
    COIN public sec;
    COIN public pool;
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
        uint256 xRate;
    }
    uint256 t;
    struct Token {
        uint256 id;
        string name;
        address adr;
        uint256 maxSupply;
        uint256 mintedSupply;
        uint256 priceInEth;
    }
    uint256 s;
    struct Safe {
        uint256 id;
        address user;
        address token;
        uint256 safeBalance;
    }
    mapping(uint256 => Pool) public poolz;
    mapping(uint256 => Token) public tokenz;
    mapping(uint256 => Safe) public safez;

    function addToken(address _token) external returns (address) {
        coin = COIN(_token);
        tokenz[t] = Token(
            t,
            coin.getName(),
            address(coin),
            coin.getMax(),
            coin.getMinted(),
            coin.getRate()
        );
        t++;
        return address(coin);
    }

    function createToken(
        string memory _name,
        string memory _sym,
        uint256 _rate,
        uint256 _max
    ) external returns (address) {
        coin = new COIN(_name, _sym, _rate, _max, msg.sender);
        tokenz[t] = Token(t, _name, address(coin), _max, 0, _rate);
        t++;
        return address(coin);
    }

    function createPool(
        address _main,
        address _sec,
        string memory _name,
        string memory _psym
    ) external returns (address) {
        // get token contracts
        main = COIN(_main);
        sec = COIN(_sec);
        // detect currency eth value per token
        uint256 mEthPrice = divide(10**18, main.getRate()); // example // 10^18 / 100 = 10^16
        uint256 sEthPrice = divide(10**18, sec.getRate()); // example // 10^18 / 100000 = 10^13
        // detect dif ratio
        uint256 dRate; // difference ratio
        if (sEthPrice < mEthPrice)
            dRate = divide(mEthPrice, sEthPrice); // example // 10^16 / 10^13 = 1000
        else dRate = divide(sEthPrice, mEthPrice); // example // null
        uint256 xRate;
        xRate =
            ((mEthPrice * main.getMax()) + (sEthPrice * sec.getMax())) /
            100;
        pool = new COIN(_name, _psym, xRate, 100 * 10**18, msg.sender); // example // 100 * 10^18
        poolz[p] = Pool(
            p,
            address(pool),
            _main,
            mEthPrice,
            divide(main.getMax(), 3),
            _sec,
            sEthPrice,
            divide(sec.getMax(), 3),
            0,
            xRate
        );

        p++;
        /*

        // 0xbd5b354220B250DF257ed5e988Fe8FE81CdB6235 MLQ
        // 0x7e54D10fda1dBAf0aA2eB842942B3B924fcfd947 LYX

        mlq 10000000000000000eth * 1000000mlq
        lyx 10000000000000eth * 1000000000lyx
        shk 600000000000000000000eth * 100shk

        */
        return address(coin);
    }

    function addMilquidity(uint256 _p, uint256 _mIn)
        external
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        main = COIN(poolz[_p].main);
        sec = COIN(poolz[_p].sec);
        coin = COIN(poolz[_p].pool);
        // uint256 weth = 10**18;
        return (_mIn, 0, 0);
    }
}

contract Trees is ERC20, MathFnx {
    uint256 maxSupply;
    uint256 rate;
    uint256 availSupply;
    MLQ mlq;
    address author;
    Friends private friends;

    constructor(address _mlq) ERC20("Impact Tree Token", "IMPCTrees") {
        maxSupply = 5000000000000 * 10**18;
        author = msg.sender;
        mlq = MLQ(_mlq);
    }

    modifier isAdmin() {
        require(msg.sender == author);
        _;
    }

    function plantTree(uint256 _amount) external payable returns (bool) {
        require(msg.value >= _amount * rate * 10**12);
        require(availSupply < maxSupply);
        availSupply += msg.value * 10000;
        _mint(msg.sender, _amount * 10**18);
        return true;
    }

    function plantTreeMLQ(uint256 _amount) external payable returns (bool) {
        require(mlq.mlqBal(msg.sender) >= 100 * _amount * rate * 10**12);
        require(availSupply < maxSupply);
        mlq.transferFrom(
            msg.sender,
            address(this),
            100 * _amount * rate * 10**12
        );
        availSupply += msg.value * 10000;
        _mint(msg.sender, _amount * 10**18);
        return true;
    }

    function donateTrees(uint256 _amount) external isAdmin returns (bool) {
        require(balanceOf(msg.sender) > _amount * 10**18);
        _burn(msg.sender, _amount * 10**18);
        return true;
    }

    function approveContract(address _contract)
        external
        isAdmin
        returns (bool)
    {
        approve(_contract, balanceOf(msg.sender));
        return true;
    }

    function trimTrees(uint256 _newPrice) external returns (uint256) {
        rate = _newPrice;
        return rate;
    }

    function withdraw(uint256 _eth, uint256 _tree)
        external
        isAdmin
        returns (bool)
    {
        require(_tree * 10**18 <= balanceOf(address(this)));
        require(_eth * 10**18 <= address(this).balance);
        transfer(payable(author), _tree * 10**18);
        payable(author).transfer(_eth * 10**18);
        return true;
    }
}

contract Co2s is ERC20, MathFnx {
    IERC20 internal trees;
    MLQ mlq;
    uint256 maxSupply;
    uint256 rate;
    uint256 availSupply;
    address author;
    Friends private friends;
    struct Bond {
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

    constructor(
        address _contract,
        uint256 _percent,
        address _mlq
    ) ERC20("Carbon token", "CO2") {
        maxSupply = 25000000000000 * 10**18;
        trees = IERC20(_contract);
        per = _percent;
        mlq = MLQ(_mlq);
        author = msg.sender;
    }

    modifier isAdmin() {
        require(msg.sender == author);
        _;
    }

    function growTrees(
        uint256 _trees,
        uint256 _region,
        uint256 _duration
    ) external payable returns (bool) {
        require(msg.value >= _trees * 10**14, "not enough funds for asset");
        require(_trees <= trees.balanceOf(msg.sender), "insufficient balance");
        require(
            5 * _trees * 10**18 <= maxSupply - availSupply,
            "insufficient supply"
        );
        bonds.push(
            Bond(
                b,
                msg.sender,
                _trees * 10**18,
                _region,
                block.timestamp,
                _duration,
                5 * _trees * 10**18
            )
        );
        availSupply += 5 * _trees * 10**18;
        myBondedCo2[msg.sender][myBonds[msg.sender]] = b;
        myBonds[msg.sender]++;
        trees.transferFrom(msg.sender, payable(address(this)), _trees * 10**18);
        b++;
        return true;
    }

    function growMoreTrees(uint256 _trees, uint256 _b)
        external
        payable
        returns (bool)
    {
        require(msg.value >= _trees * 10**14);
        require(_trees <= trees.balanceOf(msg.sender));
        uint256 treez = _trees * 10**18;
        require(5 * treez <= maxSupply - availSupply);
        uint256 p = divide(100, bonds[_b].amount) * treez;
        bonds[_b].amount += treez;
        bonds[_b].co2 += 5 * treez;
        bonds[_b].duration += bonds[_b].duration * p;
        uint256 fee = divide(treez, (100 / per));
        trees.transfer(payable(address(this)), treez - fee);
        trees.transfer(payable(address(this)), fee);
        return true;
    }

    function growLessTrees(uint256 _trees, uint256 _b)
        external
        payable
        returns (bool)
    {
        require(msg.value >= _trees * 10**15);
        uint256 treez = _trees * 10**18;
        require(
            treez <= bonds[myBondedCo2[msg.sender][myBonds[msg.sender]]].amount
        );
        bonds[_b].amount -= treez;
        bonds[_b].co2 -= 5 * treez;
        uint256 fee = divide(treez, (100 / per));
        trees.transfer(payable(msg.sender), treez - fee);
        trees.transfer(payable(address(this)), fee);
        return true;
    }

    function calcFreeCo2(uint256 _b) internal view returns (uint256, uint256) {
        uint256 total = bonds[_b].duration * 60 * 60 * 24 * 365;
        uint256 passed = block.timestamp - bonds[_b].stamp;
        uint256 pDur = divide(100 * 10**18, total) * passed;
        uint256 freeCo2 = divide(100 * 10**18, bonds[_b].co2) * pDur;
        return (freeCo2, passed);
    }

    function releaseFreeCo2(uint256 _m) external returns (bool) {
        uint256 _b = myBondedCo2[msg.sender][_m]; // get b_id
        (uint256 free, uint256 passed) = calcFreeCo2(_b); // get free co2 & passed time
        require(1 * 10**18 <= free); // check amount
        bonds[_b].co2 -= free; // edit bonds data subtract
        bonds[_b].stamp = block.timestamp;
        uint256 addTime = divide(passed, (100 / per));
        bonds[_b].duration += addTime;

        uint256 fee = divide(free, (100 / per));
        _mint(msg.sender, (free - fee)); // mint free co2
        _mint(address(this), fee);
        return true;
    }

    function withdraw(
        uint256 _eth,
        uint256 _co2,
        uint256 _tree
    ) external isAdmin returns (bool) {
        require(_co2 * 10**18 <= balanceOf(address(this)));
        require(_tree * 10**18 <= trees.balanceOf(address(this)));
        require(_eth * 10**18 <= address(this).balance);
        transfer(payable(author), _co2 * 10**18);
        trees.transfer(payable(author), _tree * 10**18);
        payable(author).transfer(_eth * 10**18);
        return true;
    }
}

contract GardenPool is ERC1155, MathFnx {
    IERC20 internal TR3EZ;
    IERC20 internal CO2;
    IERC20 internal WETH;
    IERC20 internal lowC;
    IERC20 internal highC;
    address author;
    uint256 private per;
    uint256 public collectedFees;
    struct Garden {
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

    constructor(
        address _trees,
        address _co2,
        address _weth,
        uint256 _percent
    ) ERC1155("IMgardens") {
        author = msg.sender;
        TR3EZ = IERC20(_trees);
        CO2 = IERC20(_co2);
        WETH = IERC20(_weth);
        per = _percent;
    }

    modifier isAdmin() {
        require(msg.sender == author);
        _;
    }

    function createGarden(
        string memory _name,
        address _hi,
        address _lo
    ) external returns (bool) {
        _setURI(_name);
        _mint(address(this), g, 100 * 10**6, bytes(_name)); // 1 : 10 000 // 100 000 weth : 1 000 000 000 trees = 100% // 1 weth : 10 000 trees = 0,001% of max pool size
        gardens.push(
            Garden(g, _hi, 1000000000, _lo, bytes(_name), 10000, 100000, 0)
        );
        g++;
        return true;
    }

    function addliquidity(uint256 _id, uint256 _low)
        external
        payable
        returns (bool)
    {
        uint256 low = _low * 10**6;
        uint256 high = gardens[_id].low4high * low;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(lowC.balanceOf(msg.sender) >= low);
        require(highC.balanceOf(msg.sender) >= high);
        lowC.transferFrom(msg.sender, address(this), low);
        highC.transferFrom(msg.sender, address(this), high);
        uint256 gardenDrops = divide(100 * 10**6, gardens[_id].lowTotal) * low;
        safeTransferFrom(
            address(this),
            msg.sender,
            gardens[_id].id,
            gardenDrops,
            gardens[_id].description
        );
        gardens[_id].currentSize += gardenDrops;
        return true;
    }

    function removeLiquidity(uint256 _id, uint256 _gardenDrops)
        external
        payable
        returns (bool)
    {
        uint256 low = divide(100 * 10**6, gardens[_id].lowTotal) * _gardenDrops;
        uint256 high = low * gardens[_id].low4high;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(lowC.balanceOf(address(this)) >= low);
        require(highC.balanceOf(address(this)) >= high);
        lowC.transferFrom(address(this), msg.sender, low);
        highC.transferFrom(address(this), msg.sender, high);
        safeTransferFrom(
            msg.sender,
            address(this),
            gardens[_id].id,
            _gardenDrops,
            gardens[_id].description
        );
        gardens[_id].currentSize -= _gardenDrops;
        return true;
    }

    function swapLowHigh(uint256 _id, uint256 _low)
        external
        payable
        returns (bool)
    {
        uint256 low = _low * 10**6;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(lowC.balanceOf(msg.sender) >= low);
        uint256 fee = divide(100 * 10**6, low) * (100 / per);
        uint256 get = gardens[_id].low4high * (low - fee);
        require(highC.balanceOf(address(this)) >= get);
        lowC.transferFrom(msg.sender, address(this), low);
        highC.transferFrom(address(this), msg.sender, get);
        collectedFees += fee;
        return true;
    }

    function swapHighLow(uint256 _id, uint256 _high)
        external
        payable
        returns (bool)
    {
        uint256 high = _high * 10**6;
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        require(highC.balanceOf(msg.sender) >= high);
        uint256 fee = divide(100 * 10**6, high) * (100 / per);
        uint256 get = divide(high - fee, gardens[_id].low4high);
        require(highC.balanceOf(address(this)) >= get);
        highC.transferFrom(msg.sender, address(this), high);
        lowC.transferFrom(address(this), msg.sender, get);
        collectedFees += fee;
        return true;
    }

    function waterGardens(uint256 _id) external payable returns (uint256) {
        lowC = IERC20(gardens[_id].low);
        highC = IERC20(gardens[_id].high);
        uint256 lBal = lowC.balanceOf(address(this));
        uint256 hBal = highC.balanceOf(address(this));
        uint256 rRatio = divide(hBal, lBal);
        uint256 eRatio = divide(gardens[_id].low4high, 1);
        uint256 difRatio = divide(100, eRatio) * rRatio;
        return difRatio;
    }
}
