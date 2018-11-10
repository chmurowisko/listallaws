# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallec2 profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all ec2 instances for: "$ACC" profile\n"

for region in `aws ec2 describe-regions --output text | cut -f3`
do
    echo "\nList of EC2 instances in region:'$region':"
    aws ec2 describe-instances --query "Reservations[*].Instances[*].{IP:PublicIpAddress,ID:InstanceId,Type:InstanceType,State:State.Name,Name:Tags[0].Value}" --output=table --region $region --profile $ACC
done
