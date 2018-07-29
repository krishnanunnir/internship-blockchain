pragma solidity ^0.4.2;

contract Production{
    struct institution{
        //uint type; //There are two types of institution - Institution and seller; Institution - 0, seller -1
        uint id;
        string name;
    }
    //an address can have only one Institution associated with it
    mapping (address => institution) public ownerToIns; // mapping to corelate a owner to his institution
    uint public insCount;
    address tempAddress = 0x06F7469DB8eBd77AB4DfBdBb0836F84701501A97; //This is a temporary address holder, as address assigned by ganache constantly changes
    function addInstitute(string _name) private{ //procedure to add new Institution
        insCount++; //No of Institutions incremented
        ownerToIns[tempAddress] = institution(insCount,_name); // Institue and the owner is associated

    }
    function Production(){//This contracts constructor function
        addInstitute("Vegetables #1");
    }

}
