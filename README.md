# get ecs host ip and external port example

### problem

when launching services in ecs and dynamic host ports (HostPort set to 0), ecs automatically chooses a hostport for you, but the container itself doesn't know anything about that port or even the host ip


### requirements:
* jq and curl installed
	* ubuntu/debian based images: ` RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq curl jq`
	* alpine based images: `RUN apk add --no-cache curl jq`

### solution

run [drop-in-script](./files/entrypoint.sh) in entrypoint to gather the data:
* fetch host ip from cloud-init service
* fetch docker container id from /proc
* sleep 2 seconds because the ecs agent needs some time to export the hostport bindings
* fetch port-forwardings from ecs agent
* export data as envvars
	* HOST_MACHINE_IP={<HostIp>}
	* PORT_{&lt;InternalPort&gt;}_{TCP,UDP}={&lt;ExternalPort&gt;}
* start "real entrypoint which is given to **entrypoint.sh** as args

### env example:

```
HOST_MACHINE_IP=10.16.162.77
PORT_3000_TCP=32802
PORT_8080_TCP=35022
PORT_9000_UDP=34567
```


### TL;DR

* install jq and curl
* drop in [the script](./files/entrypoint.sh)
* set ENTRYPOINT to **/entrypoint.sh**
* set CMD to **"/your/service/binary" "--some" "--args"**
* see how it is done in [the dockerfile](./Dockerfile)
