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

	@route "users_top",
		path: "/users"
		data: ->
			[1,2,3]

	@route "admin_top",
		path: "/admin"
		data: ->
			[1,2,3]
