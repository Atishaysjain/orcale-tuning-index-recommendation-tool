echo "Content-type: text/html"
echo ""
k=$(cat)
USERNAME=`echo "$k" | sed -n 's/^.*username=\([^&]*\).*$/\1/p' | sed "s/+/ /g"`
OPERT=`echo "$k" | sed -n 's/^.*operationType=\([^&]*\).*$/\1/p' | sed "s/+/ /g"`
SQ=`echo "$k" | sed -n 's/^.*sqlid=\([^&]*\).*$/\1/p' | sed "s/+/ /g"`
HRN=`echo "$k" | sed -n 's/^.*hrn=\([^&]*\).*$/\1/p' | sed "s/+/ /g"`

echo "<html><head><title>Demo</title></head><body>"
if [[ "$OPERT" == "FTSIND" ]] ; then
sh indrecom_new.sh  $USERNAME $SQ
fi
if [[ "$OPERT" == "FTS" ]] ; then
sh fts.sh  $USERNAME $HRN
fi
if [[ "$OPERT" == "GETS" ]] ; then
sh gets.sh  $USERNAME $SQ
fi
