# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallelb profilename\n"
  ACC = ${VARIABLE:-default}
else
  ACC = $1
fi
echo "Listing all ELBs for: "$ACC" profile\n"

for region in `aws ec2 describe-regions --output text | cut -f3`
do
    echo "\nList of ELBs in region:'$region':"
    aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].{Name:LoadBalancerName,Exposure:Scheme,DNS:DNSName}" --output=table --region $region --profile $ACC
    aws elbv2 describe-load-balancers --query "LoadBalancers[*].{Name:LoadBalancerName,Exposure:Scheme,Type:Type,DNS:DNSName}" --output=table --region $region --profile $ACC

done
