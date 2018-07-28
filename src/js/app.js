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
        $("#accountAddress").html("Your Account: " + account);
      }
    });

    // Load contract data
    App.contracts.Production.deployed().then(function(instance) {
      productionInstance = instance;
      return productionInstance.producerCount();
      }).then(function(producerCount) {
      var candidatesResults = $("#candidatesResults");
      candidatesResults.empty();


    productionInstance.ownerToProducer(App.account).then(function(producer) {
        var id = producer[0];
        var name = producer[1];

        // Render candidate Result
        var candidateTemplate = "<tr><th>" + id + "</th><td>" + name +  "</td></tr>"
        candidatesResults.append(candidateTemplate);
    });

      loader.hide();
      content.show();
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
