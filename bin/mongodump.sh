#!/usr/bin/env bash

# setopt ignorebraces

set -x

# usage() { echo "Usage: $0 [-e <prod | stag | dev | local>] [-d <backup_dir>]" 1>&2; exit 1; }

while getopts ":e:d:-:" OPTION; do
    case "$OPTION" in
        -)  case "$OPTARG" in
                env) ENV="${!OPTIND}";;
                dir) DIR="${!OPTIND}" ;;
            esac;;
        # e)  ENV="$OPTARG" ;;
        # d)  DIR="$OPTARG" ;;
        *) usage ;;
    esac
done

if [ -z "${ENV}" ] || [ -z "${DIR}" ]; then
    echo "no -e or -d args"
    echo "assuming -e ${ENV} "
    ENV='prod'
    DIR='logs/mongodump'
    # usage
fi

ENV='prod'
DIR='logs/mongodump'

echo "backing up to ${DIR}"

mongo_env=`echo ${ENV} | awk '{print toupper($0)}'`
var_name=`echo MONGOVIZ_${mongo_env}_MONGO_URI`
mongo_uri=${!var_name}
mongo_array=(`echo $mongo_uri | sed -En 's/(^mongodb:\/\/)(.*):(.*)@(.*)\/(.*)/\2 \3 \4 \5/p'`)

username=${mongo_array[0]}
password=${mongo_array[1]}
IFS="," host=(${mongo_array[2]})
db=${mongo_array[3]}

if [ ${ENV} == 'local' ]; then
    mongodump --db spellchain -o ${DIR}
    exit 0
fi


## lost a quest
# query='{"app:client_ver":"1.51.0", event:"quest:end", "quest:won":0 }'
## did a boost

evt="players"

## set defaults which maybe overridden below
collection="metrics"
outfile="logs/mongodump/${evt}.csv"
fieldFile="bin/mongo/fieldFiles/${evt}.txt"

if [ $evt == "players" ]; then
    query='{"app:client_ver": {$in: ["2.0.0", "1.52.0", "1.51.1", "1.51.0", "1.50.2", "1.49.3"]} }'
    collection="players"

elif [ $evt == 'boost' ]; then
    query='{"app:client_ver": {$in: ["1.51.0","1.50.2","1.49.3"]}, event:"boost"}'

elif [ $evt == "quest" ]; then
    # query='{"app:client_ver": {$in: ["1.51.0","1.50.2","1.49.3"]}, event:{$in: ["quest:start","quest:end"]} }'
    query='{"app:client_ver": {$in: ["1.51.0","1.50.2","1.49.3"]}, event:"quest:end" }'

elif [ $evt == "multi" ]; then
    query='{"app:client_ver": {$in: ["1.51.0","1.50.2","1.49.3"]}, event:{$in: ["quest:end","app_open","boost","evolve","cashflow","card:sell","deck:edit","levelup","popup","summon:buy"]} }'

elif [ $evt == "popup" ]; then
    # check for starter pack
    query='{"app:client_ver": "1.51.0", event: {$in: ["popup", "cashflow"]} }'
    fieldFile="bin/mongo/fieldFiles/multi.txt"

elif [ $evt == "tut" ]; then
    query='{"app:client_ver": {$in: ["1.51.0","1.50.2","1.49.3"]}, event:{$in: ["quest:end","quest:start","tutorial"]} }'

elif [ $evt = "iap" ]; then
    query='{ "event": "cashflow", "currency": "USD_", "type":"iap" } '
    fieldFile="bin/mongo/fieldFiles/multi.txt"

elif [ $evt = "diamonds" ]; then
    # db.metrics.find({
    #     event:'cashflow',
    #     currency: 'PAID',
    #     amount: {$lt: 0}
    # },
    # {
    # }
    # ).sort(
    # {ts:-1}
    # ).
    # limit(100)

    query='{ "event": "cashflow", "currency": "PAID", "amount": {"$lt": 0 } } '
    fieldFile="bin/mongo/fieldFiles/multi.txt"
    outfile="logs/mongodump/diamonds-use.csv"

# elif [ $evt == "attribs" ]; then
#     query='{source: { $ne: null }}'
#     collection="players"
#     fieldFile="bin/mongo/fieldFiles/users-min.txt"

else
    echo "cant find query $evt"
    exit 0
fi

echo query="$query"

# mongoexport

# mongodump --host ${host[0]} --db ${db} --username ${username} --password ${password} -o ${DIR} --query '{"app:client_ver":"1.51.0",event: "quest:end", "quest:won" :0}'
# '{"app:client_ver":"1.51.0",event: "quest:end", "quest:won" :0}'

# --csv

mongoexport --query "$query" \
--host ${host[0]} --db ${db} --username ${username} --password ${password} -o ${outfile} --csv \
--collection ${collection} \
--fieldFile $fieldFile



    # --query ${query} --collection ${collection}

# exit 0