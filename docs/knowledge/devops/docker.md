## Docker 

[Beginer guid](https://docker-curriculum.com/)

```bash
docker image        # list images
docker ps           # list containers
docker ps -a        # list all containers

docker rm CONTAINER_ID 	# remove container
docker rmi IMAGE_ID 	# remove image

docker run image_name               # run image
docker run --name mysql user/mysql   # specific name for container
docker run -p 80:80 image_name      # run on specific port 
docker run -d image_name            # run like daemon

docker rmi $(docker images -a -q) # remove all images
docker container prune 	# delete all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker build -t IMAGE_NAME PATH_TO_DOCKERFILE 	# build image
```


## Run interactive mod on stoped container
```bash
docker commit $cointainer_id debug/some
docker run -it degub/some /bin/bash
```


## journald logging driver

```yaml
# docker-compose.yml
services:
  hello-log:
    container_name: hello-log
    image: ubuntu
    logging:
        driver: journald
        options:
            tag: hello-log

```

Then access logs using journalctl command + filter rules: 

```bash
journalctl -u docker CONTAINER_TAG=hello-log
```

## CloudWatch logging driver
https://docs.docker.com/config/containers/logging/awslogs/

https://wdullaer.com/blog/2016/02/28/pass-credentials-to-the-awslogs-docker-logging-driver-on-ubuntu/

```yaml
services:
  hello-log:
    container_name: hello-log
    image: ubuntu
    command: |
      /bin/bash -c "
      while true; do
        echo "hello"
        sleep 3s
      done
      "
    logging:
      driver: awslogs
      options:
        awslogs-region: eu-central-1
        awslogs-group: hello-log
        awslogs-create-group: 'true'
```
