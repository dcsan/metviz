
## make sure you're not using a remote DB if using '--drop'
unset MONGO_URL
INFILE=logs/players.csv
COLLECTION=players

set -x
mongoimport -h localhost:3001 --db meteor --type csv --drop --headerline --collection $COLLECTION --file $INFILE

### from json
# mongoimport -h localhost:3001 --db meteor --collection users --file public/logs/users.json
