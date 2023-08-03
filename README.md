
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Anomalous number of frontend 4xx HTTP responses for host
---

This incident type involves an anomalous number of frontend 4xx HTTP responses for a particular host. This may indicate a problem with the HAProxy, which is a load balancer often used in web architectures. It can result in service disruptions and should be investigated promptly.

### Parameters
```shell
# Environment Variables

export HAPROXY_CFG="PLACEHOLDER"

export HOST="PLACEHOLDER"

export LIST_OF_BACKEND_SERVERS="PLACEHOLDER"

export BACKEND_SERVER="PLACEHOLDER"

export DESIRED_TIMEOUT_VALUE="PLACEHOLDER"

export DESIRED_BUFFER_SIZE="PLACEHOLDER"

export HAPROXY_FRONTEND_IP="PLACEHOLDER"

export BACKEND_IP="PLACEHOLDER"
```

## Debug

### Check the HAProxy configuration file for any errors or typos
```shell
sudo haproxy -c -f ${HAPROXY_CFG}
```

### Check the log files for any errors or issues
```shell
sudo tail -f /var/log/haproxy.log
```

### Check the status of the HAProxy service
```shell
sudo systemctl status haproxy
```

### Check the network connectivity for the affected host
```shell
ping ${HOST}
```

### Check the HTTP response code for the affected host
```shell
curl -I ${HOST}
```

### Network or connectivity issues between the HAProxy and backend servers
```shell

   for ${BACKEND_SERVER} in ${LIST_OF_BACKEND_SERVERS}; do

       nc -zv ${BACKEND_SERVER} ${BACKEND_SERVER_PORT}

   done

   traceroute ${BACKEND_SERVER}

   
```

## Repair

### Restart the HAProxy service.
```shell

# Restart the HAProxy service to apply the changes

systemctl restart haproxy.service

```