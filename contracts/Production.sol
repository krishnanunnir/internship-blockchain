pragma solidity ^0.4.2;
//Find the value of nextLocAddress which is the function to be achieved tomorrow
contract Production{
    struct institution{
        uint itype; //There are two types of institution - Institution and seller; Producer - 0, seller -1
        uint id;
        string name;
        address accountOwner;
    }
    struct item{
        uint id;
        string name;
        uint price;
    }
    struct order{
        uint id;
        uint itemId;
        uint quantity;
        uint srcId;
        uint destId;
        //uint[] pathF;
    }
    struct loc{
        uint id;
        string locName;
        address locOwner;
    }

    struct path{
        uint id;
        uint src;
        uint dest;
        //size 10 array is described as the largest size
        uint8[10] pathId;
    }

    mapping (uint => item) public idToItem;
    mapping (uint => institution) public idToIns;
    mapping (uint => order) public idToOrder;
    mapping (uint => loc) public idToLoc;
    mapping (uint => path) public idToPath;
    //an address can have only one Institution associated with it
    // mapping to corelate a owner to his institution

    mapping (address => institution) public ownerToIns;
    mapping (address => item) public insToItems;
    mapping (address => order) public producerToOrder;
    mapping (address => order) public sellerToOrder;
    //int to address corelation to perform tracking
    mapping (uint => uint) public currentlyWithId;
    mapping (uint => uint) public nextId;
    mapping (uint => uint) public nextLocId;
    //mapping all the pending delivery to their address they should arrive at and also the status which is a bool
    mapping (address => uint) arrivedHere;
    //counters to store the equvalent id's
    uint public insCount;
    uint public itemCount;
    uint public orderCount;
    uint public locCount;
    uint public pathCount;
    //This is a temporary address holder, as address assigned by ganache constantly changes
    address tempAddress1 = 0x06F7469DB8eBd77AB4DfBdBb0836F84701501A97;
    address tempAddress2 = 0xFa2E3cbbdB6123b4CecdB113a8C11d9063292869;
    address tempAddress3 = 0x255b70c41cf3b8885BCFD0969A46526dcF605F17;
    address tempAddress4 = 0x9FDEbF94526158d8A5FC323E1713F190c4B1E7BA;
    address tempAddress5 = 0x13182E9a4c93B63B1ACf7A4C71a38ca6a1e6ba6c;
    //procedures to add new struct instance
    function addInstitute(uint _typeId, string _name, address tempAddress) private{
        insCount++;
        ownerToIns[tempAddress] = institution(_typeId,insCount,_name,tempAddress);
        idToIns[insCount] = ownerToIns[tempAddress];
    }


    function addItem(string _name,uint price,address tempAddress) private{
        itemCount++;
        insToItems[tempAddress] =item(itemCount,_name,price);
        idToItem[itemCount] = insToItems[tempAddress];

    }


    function addOrder(uint _itemId,uint quantity,uint src,uint dest,address tempAddress) private{
        orderCount++;
        producerToOrder[tempAddress] = order(orderCount,_itemId,quantity,src,dest);
        idToOrder[orderCount] = producerToOrder[tempAddress];
        arrivedHere[tempAddress] = orderCount;
        currentlyWithId[orderCount] = src;
        findNext(orderCount);

    }


    function addLoc(string _locName,address tempAddress) private{
        locCount++;
        idToLoc[locCount] =loc(locCount,_locName,tempAddress);

    }


    function addPath(uint orderId,uint _srcId,uint _destId,uint8[10] _path) private{
        pathCount++;
        idToPath[pathCount] = path(pathCount,_srcId,_destId,_path);


    }
    function findNext(uint orderId) private{
        nextLocId[orderId] = nextId[currentlyWithId[orderCount]];


    }

    function demo(){
        addInstitute(0,"freshfr",tempAddress1);
        addInstitute(1,"Suguna",tempAddress5);
        addInstitute(2,"warehouse1",tempAddress2);
        addInstitute(2,"warehouse2",tempAddress3);
        addInstitute(2,"warehouse3",tempAddress4);
        addItem("carrot",100,tempAddress1);
        addLoc("telengana",tempAddress1);
        addLoc("hyderabad",tempAddress2);
        addLoc("bangalore",tempAddress3);
        addLoc("kochi",tempAddress4);
        addLoc("alapuzha",tempAddress5);
        addOrder(1,100,1,2,tempAddress1);
        addPath(1,1,5,[1,2,3,4,5,0,0,0,0,0]);

    }


    constructor(){//This contracts constructor function
        demo();

    }


}
