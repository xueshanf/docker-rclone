
[Rclone](https://rclone.org) is a command line program to sync files and directories to and from various cloud storage vendors.
This repository uses a multi-stage Dockerfile to build the rclone container image. 

## To build rclone docker imag:

```
docker build -t rclone .
```

## To use the image

* Help
```
docker run --rm -it rclone help
``` 

* Copy files to AWS bucket

You need to create rclone.conf first. See [rclone config](https://rclone.org/docs/) for details.

Here is an example of rclone.conf that will use AWS IAM role:
```console
$ cat /etc/rclone.conf
[etcd2-backup]
type = s3
env_auth = true
access_key_id =
secret_access_key =
region = us-east-1
endpoint =
acl = private
server_side_encryption =
storage_class = STANDARD
```

```console
$ RCLONE_ENDPOINT=etcd2-backup
$ RCLONE_CHECKSUM=true
$ BACKUP_DIR=/data
$ RCLONE_CONFIG_PATH}:/etc/rclone.conf \
$ /usr/bin/docker run --rm \
	-v ${BACKUP_DIR}:/data \
        -v ${RCLONE_CONFIG_PATH}:/etc/rclone.conf \
	rclone:latest --config /etc/rclone.conf --checksum=${RCLONE_CHECKSUM} \
	copy /data/ ${RCLONE_ENDPOINT}/data
```
