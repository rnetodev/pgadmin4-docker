# Settings

* Client mode (no login / password)
* Defaults to port 5050

# Usage

```

docker pull rnetonet/pgadmin4
docker run --detach --volume /opt/pgadmin:/pgadmin/ --network=host --restart=always --name pgadmin4 rnetonet/pgadmin4

```
