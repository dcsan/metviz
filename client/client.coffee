

# getPlayerCount = ->
# 	Session.set "cbStatus", "req sent"
# 	res = Meteor.call("playerCount", (err, res) ->
# 		console.log err, res
# 		Session.set "playerCount", res
# 		Session.set "cbStatus", "got resp"
# 		return
# 	)
# 	return

playerCount = ->
	return Players.find().count()


Template.users_top.test = ->
	return "testing X"


Template.playerInfo.info = ->
	pid = 1
	p = Players.find(_id: pid)
	# Meteor.subscribe("playerInfo")
	# return "player info"

Template.oneSource.playerCount = ->
	playerCount()

Template.allSources.allSources = ->
	Calcs.findOne({
		name: "allSources"
	})

Template.filterView.data = (obj) ->
	console.log("finding filter", obj)

# Template.roiComp.data = ->
# 	data = Calcs.find({})
# 	console.log(data)
# 	data

# Template.users_top.playerCount = ->
# 	Meteor.call('playerCount', 1)
	# return Players.find().count()

# Template.hello.greeting = ->
# 	"Welcome to metviz."

# Template.hello.graph = ->
# 	svg = dimple.newSvg("body", 800, 600)
# 	data = [
# 		{
# 			Word: "Hello"
# 			Awesomeness: 2000
# 		}
# 		{
# 			Word: "World"
# 			Awesomeness: 3000
# 		}
# 	]
# 	chart = new dimple.chart(svg, data)
# 	chart.addCategoryAxis "x", "Word"
# 	chart.addMeasureAxis "y", "Awesomeness"
# 	chart.addSeries null, dimple.plot.bar
# 	chart.draw()
# 	return

# Template.hello.events "click input": ->
# 	getPlayerCount()
# 	return

# Template.hello.helpers sessData: (v) ->
# 	Session.get v

