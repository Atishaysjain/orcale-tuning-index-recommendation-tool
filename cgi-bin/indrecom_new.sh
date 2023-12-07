export ORACLE_HOME=/home/oracle/Downloads
export ORACLE_SID=orcl
export PATH=$ORACLE_HOME/bin:$PATH
export TNS_ADMIN=$ORACLE_HOME/network/admin
 
TN=$1
SQID=$2
cat /dev/null > indrecom.txt
cat /dev/null > indrecom_new.txt
>indrecom.txt
>p.txt
sqlplus -s dbsnmp/oracle123@$TN @indrecom.sql $SQID > testrecom.txt
sqlplus -s dbsnmp/oracle123@$TN @indrecom.sql $SQID
sed -n '/TABLE ACCESS FULL/,$p' testrecom.txt | grep "TABLE ACCESS FULL" | grep \* | awk -F"|" '{print $2,$4}' | tr -d '*' > nu_tab.txt
while read -r line
do
l=`echo $line | awk '{print $1}'`
tabn=`echo $line | awk '{print $2}'`
cat testrecom.txt |awk '/[0-9] -/ {if (x)print x;x="";}{x=(!x)?$0:x" "$0;}END{print x;}'| grep -v "TABLE ACCESS FULL" | grep -w "$l" | grep -oP '".*?"' | tr -d '"' |sort -u > col_{$tabn}_{$l}.txt
while read -r line
do
sqlplus -s dbsnmp/oracle123@$TN @numcoldist.sql $tabn $line  >coldist_${tabn}_${line}.txt
sqlplus -s dbsnmp/oracle123@$TN @numcoldist_bitmap.sql $tabn $line  >coldistbitmap_${tabn}_${line}.txt
done < col_{$tabn}_{$l}.txt
colvar=`ls -ltr coldist_${tabn}*.txt | awk '{ if ($5 > 0) {print $9} else if ($5=0) {null}}' | sort -nr |sed 's/....$//' | sed "s/coldist_${tabn}_//" | sed 's/$/,/' | xargs| uniq `
sort -nr coldist_${tabn}*.txt > p.txt
sed -i '/^$/d' p.txt
l=`cat p.txt |awk 'NR==1{print $1}'`

sort -nr coldistbitmap_${tabn}*.txt > r.txt
sed -i '/^$/d' r.txt
m=`cat r.txt |awk 'NR==1{print $1}'`
n=`cat r.txt |awk 'NR==1{print $2}'`

if [[ $l -gt 10 ]] ; then
echo  "create index on ${tabn} on columns ($colvar)" >> indrecom.txt
elif [[ $m -lt 10  && $n -lt 1000 ]] ; then
echo  "create bitmap index on ${tabn} on columns ($colvar)" >> indrecom.txt
fi

done < nu_tab.txt
cat indrecom.txt | sed 's/,)/)/' | sort -u > indrecom_new.txt
awk 'BEGIN{print "<table>"} {print "<tr>";for(i=1;i<=NF;i++)print "<td>" $i"</td>";print "</tr>"} END{print "</table>"}' indrecom_new.txt
rm coldist_${tabn}*.txt
rm coldistbitmap_${tabn}*.txt
