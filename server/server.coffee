Meteor.startup ->
	# code to run on server at startup
	c = Players.find().count()
	console.log "players count:", c
	# p = Players.find({},
	# 	limit: 20
	# )
	# p.forEach (px) ->
	# 	console.dir px.name




# Meteor.methods playerCount: ->
# 	count = Players.find().count()
# 	count

