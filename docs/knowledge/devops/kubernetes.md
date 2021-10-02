# Kubernetes

## Connect to claster
Для работы с k8s понадобиться `kuberctl`

Создаем наш кластер на нашем облаке и скачиваем **kubeconfig**, он понадобиться нам для подключения к нашему кластеру.

Теперь можем проверить наши ноды:
```bash
kubectl --kubeconfig=claster-kubeconfig.yaml get nodes
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
kubectl cluster-info 	# view the claster details
kubectl get nodes 		# view the nodes in the claster
```
