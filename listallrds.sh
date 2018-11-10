# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1"];
then
  echo "No aws cli profile name provided. You can add the name after space: listallrds profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all RDS instances for: "$ACC" profile\n"

for region in `aws ec2 describe-regions --output text | cut -f3`
do
    echo "\nList of RDS instances in region:'$region':"
    aws rds describe-db-instances --query "DBInstances[*].{NAME:DBInstanceIdentifier,SIZE:DBInstanceClass,Type:Engine,PUBLIC:PubliclyAccessible}" --output=table --region $region --profile $ACC
done
