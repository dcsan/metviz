Meteor.startup ->
	@Players = new Meteor.Collection("players", {idGeneration : 'MONGO'} )

	if Meteor.isServer
		Meteor.publish "playersAll", ->
			p = Players.find()

		# Meteor.publish "playerInfo", (pid) ->
		# 	p = Players.find({
		# 		# _id: ObjectId(pid)
		# 		source: "Chartboost"
		# 	})

		Meteor.publish "source", (source) ->
			p = Players.find({
				source: source
			})

	if Meteor.isClient
		console.log('subscribing')
		# Meteor.subscribe("playersAll")
		# Meteor.subscribe("playerInfo")
		# Meteor.subscribe "playerInfo", '534c975e566a2a2e24be8045'

