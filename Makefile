

setup:
		kubectl apply -f conf.d/websrv/web-deployment.yaml -f conf.d/websrv/web-service.yaml -f conf.d/monitor/monitor-deployment.yaml -f conf.d/meta/app-storage-class.yaml -f conf.d/meta/www-storage-claim.yaml -f conf.d/meta/www-storage.yaml -f conf.d/meta/app-role.yaml -f conf.d/meta/app-role-bind.yaml

destroy:
		kubectl delete deployment/monitor deployment/nginx service/nginx storageClass/app persistentVolumeClaim/nginx persistentVolume/nginx role/root roleBinding/rootbind
