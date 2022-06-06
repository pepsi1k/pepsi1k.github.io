# Kubernetes

## Connect to cluster
Для работы с k8s понадобиться `kuberctl`

Создаем наш кластер на нашем облаке и скачиваем **kubeconfig**, он понадобиться нам для подключения к нашему кластеру.

Теперь можем проверить наши ноды:
```bash
kubectl --kubeconfig=cluster-kubeconfig.yaml get nodes
```

Для того, чтобы постоянно не писать `--kubeconfig`, создадим enironment veriable **KUBECONFIG**:
```bash
export KUBECONFIG="PATH_TO_KUBECONFIG"
```
Чтобы взаимодействовать с api kubernetes, нужно создать прокси:
```bash
kubectl proxy --port=8080
```

Теперь мы можем взаимодействовать с нашим кластером:
```bash
kubectl cluster-info 	# view the cluster details
kubectl get nodes 		# view the nodes in the cluster
```

## Copy file from pod to local host
```bash
kubectl cp <some-namespace>/<some-pod>:/tmp/foo /tmp/bar -c <container-name>
```

## Get all pod logs in current namespace

```bash
for i in $(kubectl get pods -o json | jq -r '.items[].metadata.name'); do kubectl logs $i > $i; done
```

## Get all pods by specific node
```bash
kubectl get pod -A --field-selector spec.nodeName=$node
```

## Manually run job from cronjobs
```bash
kubectl create job --from=cronjob/mysql-backups mysql-backup-manual-00
```

## Remove all evicted pods
```bash
kubectl get pods -A | grep Evicted | awk '{print $1,$2,$4}' | xargs kubectl delete pod $2 -n $1
```

## While true
```yaml
# Pod
spec:
  containers:
    - command: ['/bin/bash', '-c', '--']
      args:
        - |
          while true; do
            echo sleep;
            sleep 3s;
          done;
```

## Mount empty directory to two containers
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox-modsec
  namespace: ingress
  labels:
    app: busybox-modsec
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox-modsec
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: busybox-modsec
      annotations:
        linkerd.io/inject: disabled
    spec:
      initContainers:
        - name: touch-log-files
          image: busybox:stable
          command:
            - '/bin/sh'
            - '-c'
            - |
              touch /var/log/modsec/audig.log;
              touch /var/log/modsec/debug.log
          volumeMounts:
            - mountPath: /var/log/modsec
              name: modsec
      containers:
        - name: busybox-write
          image: busybox:stable
          command:
            - '/bin/sh'
            - '-c'
            - |
              while true; do 
                echo "write: warn";
                echo "warn" >> /var/log/modsec/audig.log;
                sleep 4s
              done
          volumeMounts:
            - mountPath: /var/log/modsec
              name: modsec
          resources:
            requests:
              cpu: 20m
              memory: 30Mi
            limits:
              cpu: 30m
              memory: 40Mi
        - name: busybox-read
          image: busybox:stable
          command:
            - '/bin/sh'
            - '-c'
            - |
              tail -f /var/log/modsec/audig.log;
          volumeMounts:
            - mountPath: /var/log/modsec
              name: modsec
              readOnly: true
          resources:
            requests:
              cpu: 20m
              memory: 30Mi
            limits:
              cpu: 30m
              memory: 40Mi
      volumes:
        - name: modsec
          emptyDir: {}
```
