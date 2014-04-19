getPlayerCount = ->
	Session.set "cbStatus", "req sent"
	res = Meteor.call("playerCount", (err, res) ->
		console.log err, res
		Session.set "playerCount", res
		Session.set "cbStatus", "got resp"
		return
	)
	return

Meteor.subscribe "players"

Template.users_top.test = ->
	return "testing"

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

