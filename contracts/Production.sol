pragma solidity ^0.4.2;

contract Production{
    struct producer{
        uint id;
        string name;
    }
    //an address can have only one producer associated with it
    mapping (address => producer) public ownerToProducer; // mapping to corelate a owner to his production
    uint producerCount;
    address tempAddress = 0x06F7469DB8eBd77AB4DfBdBb0836F84701501A97; //This is a temporary address holder, as address assigned by ganache constantly changes
    function addProducer(string _name) private{ //procedure to add new producer
        producerCount++; //No of producers incremented
        ownerToProducer[tempAddress] = producer(producerCount,_name); // Producer and the owner is associated

    }

}
