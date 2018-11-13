# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallec2 profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all EBS for: "$ACC" profile\n"

for region in `aws ec2 describe-regions --output text --profile $ACC | cut -f3`
do
    echo "\nList of EBS disks in region:'$region':"
    aws ec2 describe-volumes --query "Volumes[*].{AZ:AvailabilityZone,ID:VolumeId,Type:VolumeType,State:State,Name:Tags[0].Value}" --output=table --region $region --profile $ACC
done
