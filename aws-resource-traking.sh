# Version : v1
# if u are new, search aws cli commands in google to find the commands.
# this script will report the aws resource usage 
###########################

set -x

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users


# list s3 buckets
echo "print list of s3 buckets"
aws s3 ls > ResourceTracker

# list ec2 instance
echo "print list of ec2 status"
aws ec2 describe-instance | jq '.Reservations[].Instance[].InstanceId ' > ResourceTracker

# list lambda
echo "print list of lambda functions" 
aws lambda list-functions > ResourceTracker

# list iam users
echo "print list of IAM users"
aws iam list-users > ResourceTracker
