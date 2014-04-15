mongoimport -h localhost:3001 --db meteor --type csv --drop --headerline --collection players --file public/logs/players.csv

### from json
# mongoimport -h localhost:3001 --db meteor --collection users --file public/logs/users.json
