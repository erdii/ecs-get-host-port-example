#!/bin/sh
set -e

# export external host ip as envvar
export HOST_MACHINE_IP=$(curl --max-time 2 http://169.254.169.254/latest/meta-data/local-ipv4 2>/dev/null)

# fetch task metadata from local ecs agent (we need to sleep a bit before the HostPort property is visible)
DOCKER_ID=$(basename $(cat /proc/1/cpuset))
sleep 2;
ECS_TASK_METADATA=$(curl --max-time 2 "http://172.17.0.1:51678/v1/tasks?dockerid=$DOCKER_ID" 2>/dev/null)

# export port forwarings as envvar in format: PORT_{<InternalPort>}_{TCP,UDP}={<ExternalPort>}
eval $(echo "$ECS_TASK_METADATA" | jq -r '.Containers[0].Ports[] | "export PORT_\(.ContainerPort)_\(.Protocol | ascii_upcase)=\(.HostPort)"')

# start your node script here
