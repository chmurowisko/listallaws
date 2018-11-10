# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallsnap profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all EBS snapshots for: "$ACC" profile\n"

#Get the AWS account id
ACCID=`aws sts get-caller-identity --output text --query 'Account' --profile $ACC`

for region in `aws ec2 describe-regions --output text | cut -f3`
do
    echo "\nList of EBS snapshots in region:'$region':"
    aws ec2 describe-snapshots --owner-ids $ACCID --query "Snapshots[*].{SnapID:SnapshotId,VolID:VolumeId,VolSize:VolumeSize,State:State,Name:Tags[0].Value}" --output=table --region $region --profile $ACC
done
