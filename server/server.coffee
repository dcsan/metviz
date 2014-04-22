CalcSources = ->
	allSources = Players.distinct "source"
	console.log("unique sources: ", allSources)
	Calcs.insert({
		name: 'allSources'
		data: allSources
	})


Meteor.startup ->
	# code to run on server at startup
	CalcSources()


# Meteor.methods playerCount: ->
# 	count = Players.find().count()
# 	count

