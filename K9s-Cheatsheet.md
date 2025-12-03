# Cheatsheet - k9s

## PreFlight Checks

* K9s uses 256 colors terminal mode. On `Nix system make sure TERM is set accordingly.

    ```shell
    export TERM=xterm-256color
    ```

* In order to issue resource edit commands make sure your EDITOR and KUBE_EDITOR env vars are set.

    ```shell
    # Kubectl edit command will use this env var.
    export KUBE_EDITOR=my_fav_editor
    ```

* K9s prefers recent kubernetes versions ie 1.28+

---

## K8S Compatibility Matrix

|         k9s        | k8s client |
| ------------------ | ---------- |
|     >= v0.27.0     |   1.26.1   |
| v0.26.7 - v0.26.6  |   1.25.3   |
| v0.26.5 - v0.26.4  |   1.25.1   |
| v0.26.3 - v0.26.1  |   1.24.3   |
| v0.26.0 - v0.25.19 |   1.24.2   |
| v0.25.18 - v0.25.3 |   1.22.3   |
| v0.25.2 - v0.25.0  |   1.22.0   |
|      <= v0.24      |   1.21.3   |

---

## Start k9s

```bash
# Use default kubeconfig
$ k9s

# Use non-default kubeconfig
$ k9s --kubeconfig /path/to/kubeconfig

# Use non-default context
$ k9s --context fooctx

# Readonly
$ k9s --readonly

## Check info (locations for configuration, logs, screen dumps)
$ k9s info
```

## Using k9s
### List Resources
List a specific resource:

`:<resource>`: list Resources, e.g. :pod to list all pods.
`:<resource> <namespace>`: list Resources in a given namespace.
List all available resources / apis:

`:aliases` or Ctrl-a: list all available aliases and resources.
`:crd`: list all CRDs.
`:apiservices`: list all API Serv

### Filter

* `/<filter>`: regex filter.
* `/!<filter>`: inverse regex filter.
* `/-l <label>`: filter by labels.
* `/-f <filter>`: fuzzy match.

### Choose namespace

Type `:namespace`, select the desired namespace by up or down key, press `Enter` to select.

### Choose context

* `:ctx`: list ctx, then select from the list.
* `:ctx <context>`: switch to the specified context.

### Show Decrypted Secrets
Type `:secrets` to list the secrets, then

* `x` to decrypt the secret.
* `Esc` to leave the decrypted display.

### Key mapping

* move up and down without moving your right hand:
 * `j`: down.
 * `k`: up.
 * `h`: left
 * `l`: right
* `SPACE`: select multiple lines (e.g. then Ctrl-d to delete)
* `y`: yaml.
* `d`: describe.
* `v`: view.
* `e`: edit.
* `l`: logs.
* `w`: wrap.
* `r`: auto-refresh.
* `s`:
 * `Deployment` screen: scale the number of replicas.
 * `Pod` or Containers screen: shell
* `x`: decode a Secret.
* `f`: fullscreen. Tip: enter fullscreen mode before copying, to avoid | in copied text.
cCtrl-d`: delete.
* `Ctrl-k`: kill (no confirmation).
* `Ctrl-w`: toggle wide columns. (Equivalent to kubectl ... -o wide)
* `Ctrl-z`: toggle error state
* `Ctrl-e`: hide header.
* `Ctrl-s`: save output (e.g. the YAML) to disk.
* `Ctrl-l`: rollback.

### Sort by Column
* `Shift-c`: sorts by CPU.
* `Shift-m`: sorts by MEMORY.
* `Shift-s`: sorts by STATUS.
* `Shift-p`: sorts by namespace.
* `Shift-n`: sorts by name.
* `Shift-o`: sorts by node.
* `Shift-i`: sorts by IP address.
* `Shift-a`: sorts by container age.
* `Shift-t`: sorts by number of restarts.
* `Shift-r`: sorts by pod readiness.

### Helm
* `:helm`: show helm releases.
* `:helm NAMESPACE`: show releases in a specific namespace.

### User
There's no "user" object but in k9s you can see all the users by `:users`. Press `Enter` to see a list of Policies.

### XRay View
* `:xray RESOURCE`, e.g. :xray deploy.

### Pulse View
* `:pulse:` displays general information about the Kubernetes cluster.

### Popeye View
* `:popeye` or `pop`: checks all resources for conformity with the correctness criteria and displays the resulting "rating" with explanations. https://popeyecli.io

### Show Disk Files
* `:dir /path`
E.g. `:dir /tmp` will show your `/tmp` folder on local disk.
One common use case: `Ctrl-s` to save a yaml, then find it in `:dir /tmp/k9s-screens-root`,
find the file, press `e` to edit and `a` to apply.

