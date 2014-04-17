
## make sure you're not using a remote DB if using '--drop'
unset MONGO_URL
mongoimport -h localhost:3001 --db meteor --type csv --drop --headerline --collection diamonds --file public/logs/diamonds-use.csv

### from json
# mongoimport -h localhost:3001 --db meteor --collection users --file public/logs/users.json
