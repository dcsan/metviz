Meteor.startup ->
	# code to run on server at startup
	c = Players.find().count()
	console.log "players count:", c
	p = Players.find({},
		limit: 20
	)

	# console.dir(p.fetch()[0])
	p.forEach (px) ->

	# console.dir(px);
	console.dir px.name
	return


# Meteor.publish("players", function(channel_name) {
#     return Messages.find({channel: channel_name});
# });
# Meteor.publish "players", ->
# Players.find {}

# Meteor.methods playerCount: ->

# # return(5);
# Players.find().count()

