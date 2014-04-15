Meteor.subscribe("players");

Template.hello.greeting = function () {
  return "Welcome to metviz.";
};

Template.hello.graph = function() {
  var svg = dimple.newSvg("body", 800, 600);
  var data = [
    { "Word":"Hello", "Awesomeness":2000 },
    { "Word":"World", "Awesomeness":3000 }
  ];
  var chart = new dimple.chart(svg, data);
  chart.addCategoryAxis("x", "Word");
  chart.addMeasureAxis("y", "Awesomeness");
  chart.addSeries(null, dimple.plot.bar);
  chart.draw();
};

function getPlayerCount() {
  Session.set('cbStatus', 'req sent');
  var res = Meteor.call('playerCount', function(err, res) {
    console.log(err, res);
    Session.set('playerCount', res);
    Session.set('cbStatus', 'got resp');
  });  
}


Template.hello.events({
  'click input': function () {
    getPlayerCount();
  }
});

Template.hello.helpers({
  sessData: function(v) {
    return Session.get(v);
  }
})
