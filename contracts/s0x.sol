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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* 

INSTRUCTIONS 

Here are the source codes you will need to test the functionality of the eco mint function with USDC payment 
(because of the 0.094$ price) 

- USDC is an obvious mockUp with a airdrop function so you can grab some coins !
- Trees is the TR33 Contract that takes care of the Tree Tokenomics and gives the user his TR33 Tokens
- MLQ is our Impact.dao Utility and Liquidity Token (unused but a dependency)
- ECO is the Eco Mint NFT Contract that automates one tree per NFT into the payment process 

Hope that helps the easiest way is to deploy all the contracts in remix and try to 


Thats kind of it !

greetings and blessings https://stereoIII6.dao

*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

//      MINIMAL LAUNCH CHECKLIST AVAX, FANTOM, POLYGON , XDAI                                               (√)
//                                                                                                          /#/
// 1 ) validation that safe adrress is accessible for everyone                                              (√)
// 2 ) production VRF subscription ID                                                                       ( )
// 3 ) validate vrf consumer addresses                                                                      ( )
// 4 ) validate price consumer addresses                                                                    ( )
// 5 ) test price exchange rates weth/usdc mlq/usdc main/usdc on all networks from frontend                 ( )
//      a ) MLQ                                                                                             ( )
//      b ) S33D                                                                                            ( )
//      c ) CO2                                                                                             ( )
// 6 ) test direct payment on contract with ud ens and ether address                                        ( )
//      a ) MLQ                                                                                             ( )
//      b ) S33D                                                                                            ( )
//      c ) NFT & ECONFT **                                                                                 ( )**
// 7 ) test carbon vesting in high speed                                                                    ( )
// 8 ) test user profile and ipfs pinning function **                                                       ( )**
// 9 ) test group , posting and direct messaging **                                                         ( )**
// 10 ) test impact solbond profile NFT interface **                                                        ( )**
// 11 ) test impact marketplace dias interface **                                                           ( )**
//      a ) Layers **                                                                                       ( )**
//      b ) Keys **                                                                                         ( )**
//      c ) Actions **                                                                                      ( )**
//      d ) Spec Combos **                                                                                  ( )**
// 12 ) fractio testing dias object syntax ****                                                             ( )****
// 13 ) afl8 testing ****                                                                                   ( )****
// 14 ) drntl testing ****                                                                                  ( )****
//      a ) Governance ****                                                                                 ( )****
//      b ) Umbrella ****                                                                                   ( )****
//      c ) Project ****                                                                                    ( )****
//      d ) Holder ****                                                                                     ( )****
//
//      Phase 1 Migration Script
//      ** Phase 2 Migration Script
//      **** Phase 3 Migration Script

// tasks

/**

Upload Form integration for avatar image 

Profile section under profile button 

Soulbound Profile Extension 

TREE Token Display 


 */

// 0 Fuji // 1 Avax // 2 Fantom Test // 3 Fantom Main // 4 Polygon Mumbai // 5 Polygon Main
contract exitSafes {
    // ** CHECKLIST **
    // validation that safe adrress is accessible for everyone
    address impact;
    address fortrees;

    constructor(uint256 _net) {
        if (_net == 1) {
            // AVAX
            impact = 0x7c3348aa2Cb61784952EC22cD06e69594c47b785;
            fortrees = 0x6A583112f5536f6cC1c45019b8e61Ccc828B1368;
        } else if (_net == 3) {
            // FANTOM Opera
            impact = 0x26C546A99D845B836E4938B120791C5DA2c32a7d;
            fortrees = 0xF4D48CcD13A54400FcC3F5555dA95143a5470dbC;
        } else if (_net == 2) {
            // Fantom Test
            impact = 0xB668bB8c7E4B0bCEd0A4099beF6d6d7D42F3B810;
            fortrees = 0x9e84864E46Ca1644d2e60D89A127FDC7347ee056;
        } else if (_net == 5) {
            // Polygon
            impact = 0x34E9108143157FfDb4168d6C8861987e81089306;
            fortrees = 0x0cA8dD80519B7cEE294f25DdC132d8Fc1DbD7218;
        } else {
            // FALLBACK
            impact = 0x47d77319d00A8FFc5ebbdCFd706B50F10bd8Da57;
            fortrees = 0x7a1579D65c0BD9028c48B8e0C350aB0F625AA45d;
        }
    }
}

