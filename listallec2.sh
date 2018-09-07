# You need to have installed and configured AWS CLI!!!

if [ -z "$1"];
then
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all ec2 instances for: "$ACC" profile"

for region in `aws ec2 describe-regions --output text | cut -f3`
do
    echo -e "\nList of EC2 instances in region:'$region':"
    aws ec2 describe-instances --query "Reservations[*].Instances[*].{IP:PublicIpAddress,ID:InstanceId,Type:InstanceType,State:State.Name,Name:Tags[0].Value}" --output=table --region $region --profile $ACC
done
