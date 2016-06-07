# AWS Opsworks Cookbook

## Build & Deploy

```sh
# generate a custom cookbook
chef generate cookbook php

# create archive of cookbooks
berks package cookbooks.tar.gz

# upload to S3
aws s3 cp cookbooks.tar.gz s3://testapp.storage/cookbooks/cookbooks.tar.gz
```