contract VRFv2Consumer is VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;

    // Your subscription ID.
    uint64 s_subscriptionId;
    uint256 net;

    uint32 constant callbackGasLimit = 100000;
    uint16 constant requestConfirmations = 3;
    uint32 constant numWords = 7;

    mapping(uint256 => uint256[]) public s_requestIdToRandomWords;
    mapping(uint256 => address) public s_requestIdToAddress;
    uint256 public s_requestId;
    address s_owner;

    // 0 Fuji // 1 Avax // 2 Fantom Test // 3 Fantom Main // 4 Polygon Mumbai // 5 Polygon Main
    /* 5 => /
    // Polygon Main coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0xAE975071Be8F8eE67addBC1A82488F1C24858067;
    bytes32 keyHash =
        0xd729dc84e21ae57ffb6be0053bf2b0668aa2aaf300a2a7b2ddf7dc0bb6e875a8;
    // */

    /* 4 => /
    // Polygon Mumbai coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;
    bytes32 keyHash =
        0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;

    // */

    /* 3 => /
    // Fantom Main coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0xd5D517aBE5cF79B7e95eC98dB0f0277788aFF634;
    bytes32 keyHash =
        0x64ae04e5dba58bc08ba2d53eb33fe95bf71f5002789692fe78fb3778f16121c9;

    // */

    /* 2 => /
    // Fantom Test coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0xbd13f08b8352A3635218ab9418E340c60d6Eb418;
    bytes32 keyHash =
        0x121a143066e0f2f08b620784af77cccb35c6242460b4a8ee251b4b416abaebd4;
    // */

    /* 1 => /
    // AVAX coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0x2eD832Ba664535e5886b75D64C46EB9a228C2610;
    bytes32 keyHash =
        0x06eb0e2ea7cca202fc7c8258397a36f33d88568d2522b37aaa3b14ff6ee1b696;
    // */

    /* 0 => */
    // AVAX Fuji coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0x2eD832Ba664535e5886b75D64C46EB9a228C2610;
    bytes32 keyHash =
        0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61;

    // */

    constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_owner = msg.sender;
        s_subscriptionId = subscriptionId;
    }

    function randy(uint256 _rid) external view returns (uint256[] memory) {
        return s_requestIdToRandomWords[_rid];
    }

    // Assumes the subscription is funded sufficiently.
    function requestRandomWords() external returns (uint256) {
        uint256 requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        s_requestIdToAddress[requestId] = msg.sender;

        // Store the latest requestId for this example.
        s_requestId = requestId;

        // Return the requestId to the requester.
        return requestId;
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords)
        internal
        override
    {
        // You can return the value to the requester,
        // but this example simply stores it.
        s_requestIdToRandomWords[requestId] = randomWords;
    }
}

// 0 Fuji // 1 Avax // 2 Fantom Test // 4 Fantom Main // 5 Polygon Mumbai // 6 Polygon Main
contract PriceConsumerV3 {
    AggregatorV3Interface internal ethUSDagg;
    AggregatorV3Interface internal mainUSDagg;

    constructor(uint256 _net) {
        if (_net == 0) {
            // AVAX FUJI
            ethUSDagg = AggregatorV3Interface(
                0x86d67c3D38D2bCeE722E601025C25a575021c6EA
            );
            mainUSDagg = AggregatorV3Interface(
                0x5498BB86BC934c8D34FDA08E81D444153d0D06aD
            );
        } else if (_net == 1) {
            // AVAX MAINNET
            ethUSDagg = AggregatorV3Interface(
                0x976B3D034E162d8bD72D6b9C989d545b839003b0
            );
            mainUSDagg = AggregatorV3Interface(
                0x0A77230d17318075983913bC2145DB16C7366156
            );
        } else if (_net == 2) {
            // Fantom TESTNET
            ethUSDagg = AggregatorV3Interface(
                0xB8C458C957a6e6ca7Cc53eD95bEA548c52AFaA24
            );
            mainUSDagg = AggregatorV3Interface(
                0xe04676B9A9A2973BCb0D1478b5E1E9098BBB7f3D
            );
        } else if (_net == 3) {
            // Fantom MAINNET
            ethUSDagg = AggregatorV3Interface(
                0x11DdD3d147E5b83D01cee7070027092397d63658
            );
            mainUSDagg = AggregatorV3Interface(
                0xf4766552D15AE4d256Ad41B6cf2933482B0680dc
            );
        } else if (_net == 4) {
            // Polygon Mumbai
            ethUSDagg = AggregatorV3Interface(
                0x0715A7794a1dc8e42615F059dD6e406A6594651A
            );
            mainUSDagg = AggregatorV3Interface(
                0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada
            );
        } else if (_net == 5) {
            // Polygon Mainnet
            ethUSDagg = AggregatorV3Interface(
                0xF9680D99D6C9589e2a93a78A04A279e509205945
            );
            mainUSDagg = AggregatorV3Interface(
                0xAB594600376Ec9fD91F8e885dADF0CE036862dE0
            );
        }
    }

    // gives back weth price in $
    function EthUsdPrice() external view returns (int256 price) {
        (, price, , , ) = ethUSDagg.latestRoundData();
    }

    // gives back network gas currency price in $
    function MainUsdPrice() external view returns (int256 price) {
        (, price, , , ) = mainUSDagg.latestRoundData();
    }
}

