# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallrds profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all Elastic IPs for: "$ACC" profile\n"

for region in `aws ec2 describe-regions --output text --profile $ACC | cut -f3`
do
    echo "\nList of all Elastic IPs in region:'$region':"
    aws ec2 describe-addresses --query "Addresses[].{Allocation_ID:AllocationId,IP:PublicIp,EC2_ID:InstanceId}" --output=table --region $region --profile $ACC
done

echo "\nREMEMBER!!!\nIf EC2_ID is none it means that IP is disassociated.\nFor EIPs that are disassociated or associated with the stopped machines, an additional charge will incur.\n"
