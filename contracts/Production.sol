pragma solidity ^0.4.2;

contract Production{
    struct institution{
        uint itype; //There are two types of institution - Institution and seller; Producer - 0, seller -1
        uint id;
        string name;
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
    }
    //an address can have only one Institution associated with it
    mapping (address => institution) public ownerToIns; // mapping to corelate a owner to his institution
    mapping (address => item) public insToItems;
    mapping (address => order) public producerToOrder;
    mapping (address => order) public sellerToOrder;
    mapping (uint => item) public idToItem;
    mapping (uint => institution) public idToIns;
    mapping (uint => order) public idToOrder;
    uint public insCount;
    uint public itemCount;
    address tempAddress = 0x06F7469DB8eBd77AB4DfBdBb0836F84701501A97; //This is a temporary address holder, as address assigned by ganache constantly changes
    function addInstitute(string _name) private{ //procedure to add new Institution
        insCount++; //No of Institutions incremented
        ownerToIns[tempAddress] = institution(0,insCount,_name); // Institue and the owner is associated
        idToIns[insCount] = ownerToIns[tempAddress];
    }

    constructor(){//This contracts constructor function
        addInstitute("Suguna Vegetables");
        insToItems[tempAddress] =item(1,"carrot",100);
        idToItem[1] = insToItems[tempAddress];
        producerToOrder[tempAddress] = order(1,1,100);
        idToOrder[1] = producerToOrder[tempAddress];
    }

}
