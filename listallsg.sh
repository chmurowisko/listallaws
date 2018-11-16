# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallsg profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi

now=`date +"%Y-%m-%d_%H:%M"`
filename=${ACC}_${now}

echo "Listing all Security Groups for: "$ACC" profile\n"

echo "List of all Security Groups for: "$ACC" profile\n" > $filename.csv

for region in `aws ec2 describe-regions --output text --profile $ACC | cut -f3`
    do
        echo "\nList of all Security Groups for: $region" >> $filename.csv
        LISTSG="/tmp/listsg"
        aws ec2 describe-security-groups --region $region --output text --profile $ACC > $LISTSG

        echo "Name;ID;PORT;SOURCE" >> $filename.csv

        old_IFS=$IFS; IFS=$'\n'
        cat $LISTSG | while read line

        do
            case $line in
            SECURITYGROUPS*)
                PORT_HAS_GLOBAL_RULE=0
                SID=(`echo $line | awk -F\t '{print $3}'`)
                GNAME=(`echo $line | awk -F\t '{print $4}'`)

                echo "$GNAME;$SID" >> $filename.csv
                ;;

            IPPERMISSIONS*)
                INPORT=(`echo $line | awk -F\t '{print $2}'`)
                OUTPORT=(`echo $line | awk -F\t '{print $4}'`)
                PROTO=(`echo $line | awk -F\t '{print $3}'`)
                ;;

            IPRANGES*)
                EXTRA=""
                CIDR=(`echo $line | awk -F\t '{print $2}'`)    

                echo ";;$INPORT;$CIDR" >> $filename.csv
                ;;   

            esac   

        done
    IFS=$old_IFS
    rm $LISTSG 

    done

