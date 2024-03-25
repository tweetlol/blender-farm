# blender-farm

## rendering client setup

use [GUI](https://github.com/LogicReinc/LogicReinc.BlendFarm/releases) for render access

- download and run the [binary app](https://github.com/LogicReinc/LogicReinc.BlendFarm/releases) (for your version of OS)

add required render nodes under `New Node`:


## render cluster node setup

### machine setup

- install fresh ubuntu 22.04.3 server
- `sudo apt update`
- `sudo apt upgrade`
- configure `/etc/netplan/*` for networking (don't forget to `sudo netplan apply`)
- setup [node_exporter](https://github.com/NCPlyn/grafana_prometheus_node-exporter/tree/main) for prometheus
- add IP (static) to prometheus.yaml
- setup [ldap](https://github.com/tweetlol/ubuntu-su-clone) and [NAS](https://github.com/tweetlol/ubuntu-su-clone)

### rendering setup

- setup [server](https://github.com/LogicReinc/LogicReinc.BlendFarm/releases) from [LogicReinc's BlendFarm](https://github.com/LogicReinc/LogicReinc.BlendFarm/tree/main)
- make sure `libgdiplus` and `libc6-dev` are installed (`sudo apt install`)
- setup launch on startup:
  - copy the server binary to `/usr/local/bin/`
  - `crontab -e`, add the following:

```crontab
@reboot /usr/local/bin/renderfarm
```

- make sure to replace `renderfarm` with the actual name of server's binary
