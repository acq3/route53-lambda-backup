#!/bin/bash


sudo apt-get update
sudo apt-get install aws


function installAWS {
    echo "Installing AWS CLI..."

    echo "Installing using apt"
    sudo apt-get -yqq update
    sudo apt-get -yqq install awscli

    /usr/bin/curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/tmp/awscli-bundle.zip"
    /usr/bin/unzip /tmp/awscli-bundle.zip -d /tmp
    /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
}


function setAWSCLI {
    AWS=$(find /usr/bin/ /usr/local/bin/ ~/ -name 'aws')
    if [ "$AWS" -z ]
    then
        echo "Please install the AWS CLI"
        exit 1
    elif [ $(echo "$AWS" | wc -l) -gt 1 ]
    then
        echo 'ok'
    else
        echo 'nok'
    fi
    while read line ; do echo $line ; done
}


function setAWSCLI {
    AWS=$(find /usr/bin/ /usr/local/bin/ ~/ -name 'aws')
    if [ "$AWS" -z ]
    then
        echo "Please install the AWS CLI"
        exit 1

    if [ $(echo "$AWS" | wc -l) -gt 1 ]
    then
        echo "Multiple AWS binaries found."
        echo "Using the highest version one."

    else
        echo 'nok'
    fi
    echo "$AWS" | while read awsbin
    do
        #ver=$("$awsbin" --version)
        $("$awsbin" --version)
    done
}


#AWS="/usr/local/bin/aws"
AWS=$(find /usr/bin/ /usr/local/bin/ -name 'aws')
AWS=$(find /usr/bin/ /usr/local/bin/ ~/ -name 'aws')


# Configure AWS CLI

if [ ! -f "~/.aws/credentials" ]
then
    echo "Configuring AWS CLI..."
    "$AWS" configure
fi


# Create S3 Bucket

echo "\nCreating S3 bucket...\n"

while true
do
    read -p "Bucket name: " bucket_name
    check_for_bucket=$("$AWS" s3api head-bucket --bucket "$bucket_name" 2>&1 > /dev/null)

    if echo $check_for_bucket | grep -q "404"
    then
        while true
        do
            read - "Bucket region: " bucket_region
            if [ "$bucket_region" = "us-east-1" ]
            then
                call_create_bucket=$("$AWS" s3api --acl private --bucket "$bucket_name" 2>&1 > /dev/null)
            else
                call_create_bucket=$("$AWS" s3api --acl private --bucket $bucket_name --create-bucket-configuration LocationConstraint="$bucket_region" 2>&1 > /dev/null)
            fi

            if echo "$call_create_bucket" | grep "IllegalLocationConstraintException"
            then
                echo "This is not a valid location. Please select another."
            else
                echo "Success! Bucket created."
                break
            fi
        done
        break
    elif [ "$check_for_bucket" = "" ]
    then
        echo "This bucket already exists and you own it."
        break
    else
        echo "This bucket already exists and you do not own it. Please select another"
    fi
done


# Create IAM role

# Create Lambda function

echo "$GH" | sed -n 's/\"tag_name\": \"\([vV0-9\.]*\)\",/\1/p'

echo "$GH" | sed -n 's/\([vV0-9\.]*\)/\1/p'

echo "$GH" | sed -n 's/"tag_name": "\([vV0-9\.]*\)",/\1/p'

latest_release_number=$(curl -s https://api.github.com/repos/jacobfgrant/route53-lambda-backup/releases/latest | sed -n 's/^.*"tag_name": "\([vV0-9.]\+\)",/\1/p')


wget 
https://github.com/jacobfgrant/route53-lambda-backup/releases/download/$latest_release_number/route53_lambda_backup.zip


sed -n 's/^.*"tag_name": "\([vV0-9.]\+\)",/\1/p')


wget "https://github.com/jacobfgrant/route53-lambda-backup/releases/download/$latest_release_number/route53_lambda_backup.zip" -qO /tmp/route53_lambda_backup.zip

"$AWS" lambda create-function --function-name "$lambda_function_name" --runtime python3.6
--role <value>
--handler lambda_handler
--timeout 10
--zip-file fileb://tmp/route53_lambda_backup.zip


lambda_function_name="TestFunc"

aws lambda create-function \
--region us-west-2 \
--function-name "$lambda_function_name" \
--zip-file fileb://tmp/route53_lambda_backup.zip \
--role role-arn \
--handler helloworld.handler \
--runtime nodejs6.10 \
--profile adminuser 



aws iam create-role --role-name new_test_role_backup --assume-role-policy-document file://tmp/TRTP.json

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:Get*",
                "route53:List*",
                "route53:TestDNSAnswer"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}


aws iam attach-role-policy --role-name new_test_role_backup --policy-arn file:///tmp/TRTP2.json

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1508744251000",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::bucket_name arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "Stmt1508744392000",
            "Effect": "Allow",
            "Action": [
                "route53:GetHostedZone",
                "route53:GetHostedZoneCount",
                "route53:ListHostedZones",
                "route53:ListHostedZonesByName",
                "route53:ListResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::*"
            ]
        }
    ]
}



{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {"Service": "lambda.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }
}