App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    // TODO: refactor conditional
    if (typeof web3 !== 'undefined') {
      // If a web3 instance is already provided by Meta Mask.
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(App.web3Provider);
    }
    return App.initContract();
  },

  initContract: function() {
    $.getJSON("Production.json", function(production) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.Production = TruffleContract(production);
      // Connect provider to interact with contract
      App.contracts.Production.setProvider(App.web3Provider);

      return App.render();
    });
  },

  render: function() {
    var productionInstance;
    var loader = $("#loader");
    var content = $("#content");

    loader.show();
    content.hide();

    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = account;
        $("#accountAddress").html("Your Address: " + account);
      }
    });

    // Load contract data
    App.contracts.Production.deployed().then(function(instance) {
      institutionInstance = instance;
      return institutionInstance.insCount();
  }).then(function(insCount) {
      var namediv = $("#institutionName");
      var itemdiv = $("#candidatesResults");
      var orderdiv = $("#orderValues");
      namediv.empty();
      itemdiv.empty();
      orderdiv.empty();


    institutionInstance.ownerToIns(App.account).then(function(institution) {

            var name = institution[2];
            console.log(name);
            if (name === "" ){
                namediv.append("Sorry, your address doesn't have an account associated with it.");
            }
            else{
                console.log(institution);
                var institutionTemplate = name;
                namediv.append(institutionTemplate);
                institutionInstance.insToItems(App.account).then(function(item){
                    console.log("item" + item[2]);
                    $("#content").show();
                    itemdiv.append("<tr><td>"+item[0]+"</td><td>"+item[1]+"</td><td>"+item[2]+"</td></tr>");

                });
                institutionInstance.producerToOrder(App.account).then(function(order){

                    itemId = order[1];
                    institutionInstance.idToItem(itemId).then(function(item){
                        orderdiv.append("<tr><td>"+order[0]+"</td><td>"+item[1]+"</td><td>"+order[2]+"</td><td><button type='button' class='btn btn-primary active' style='display:inline-block'>Track</button></td></tr>");
                    });

                });
            }
    });

      loader.hide();
    }).catch(function(error) {
      console.warn(error);
    });
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
