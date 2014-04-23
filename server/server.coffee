toDec = (num, decimals=2) ->
	Math.round(num * 100) / 100

storeCalc = (tags, data) ->
	# tags is unique keys for how to store this
	console.log("storeCalc", tags, data)
	Calcs.upsert(
		tags,
		$set: {
			data: data
		}
	)

RunCalcs = ->
	start_date = new Date(2014, 3, 11).toISOString()
	end_date = new Date(2014, 3, 12).toISOString()

	playerCount = Players.find(
		{
			"source": "Facebook",
			"account:created": { $gt: start_date, $lt: end_date }
		}
	).count()
	# players.forEach (p) ->
	# 	console.log "player", p.name, p.source, p.campaign, p['account:created'], p.country
	storeCalc('FbPlayers', playerCount)

CohortRev = (obj) ->

	pipeline = [
		# { $match: { "source": source } },
		{ $match: 
			{
				"account:created": { $gt: obj.start_date, $lt: obj.end_date }
			}
		},

		{ $group: {
			_id: obj.cohort,
			count: { $sum: 1 }
			spend_total: { $sum: "$ltv:usd" }
			spend_avg: { $avg: "$ltv:usd" }
			level_avg: { $avg: "$player:max_quest_idx"}
			event_avg: { $avg: "$player:max_event_idx"}
			age_avg:   { $avg: "$account:age:days"}
		}}
	]

	result = Players.aggregate pipeline

	result.forEach (p) ->
		ecpi   = obj.ecpi		# estimate

		# get rid of all the noise in the campaign name, ugh
		campaign = p._id
		campaign = campaign.replace("Crystal Casters", "")
		campaign = campaign.replace("Crystal Caster", "")
		campaign = campaign.replace("App Installs", "")
		campaign = campaign.replace(" - ", "")
		campaign = campaign.replace("- ", "")
		campaign = "(none)" if campaign is ""

		p.ecpi = ecpi		
		p.campaign = campaign
		p.spend_avg = toDec(p.spend_avg)
		p.spend_total = toDec(p.spend_total)
		p.cost_avg = ecpi
		p.cost_total = p.count * ecpi
		p.roi_avg = toDec( p.spend_avg / p.cost_avg )
		p.roi_total = toDec( p.spend_total - p.cost_total )
		p.age_avg = toDec( p.age_avg)

		storeCalc({ 
			tag: "roi"
			campaign: campaign
			cohort: obj.cohort
		}, p )

	# console.dir result

months = {
	JAN: 0
	FEB: 1
	MAR: 2
	APR: 3
	MAY: 4
	JUN: 5
	JUL: 6
}

CohortCampaign = () ->
	start_date = new Date(2014, months.APR, 1).toISOString()
	end_date = new Date(2014, months.APR, 13).toISOString()

	obj = {
		cohort: "$campaign"
		start_date: start_date
		end_date: end_date
		ecpi: 1.50
	}
	CohortRev(obj)


CohortSource = () ->
	ts1 = new Date(2014, months.MAR, 1).toISOString()
	ts2 = new Date(2014, months.MAR, 10).toISOString()

	obj = {
		cohort: "$source"
		start_date: ts1
		end_date: ts2
		ecpi: 1.00
	}
	CohortRev(obj)



CalcSources = ->
	allSources = Players.distinct "source"
	# console.log("allSources: ", allSources)
	storeCalc(name:'allSources', allSources)

ClearCalcs = ->
	Calcs.remove({})

ReCalcAll = ->
	ClearCalcs()
	CohortCampaign()
	CohortSource()
	CalcSources()
	RunCalcs()	

Meteor.startup ->
	ReCalcAll()

Meteor.methods ReCalc: ->
	ReCalcAll()
