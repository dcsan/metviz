Meteor.startup(function () {

});


// code to run on server at startup
var c = Players.find().count();
console.log('players count:', c);

p = Players.find(
	{},
	{limit: 20}
);

// console.dir(p.fetch()[0])

p.forEach(function(px){
	// console.dir(px);
	console.dir(px.name);
})

// Meteor.publish("players", function(channel_name) {
//     return Messages.find({channel: channel_name});
// });

Meteor.publish("players", function() {
	return Players.find({});
});

Meteor.methods({
	playerCount: function() {
		// return(5);
		return(Players.find().count() );
	}
});