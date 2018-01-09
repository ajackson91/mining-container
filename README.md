## Manual Build (Optional)

Clone Git repo then from within the code repo directory

```
docker build -t ajackson/mining-container:latest .
```

## Starting Container

```
run --name <container name> -e POOL='<pool details>' -e ACCOUNT='<account details>' -e AESNI=[enabled|disabled] -v <local log directory>:/opt/mining-container/logs -d -it ajackson/mining-container:latest
```

Note: If you don't specify all environment variables it will default to my personal account.

## Running Container

```
docker start <container name>
docker stop <container name>
docker attach <container name>
```

Exit attached container with CTRL + P then CTRL + Q

## Remove Container

```
docker stop <container name>
docker rm <container name>
```
