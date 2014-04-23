Router.map ->
	@route "dashboard_top",
		path: "/dashboard/top"
		data: ->
			[1,2,3]
	 
	@route "home",
		path: "/home"
		data: ->
			[1,2,3]
	@route "home",
		path: "/"
		data: ->
			[1,2,3]


	@route "playerInfo",
		path: "/players/info/:pid"
		waitOn: ->
			return Meteor.subscribe('playerInfo', this.params.pid)
		data: ->
			params: @params
			player: Players.findOne({
				_id: Meteor.Collection.ObjectID(@params.pid)
			})

	@route "oneSource",
		path: "/sources/one/:source"
		waitOn: ->
			return Meteor.subscribe('source', this.params.source)
		data: ->
			console.log("getting source: #{@params.source}")
			params: @params
			player: Players.find({
				source: @params.source
			})

	@route "allSources",
		path: "/sources/all"
		waitOn: ->
			return Meteor.subscribe('allSources')
		data: ->
			params: @params
			sources: Calcs.findOne({name:"allSources"})


	@route "roiMenu",
		path: "/roi/menu"

	@route "roi",
		path: "/roi/campaign"
		waitOn: ->
			return Meteor.subscribe('roiCampaign')
		data: ->
			cohortName: "campaign"
			params: @params
			roiData: Calcs.find({})

	@route "roi",
		path: "/roi/source"
		waitOn: ->
			return Meteor.subscribe('roiSource')
		data: ->
			cohortName: "source"
			params: @params
			roiData: Calcs.find({})


	# @route "filterView",
	# 	path: "/sources/filter"
	# 	waitOn: ->
	# 		return Meteor.subscribe('CalcsFilter')
	# 	data: ->
	# 		params: @params
	# 		sources: Calcs.findOne({name:"filterView"})


	@route "users_top",
		path: "/users"
		data: ->
			[1,2,3]

	@route "admin_top",
		path: "/admin"
		data: ->
			[1,2,3]
