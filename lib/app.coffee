# both
Meteor.startup = ->
	Players = new Meteor.Collection("players")
	console.log('created Players')
