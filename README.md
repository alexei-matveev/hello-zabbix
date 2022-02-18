#### Experiments with Zabbix in k3s

Assuming you already installed the Token in your local config:

    $ export KUBECONFIG=~/.kube/config
    $ kubectl get nodes
    $ source <(kubectl completion bash)

Install Zabbix in Kubernetes, without `--dry-run`:

    $ kubectl create namespace hello-zabbix
    $ kubectl config set-context --current --namespace=hello-zabbix
    $ kubectl apply -k k3s/ --dry-run=server

Then  visit the  [URL](https://zabbix.localhost).   The default  Admin
password is "zabbix".