### Quit
* `Esc`: Bails out of view/command/filter mode.
c:q` or `Ctrl-c`: quit k9s.

## Meaning of the Headers
Most of the headers are easy to understand; some of the special ones:

* `%CPU/R`: Percentage of requested CPU
* `%CPU/L`: Percentage of limited CPU
* `%MEM/R`: Percentage of requested memory
* `%MEM/L`: Percentage of limited memory
* `CPU/A`: allocatable CPU

Pods:

* `pf`: PortForward

Containers:

* `PROBES(L:R)`: Liveness and Readiness probes


## FAQ
### How to change among clusters?
Add all `kubeconfig` paths to `$KUBECONFIG`, then start k9s:

```bash
$ export KUBECONFIG=/path/to/kubeconfig1:/path/to/kubeconfig2:~/.kube/config:$KUBECONFIG

$ k9s
```

Inside k9s, type `:ctx`, then select the context to change to a different cluster.

### How to scale up or scale down a deployment?
Go to the `Deployments` page, and press `s`, then enter a number for the desired num of `ReplicaSet`.

### How to force delete a pod?
`Ctrl-d`, move cursor to `Force`, press `space` to select, click `OK`.

### What is the plus (+) next to the namespace?
In k9s, some namespace `foo` may appear as `foo+`, the `+` denotes a favorite namespace,
 i.e. it will appear on the header with a number to quickly select the namespace,
 e.g. `0` to select all namespaces.

To add `+` to the namespace: select namespace in the list, press `u` (for "Use").

The `*` indicate the default namespace.

### How to monitor resource usage?
Check `CPU` and `MEM` usage on the top left corner of the screen;

Check usage in `Node` and `Pod` page;

This is equivalent to:

```bash
$ kubectl top nodes
$ kubectl top pods

$ kubectl top node <node_name>
```

### Where are the k9s config files?
Note that all YAML files in the `.k9s` directory must have the `.yml` extension
(`.yaml` doesn’t work).

* `$HOME/.k9s/views.yml`: customize the column view for resource lists.
* `$HOME/.k9s/plugin.yml`: manage plugins.
* `$XDG_CONFIG_HOME/k9s/config.yml`: k9s config.
* `$XDG_CONFIG_HOME/k9s/alias.yml`: define your own alias.
* `$XDG_CONFIG_HOME/k9s/hotkey.yml`: define your own hotkeys.
* `$XDG_CONFIG_HOME/k9s/plugin.yml`: manage plugins.

### How to Check Objects with the Same Name in Different API Groups

e.g. `Cluster` may be found in different api groups, like `cluster.x-k8s.io` or 
`clusterregistry.k8s.io` or `baremetal.cluster.gke.io`.

```yaml
apiVersion: cluster.x-k8s.io/v1alpha3
kind: Cluster

apiVersion: clusterregistry.k8s.io/v1alpha1
kind: Cluster

apiVersion: baremetal.cluster.gke.io/v1
kind: Cluster
```

Use `apiVersion`/`kind` (i.e. `Group`/`Version`/`kind`) instead of just `kind`
to check the API of a specific group.

* `:cluster.x-k8s.io/v1alpha3/clusters`
* `:clusterregistry.k8s.io/v1alpha1/clusters`
* `:baremetal.cluster.gke.io/v1/clusters`
Or go to the CRDs page (`:crd`), move to the correct row, press enter.

### How to change log setting

Change `~/.config/k9s/config.yml`:

```yaml
logger:
  tail: 500
  buffer: 5000
  sinceSeconds: -1
```

### How to monitor what's going on:
* `:event` (or `:ev`): see the stream of events.
* `:pod`: see the list of pods Shift-a to sort by age.
* `:job`: see the list of jobs, ordered by time by default.

### What if editing a yaml in k9s is reverted back?

Find the controller that manages the CR, scale it down for deletion.

```yaml
# Scale down the controllers:
$ kubectl scale --replicas=0 deployment/CONTROLLER_MANAGER_NAME -n NAMESPACE

# Edit the manifest, e.g. changing a field `foo` to true
$ kubectl patch KIND NAME -n NAMESPACE --type=json -p="[{'op': 'replace', 'path': '/spec/foo', 'value': true}]"

# Scale up the controllers:
$ kubectl scale --replicas=1 deployment/CONTROLLER_MANAGER_NAME -n NAMESPACE
```

### Where to find k9s logs?

```bash
$ k9s info | grep Logs
Logs:              /root/.local/state/k9s/k9s.log
```

## Benchmark
k9s includes a basic HTTP load generator.

To enable it, you have to configure port forwarding in the pod.
Select the pod and press `SHIFT + f`, go to the port-forward menu (using the `pf` alias).

After selecting the port and hitting `CTRL + b`, the benchmark would start.
Its results are saved in `/tmp` for subsequent analysis.

To change the configuration of the benchmark, create the
`$HOME/.k9s/bench-<my_context>.yml` file (unique for each cluster).

## Plugins
https://github.com/derailed/k9s/tree/master/plugins

## Install

```bash
# Go
$ go install github.com/derailed/k9s@latest

# Homebrew / LinuxBrew
$ brew install derailed/k9s/k9s

# MacPort
sudo port install k9s

# Snap
sudo snap install k9s

# PacMan
pacman -S k9s

# Windows: scoop
scoop install k9s

# Windows: chocolatey
choco install k9s
```

## Official Website
https://k9scli.io/