contract MathFnx {
    // Math Function Extension
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

library MLQlib {
    // MLQ Token Extension
    uint256 public constant MLQ_RATE = 100;
    uint256 public constant MLQ_DIG = 10**18;
    uint256 public constant MAX_SUPPLY = 3 * 10**9 * MLQ_DIG;
    uint256 public constant PUB_SUPPLY = 1 * 10**9 * MLQ_DIG;
    uint256 public constant POOL_RESERVE = 1 * 10**9 * MLQ_DIG;
    uint256 public constant CIRC_RESERVE = 1 * 10**9 * MLQ_DIG;
}

contract Users {
    // user data storage for conglomerate
    address private s0x; // s0x admin

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
    mapping(address => string) public name;

    modifier isAdmin() {
        require(msg.sender == s0x);
        _;
    }

    constructor() {
        s0x = msg.sender; // admin initialization
        makeUser(
            s0x,
            '{"name":"s0xAdmin","email":"type.stereo@pm.me","image":"https://ipfs.io/ipfs/QmXNciGvGJGRV2HHE82oLoicvwatB8sqsydxn7P3NSP1nW"}',
            99,
            "s0xAdmin"
        ); // admin user account setup
    }

    // takes address , dias , and role to create and store a user profile in user mapping
    function makeUser(
        address _adr,
        bytes memory _dias,
        uint256 _r,
        string memory _name
    ) internal returns (bool) {
        users[_adr] = _dias;
        roles[_adr] = _r;
        impx[_adr] = Impact(0, 0, 0);
        name[_adr] = _name;
        isUser[_adr] = true;
        return true;
    }

    // takes dias to create guest user profile
    function createUserAccount(
        string memory _dias,
        address _user,
        string calldata _name
    ) external returns (bool) {
        return makeUser(_user, bytes(_dias), 2, _name);
    }

    // takes address , dias , and role to admin edit and store a user profile in user mapping
    function adminEditUser(
        address _adr,
        string memory _dias,
        uint256 _r
    ) external isAdmin returns (bool) {
        string memory _name = name[_adr];
        return makeUser(_adr, bytes(_dias), _r, _name);
    }

    // takes address , dias , and role to edit and store your user profile in user mapping
    function editUser(string memory _dias) external returns (bool) {
        string memory _name = name[msg.sender];
        return makeUser(msg.sender, bytes(_dias), 2, _name);
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

    function getName(address _adr) external view returns (string memory) {
        return name[_adr];
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

contract s0xFactory is Users, MathFnx {
    Friends public friends;
    Groups public groups;
    MLQ public mlq;
    address private fAdr;
    mapping(address => uint256) public groupCount;
    mapping(address => mapping(uint256 => address)) public groupByCount;

    constructor(address _mlq) Users() MathFnx() {
        mlq = MLQ(payable(_mlq));
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

contract USDC is ERC20 {
    constructor() ERC20("US Dollar Coin", "USDC") {}

    function dropUSDC() external {
        _mint(msg.sender, 100 * 10**18);
    }
}

// 0 Fuji // 1 Avax // 2 Fantom Test // 4 Fantom Main // 5 Polygon Mumbai // 6 Polygon Main
contract MLQ is ERC20, MathFnx, exitSafes {
    using MLQlib for *;
    address private admin;
    int256 public rate;
    uint256 public PUB_SUPPLY;
    uint256 MLQ_RATE;
    uint256 mainRate;
    PriceConsumerV3 public ethUsdPrice;
    mapping(address => uint256) public mlqBalance;
    USDC usdc;

    constructor(
        address _usdc,
        address _pc,
        uint256 _net
    ) ERC20("Milquidity Token", "MLQ") exitSafes(_net) {
        admin = msg.sender;
        usdc = USDC(_usdc);
        setSupply(MLQlib.PUB_SUPPLY);
        ethUsdPrice = PriceConsumerV3(_pc);
    }

    function setMLQRate() internal returns (int256) {
        int256 price = ethUsdPrice.EthUsdPrice();
        uint256 newRate = divide(uint256(price), 100);
        rate = int256(newRate);
        return rate;
    }

    function setMainRate() internal returns (int256) {
        int256 price = ethUsdPrice.MainUsdPrice();
        uint256 newRate = divide(uint256(price), 100);
        rate = int256(newRate);
        return rate;
    }

    function setSupply(uint256 _newSupply) internal returns (uint256) {
        PUB_SUPPLY = _newSupply;
        return PUB_SUPPLY;
    }

    function buyMlqMain() external payable returns (uint256) {
        setMLQRate();
        setMainRate();
        uint256 swapRate = divide(mainRate, MLQ_RATE);
        uint256 amnt = msg.value * swapRate;
        require(amnt > address(this).balance, "insufficient balance");
        // find maincurr price for mlq
        require(PUB_SUPPLY >= amnt);
        _mint(msg.sender, amnt);
        mlqBalance[msg.sender] += amnt;
        PUB_SUPPLY -= amnt;
        return amnt;
    }

    function buyMlqUSDC(uint256 _amnt) external payable returns (uint256) {
        setMLQRate();
        uint256 amnt = _amnt * uint256(rate) * 10**10;
        require(PUB_SUPPLY >= amnt);
        usdc.transferFrom(msg.sender, address(this), amnt);
        _mint(msg.sender, _amnt * 10**18);
        mlqBalance[msg.sender] = _amnt * 10**18;
        PUB_SUPPLY -= amnt;
        return amnt;
    }

    function mlqBal(address _adr) external view returns (uint256) {
        return mlqBalance[_adr];
    }

    function withdraw(uint256 _amnt) external returns (uint256) {
        uint256 amnt = MLQlib.MLQ_DIG * _amnt;
        require(admin == msg.sender);
        require(mlqBalance[address(this)] >= amnt);
        transferFrom(address(this), admin, amnt);
        return amnt;
    }

    function flush() external returns (uint256) {
        require(admin == msg.sender);
        transferFrom(address(this), admin, mlqBalance[address(this)]);
        payable(admin).transfer(address(this).balance);
        usdc.transferFrom(address(this), admin, usdc.balanceOf(address(this)));
        return address(this).balance;
    }

    receive() external payable {
        uint256 ethAmntImpact = divide(msg.value, 100) * 15;
        uint256 ethAmntTrees = msg.value - ethAmntImpact;
        payable(impact).transfer(ethAmntImpact);
        payable(fortrees).transfer(ethAmntTrees);
        uint256 swapRate = divide(MLQ_RATE, uint256(rate));
        uint256 trees = msg.value * swapRate;
        transfer(msg.sender, trees);
    }
}

// 0 Fuji // 1 Avax // 2 Fantom Test // 4 Fantom Main // 5 Polygon Mumbai // 6 Polygon Main
contract Trees is ERC20, MathFnx, exitSafes {
    uint256 MAX_SUPPLY;
    uint256 rate;
    uint256 MLQ_RATE;
    uint256 mainRate;
    uint256 availSupply;
    address author;
    PriceConsumerV3 public ethUsdPrice;
    IERC20 usdc;
    MLQ mlq;
    event Log(uint256 l, address f, address t, uint256 b, uint256 a);
    uint256 l;

    constructor(
        address _usdc,
        address _mlq,
        address _pc,
        uint256 _net
    ) ERC20("Seedling", "S33D") exitSafes(_net) {
        MAX_SUPPLY = 5000000000000 * 10**18;
        author = msg.sender;
        usdc = IERC20(_usdc);
        mlq = MLQ(payable(_mlq));
        rate = 94 * 10**15;
        ethUsdPrice = PriceConsumerV3(_pc);
    }

    modifier isAdmin() {
        require(msg.sender == author);
        _;
    }
    mapping(address => uint256) public treeClaims;

    function addClaim(address _adr, uint256 _amnt) external returns (bool) {
        treeClaims[_adr] += _amnt;
        return true;
    }

    function getClaims() external returns (bool) {
        _mint(msg.sender, treeClaims[msg.sender]);
        treeClaims[msg.sender] = 0;
        return true;
    }

    function buyTreeUSDC(uint256 _amount, address _send)
        external
        returns (bool)
    {
        emit Log(
            l,
            _send,
            impact,
            usdc.balanceOf(_send),
            usdc.balanceOf(address(this))
        );
        l++;
        require(
            usdc.balanceOf(_send) >= _amount * rate,
            "insufficient usdc balance"
        );
        require(
            availSupply + _amount * 10**18 < MAX_SUPPLY,
            "insufficient supply"
        );
        usdc.transferFrom(_send, fortrees, ((_amount * rate) / 100) * 85);
        usdc.transferFrom(_send, impact, ((_amount * rate) / 100) * 15);
        availSupply += _amount * 10**18;
        _mint(msg.sender, _amount * 10**18);
        return true;
    }

    function buyTreesMainnet(uint256 _amount, address _send)
        external
        payable
        returns (bool)
    {
        setMainRate();
        uint256 swapRate = divide(mainRate, rate);
        emit Log(l, _send, fortrees, _send.balance, address(this).balance);
        l++;
        require(
            _send.balance >= _amount * swapRate,
            "insufficient usdc balance"
        );
        require(
            availSupply + _amount * 10**18 < MAX_SUPPLY,
            "insufficient supply"
        );
        require(msg.value >= _amount * swapRate, "insufficient usdc balance");
        payable(fortrees).transfer(((_amount * swapRate) / 100) * 85);
        payable(impact).transfer(((_amount * swapRate) / 100) * 15);
        availSupply += _amount * 10**18;
        _mint(msg.sender, _amount * 10**18);
        return true;
    }

    function makeRate() external returns (uint256) {
        return setMainRate();
    }

    function setMainRate() internal returns (uint256) {
        int256 mainR = ethUsdPrice.MainUsdPrice();
        mainRate = uint256(mainR);
        return (uint256(mainR));
    }

    function setMLQRates() internal returns (uint256) {
        int256 mlqR = ethUsdPrice.EthUsdPrice();
        MLQ_RATE = uint256(mlqR);
        return (uint256(mlqR));
    }

    function buyTreeMLQ(uint256 _amount, address _send)
        external
        returns (bool)
    {
        uint256 swapRate = divide(MLQ_RATE, rate);
        emit Log(
            l,
            _send,
            fortrees,
            mlq.balanceOf(_send),
            mlq.balanceOf(address(this))
        );
        l++;
        require(
            mlq.balanceOf(_send) >= _amount * swapRate,
            "insufficient usdc balance"
        );
        require(
            availSupply + _amount * 10**18 < MAX_SUPPLY,
            "insufficient supply"
        );
        mlq.transferFrom(_send, fortrees, ((_amount * swapRate) / 100) * 85);
        mlq.transferFrom(_send, impact, ((_amount * swapRate) / 100) * 15);
        availSupply += _amount * 10**18;
        _mint(msg.sender, _amount * 10**18);
        return true;
    }

    function donateTrees(uint256 _amount) external isAdmin returns (bool) {
        require(balanceOf(msg.sender) > _amount * 10**18);
        _burn(msg.sender, _amount * 10**18);
        return true;
    }

    function approveContract(address _contract) external returns (bool) {
        approve(_contract, balanceOf(msg.sender));
        return true;
    }

    function setERC20(address _usdc) external isAdmin returns (bool) {
        usdc = IERC20(_usdc);
        return true;
    }

    function setMLQ(address _mlq) external isAdmin returns (bool) {
        mlq = MLQ(payable(_mlq));
        return true;
    }

    function approveUSDC(uint256 _amnt) external pure returns (bool) {
        // delegated call to approve
        return _amnt == _amnt;
    }

    function trimTrees(uint256 _newPrice) external returns (uint256) {
        rate = _newPrice;
        return rate;
    }

    receive() external payable {
        uint256 ethAmntImpact = divide(msg.value, 100) * 15;
        uint256 ethAmntTrees = msg.value - ethAmntImpact;
        payable(impact).transfer(ethAmntImpact);
        payable(fortrees).transfer(ethAmntTrees);
        uint256 swapRate = divide(MLQ_RATE, rate);
        uint256 trees = msg.value * swapRate;
        transfer(msg.sender, trees);
    }

    function withdraw(uint256 _eth, uint256 _tree)
        external
        isAdmin
        returns (bool)
    {
        require(_tree * 10**18 <= balanceOf(address(this)));
        require(_eth * 10**18 <= address(this).balance);
        transfer(payable(impact), _tree * 10**18);
        payable(impact).transfer(_eth * 10**18);
        return true;
    }
}

contract nftProject is ERC721 {
    address public owner;
    uint256 public minted;
    uint256 public max;
    string public nam;
    string public sym;
    VRFv2Consumer public vrf;
    ERC20 public usdc;
    MLQ public mlq;
    // token id # => dias obj %
    mapping(uint256 => bytes) public dias;
    // user address @ => nft count #
    mapping(address => uint256) public nftCount;
    // user address @ => nft count # => nft id #
    mapping(address => mapping(uint256 => uint256)) public ntfIdByCount;

    constructor(
        address _owner,
        string memory _name,
        string memory _sym,
        address _usdc,
        address _vrf,
        address _mlq
    ) ERC721(_name, _sym) {
        owner = _owner;
        max = 1000;
        nam = _name;
        sym = _sym;
        vrf = VRFv2Consumer(_vrf);
        usdc = ERC20(_usdc);
        mlq = MLQ(payable(_mlq));
    }

    function isOwner(address _adr) external view returns (bool) {
        if (_adr == owner) return true;
        else return false;
    }

    function getName() external view returns (string memory) {
        return nam;
    }

    function getSym() external view returns (string memory) {
        return sym;
    }

    function mint(uint256 _amnt) external returns (uint256) {
        require(minted < max);
        doMint(_amnt);
        return minted;
    }

    function getVrfId() internal returns (uint256[] memory) {
        uint256 rid = vrf.requestRandomWords();
        return vrf.randy(rid);
    }

    function grabIds(uint256 count) external view returns (uint256 ids) {
        return ids = ntfIdByCount[msg.sender][count];
    }

    function doMint(uint256 _amnt) internal returns (uint256) {
        _mint(msg.sender, minted);
        minted++;
        if (_amnt >= 2) {
            _mint(msg.sender, minted);
            minted++;

            if (_amnt >= 3) {
                _mint(msg.sender, minted);
                minted++;

                if (_amnt >= 4) {
                    _mint(msg.sender, minted);
                    minted++;

                    if (_amnt >= 5) {
                        _mint(msg.sender, minted);
                        minted++;

                        if (_amnt >= 6) {
                            _mint(msg.sender, minted);
                            minted++;

                            if (_amnt >= 7) {
                                _mint(msg.sender, minted);
                                minted++;
                            }
                        }
                    }
                }
            }
        }
        return minted;
    }

    function holder(uint256 _id) external view returns (address) {
        return ownerOf(_id);
    }
}

// 0 Fuji // 1 Avax // 2 Fantom Test // 4 Fantom Main // 5 Polygon Mumbai // 6 Polygon Main
contract EcoMintNFT is nftProject, exitSafes, MathFnx {
    Trees public trees;
    uint256 nftPrice;
    uint256 val;

    constructor(
        address _owner,
        string memory _name,
        string memory _sym,
        address _treeAdr,
        address _usdc,
        address _vrf,
        address _mlq,
        uint256 _net
    ) nftProject(_owner, _name, _sym, _usdc, _vrf, _mlq) exitSafes(_net) {
        trees = Trees(payable(_treeAdr));
        nftPrice = 25 * 10**18;
        val = 94 * 10**15;
    }

    function setValue(uint256 _val) external returns (uint256) {
        return val = _val;
    }

    function ecoMint(uint256 _amnt) external returns (uint256) {
        require(minted < max);
        uint256 sub = nftPrice + val;
        uint256 total = _amnt * sub;
        uint256 fee = 3 * 10**18;
        require(total + fee < usdc.balanceOf(msg.sender), "insufficient funds");
        usdc.transferFrom(msg.sender, impact, fee);
        usdc.transferFrom(msg.sender, fortrees, divide(total, 100) * 85);
        usdc.transferFrom(msg.sender, impact, divide(total, 100) * 15);
        trees.addClaim(msg.sender, _amnt * 10**18);
        doMint(_amnt);
        return minted;
    }
}

contract RiteWhabbits is EcoMintNFT {
    constructor(
        address _owner,
        string memory _name,
        string memory _sym,
        address _treeAdr,
        address _usdc,
        address _vrf,
        address _mlq,
        uint256 _net
    ) EcoMintNFT(_owner, _name, _sym, _treeAdr, _usdc, _vrf, _mlq, _net) {}

    mapping(uint256 => bytes) private _tokenStatus;
    mapping(uint256 => uint256) private _tokenVRF;
    mapping(uint256 => bytes) private _tokenTraitScramble;
    struct Traits {
        uint256 bg0; // far landscape
        uint256 bg1; // mid
        uint256 bg2; // near
        uint256 bodybg0; // min body shape
        uint256 bodybg1; // female shape < .5
        uint256 bodybg2; // male shape >= .5
        uint256 hair;
        uint256 hat;
        uint256 eyes;
        uint256 eyebrows;
        uint256 glasses;
        uint256 nose;
        uint256 mouth;
        uint256 beard;
    }
}

contract Co2s is ERC20, MathFnx {
    IERC20 internal trees;
    MLQ mlq;
    uint256 rate;
    uint256 availSupply;
    address author;
    uint256 time;
    nftProject nft;
    Friends private friends;
    struct Bond {
        uint256 id;
        address adr;
        uint256 amount;
        string region;
        uint256 stamp;
        uint256 end;
        uint256 co2;
    }
    struct Tx {
        uint256 tid;
        uint256 bid;
        uint256 co2;
        uint256 date;
    }
    mapping(address => uint256) public myBonds;
    mapping(uint256 => uint256) public allBonds;
    mapping(address => mapping(uint256 => uint256)) public myBondedCo2;
    mapping(address => uint256) public myTxCount;
    mapping(address => mapping(uint256 => uint256)) public myTxs;
    Bond[] public bonds;
    Tx[] public txs;
    uint256 t;
    uint256 b;
    uint256 per;

    constructor(
        address _contract,
        uint256 _percent,
        address _mlq,
        uint256 _net
    ) ERC20("Carbon Certificate", "C4RB") {
        trees = IERC20(_contract);
        per = _percent;
        mlq = MLQ(payable(_mlq));
        author = msg.sender;
        if (_net == 1 || _net == 3 || _net == 5) time = 3600 * 24 * 365 * 5;
        else time = 60 * 5;
    }

    modifier isAdmin() {
        require(msg.sender == author);
        _;
    }

    function setNFT(address _nft) external returns (address) {
        nft = nftProject(_nft);
        return address(nft);
    }

    function showNFTdata(uint256 _id) external view returns (string memory) {
        // read NFT data by ID
        bytes memory see_dias = nft.dias(_id);
        return string(see_dias);
    }

    function setBondRate(uint256 _rate) external returns (uint256) {
        return rate = _rate;
    }

    function _createBond(
        uint256 _amnt,
        string memory _loc,
        uint256 _stamp,
        address _sender,
        uint256 _id
    ) internal returns (uint256) {
        require(msg.sender == _sender, "you do not own the plantation");
        bonds.push(
            Bond(_id, _sender, _amnt, _loc, _stamp, _stamp + time, _amnt * 5)
        );
        allBonds[b] = _id;
        myBondedCo2[_sender][myBonds[_sender]] = _id;
        myBonds[_sender]++;
        b++;
        return b - 1;
    }

    function createBond(
        uint256 _amnt,
        string memory _loc,
        uint256 _stamp,
        address _sender,
        uint256 _id
    ) external returns (uint256) {
        return _createBond(_amnt, _loc, _stamp, _sender, _id);
    }

    function _checkBond(uint256 _id) internal view returns (uint256) {
        Bond memory bond = bonds[_id];
        require(msg.sender == bond.adr);
        if (bond.end > block.timestamp) {
            uint256 diff = bond.end - block.timestamp;
            uint256 modo = (time) % 100;
            uint256 perc = (((time) - modo) / 100) * diff;
            uint256 mod = bond.co2 % 100;
            uint256 eq = ((bond.co2 - mod) / 100) * perc;
            return eq;
        } else {
            return bond.co2;
        }
    }

    function checkBond(uint256 _id) external view returns (uint256) {
        return _checkBond(_id);
    }

    function claimBond(uint256 _id) external returns (uint256 eq) {
        Bond memory bond = bonds[_id];
        require(msg.sender == bond.adr);
        eq = _checkBond(_id);
        if (eq > 1 * 10**16) {
            bond.co2 = bond.co2 - eq;
            txs[t] = Tx(t, _id, eq, block.timestamp);
            myTxs[msg.sender][myTxCount[msg.sender]] = t;
            myTxCount[msg.sender]++;
            bonds[_id] = bond;
            _mint(bond.adr, eq);
        }
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
        uint256 _percent
    ) ERC1155("IMgardens") {
        author = msg.sender;
        TR3EZ = IERC20(_trees);
        CO2 = IERC20(_co2);
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

contract COIN is ERC20, MathFnx {
    using MLQlib for *;
    address private admin;
    uint256 public rate;
    uint256 public PUB_SUPPLY;
    uint256 public MAX_SUPPLY;
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
        MAX_SUPPLY = _supply;
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
        return MAX_SUPPLY;
    }

    function getName() external view returns (string memory) {
        return title;
    }

    function getMinted() external view returns (uint256) {
        return PUB_SUPPLY;
    }

    function buyMlq(uint256 _amnt) external payable returns (uint256) {
        uint256 amnt = MLQlib.MLQ_DIG * _amnt;
        require(PUB_SUPPLY >= amnt);
        require(divide(msg.value, 100) >= amnt);
        _mint(msg.sender, amnt);
        coinBalance[msg.sender] = amnt;
        PUB_SUPPLY += amnt;
        return amnt;
    }

    function coinBal(address _adr) external view returns (uint256) {
        return coinBalance[_adr];
    }

    function withdraw(uint256 _amnt) external returns (uint256) {
        uint256 amnt = MLQlib.MLQ_DIG * _amnt;
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
        uint256 MAX_SUPPLY;
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

contract ecoverse is nftProject {
    address admin;
    address trees;
    Trees tree;
    Co2s co2s;
    mapping(uint256 => uint256) public amount;
    mapping(uint256 => bytes) public location;
    mapping(uint256 => address) public ownedBy;
    mapping(uint256 => uint256) public stamped;

    constructor(
        address _trees,
        address _usdc,
        address _mlq,
        address _vrf,
        address _co2
    )
        nftProject(
            msg.sender,
            "Plantation Certificate",
            "PLNT8",
            _usdc,
            _vrf,
            _mlq
        )
    {
        admin = msg.sender;
        tree = Trees(payable(_trees));
        co2s = Co2s(payable(_co2));
    }

    modifier isAdmin() {
        require(msg.sender == admin);
        _;
    }

    function mintCertificate(
        string memory _dias,
        uint256 _id,
        uint256 _amnt,
        string memory _loc
    ) external returns (bool) {
        // get trees from user
        tree.transferFrom(msg.sender, address(this), _amnt);
        // place info on certificate dias
        dias[_id] = bytes(_dias);
        // set certificate info on contract
        amount[_id] = _amnt;
        location[_id] = bytes(_loc);
        ownedBy[_id] = msg.sender;
        stamped[_id] = block.timestamp;
        _mint(msg.sender, _id);
        ntfIdByCount[msg.sender][nftCount[msg.sender]] = _id;
        nftCount[msg.sender]++;
        return true;
    }

    function showDias(uint256 _id) external view returns (string memory) {
        return string(dias[_id]);
    }

    function editCertificate(
        uint256 _id,
        string memory _dias_new,
        string memory _loc_new
    ) external returns (bool) {
        // check approval
        require(msg.sender == ownedBy[_id]);
        // find certificate
        // overwrite certificate dias
        dias[_id] = bytes(_dias_new);
        location[_id] = bytes(_loc_new);
        return true;
    }
}

// MAINNET CHECKLIST

// new safe & clean deploy address √
// 2x multisig exit safe address output wallets √
// token names and symbols √
// migration on the right network √
// funded vrf link subs on 0xe55E1a1C7C8A82648aEdBb2853a01306CE97Df87 √

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
