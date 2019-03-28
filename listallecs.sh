# To use this tool you need to installed and configured AWS CLI!!!

if [ -z "$1" ];
then
  echo "No aws cli profile name provided. You can add the name after space: listallec2 profilename\n"
  ACC=${VARIABLE:-default}
else
  ACC=$1
fi
echo "Listing all ECS instances for: "$ACC" profile"

for region in `aws ec2 describe-regions --output text --profile $ACC | cut -f3`
do
    echo "List of ECS instances in region:'$region':"
    cluster=`aws ecs list-clusters --region $region --output text --profile $ACC | cut -d':' -f6 | cut -d"/" -f2 | tr "\n" " "`
    aws ecs describe-clusters --clusters $cluster --query "clusters[*].{status:status,ActiveServices:activeServicesCount,RunningTasks:runningTasksCount,ClusterName:clusterName}" --output=table --region $region --profile $ACC
done

