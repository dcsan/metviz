set -x
INFILE=$1
OUTFILE=${INFILE//.js/.coffee}

echo "converting to $OUTFILE"

js2coffee $INFILE > $OUTFILE


JUNKDIR="~/junk/$(dirname ${INFILE})"
JUNKFILE=$(basename ${INFILE})
JUNKPATH="$JUNKDIR/$JUNKFILE"

mkdir -p $JUNKDIR
echo "moving to $JUNKFILE"
mv $INFILE $JUNKPATH

# echo $INFILE $JUNKPATH

echo "done"
