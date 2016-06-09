# AWS Opsworks Cookbook

## Build & Deploy

```sh
# create bucket to store cookbooks in
aws s3 mb s3://<bucketname>

# generate a custom cookbook and make your changes
chef generate cookbook php

# set git config settings
git config aws-opsworks.cookbook-bucket s3://<bucketname>/cookbooks/cookbooks.tar.gz
git config aws-opsworks.stack-name <stackname>

# berks install, upload and distribute cookbook changes
./upload
```
