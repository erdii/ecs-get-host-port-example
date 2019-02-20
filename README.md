# get ecs host port and port example

* edit `deploy.json` and fill in the correct values
* to build and push at the same time: `make`
* to build the container: `make build`
* to push the container: `make push`

### problem

when launching services in ecs and dynamic host ports (HostPort set to 0), ecs automatically chooses a hostport for you, but the container itself doesn't know anything about that port or even the host ip

### solution

* run script in entrypoint to gather the data
* fetch host ip from cloud-init service
* fetch port-forwardings from ecs agent
* export data as envvars
	* HOST_MACHINE_IP={<HostIp>}
	* PORT_{<InternalPort>}_{TCP,UDP}={<ExternalPort>}

### env example:

```
HOST_MACHINE_IP=10.16.162.77
PORT_3000_TCP=32802
```
