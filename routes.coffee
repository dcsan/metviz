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

	@route "source",
		path: "/players/source/:source"
		waitOn: ->
			return Meteor.subscribe('source', this.params.source)
		data: ->
			params: @params
			player: Players.find({
				source: @params.source
			})


	@route "users_top",
		path: "/users"
		data: ->
			[1,2,3]

	@route "admin_top",
		path: "/admin"
		data: ->
			[1,2,3]
