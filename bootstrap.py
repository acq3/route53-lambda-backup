#!/usr/bin/env python

import os
import boto3
from botocore.exceptions import ClientError


# Create client objects

s3 = boto3.client('s3', region_name='us-east-1')
aws_lambda = boto3.client('lambda')


# Functions

def create_s3_bucket(bucket_name, bucket_region='us-east-1'):
    """Create an Amazon S3 bucket."""
    try:
        response = s3.head_bucket(Bucket=bucket_name)
        return response
    except ClientError as e:
        if(e.response['Error']['Code'] != '404'):
            print(e)
            return None
    # creating bucket in us-east-1 (N. Virginia) requires
    # no CreateBucketConfiguration parameter be passed
    if(bucket_region == 'us-east-1'):
        response = s3.create_bucket(
            ACL='private',
            Bucket=bucket_name
        )
    else:
        response = s3.create_bucket(
            ACL='private',
            Bucket=bucket_name,
            CreateBucketConfiguration={
                'LocationConstraint': bucket_region
            }
        )
    return response


def create_lambda_function(bucket_name, bucket_region):
    return


def main ():
    while True:
        bucket_name = raw_input("\nPlease enter the name you would like to use for the AWS S3 bucket:\n")
        if True:
            print "/nSuccess/n"
            break
        else:
            continue

    while True:
        bucket_region = raw_input("\nPlease enter the name you would like to use for the AWS S3 bucket:\n")
        if True:
            print "/nSuccess/n"
            break
        else:
            continue


    create_s3_bucket(bucket_name, bucket_region)
    create_lambda_function(bucket_name, bucket_region)


if __name__ == "__main__":
    main()



try:
    s3.meta.client.head_bucket(Bucket=bucket.name)
except ClientError:
    # The bucket does not exist or you have no access.


s3.create_bucket(Bucket='my-bucket-name')