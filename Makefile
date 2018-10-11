all: local.build

local.deploy:
	kubectl apply -f namespace.yaml
	kustomize build postgres | kubectl apply --namespace=kong -f -
	kustomize build kong/overlays/local | kubectl apply --namespace=kong -f -
	kustomize build konga/overlays/local | kubectl apply --namespace=kong -f -
	kustomize build ingress-controller | kubectl apply --namespace=kong -f -
	kustomize build kong-config | kubectl apply --namespace=kong  -f -
	kustomize build ingress/overlays/local | kubectl apply --namespace=kong -f -

local.clean:
	kustomize build postgres | kubectl delete  --namespace=kong -f -
	kustomize build kong/overlays/local | kubectl delete --namespace=kong -f -
	kustomize build konga/overlays/local | kubectl delete --namespace=kong -f -
	kustomize build ingress-controller | kubectl delete --namespace=kong  -f -
	kustomize build kong-config | kubectl delete --namespace=kong  -f -
	kustomize build ingress/overlays/local | kubectl delete --namespace=kong -f -

gke.deploy:
	kubectl apply -f namespace.yaml
	kubectl apply -f gke-user-permissions.yaml --namespace=kong
	kustomize build postgres | kubectl apply --namespace=kong -f -
	kustomize build kong/overlays/production | kubectl apply --namespace=kong -f -
	kustomize build konga/overlays/production | kubectl apply --namespace=kong -f -
	kustomize build ingress-controller | kubectl apply --namespace=kong -f -
	kustomize build kong-config | kubectl apply --namespace=kong  -f -
	kustomize build ingress/overlays/production | kubectl apply --namespace=kong -f -

gke.clean:
	kustomize build postgres | kubectl delete --namespace=kong -f -
	kustomize build kong/overlays/production | kubectl delete --namespace=kong -f -
	kustomize build konga/overlays/production | kubectl delete --namespace=kong -f -
	kustomize build ingress-controller | kubectl delete --namespace=kong -f -
	kustomize build kong-config | kubectl delete --namespace=kong  -f -
	kustomize build ingress/overlays/production | kubectl delete --namespace=kong -f -

load_config:
	kustomize build kong-config | kubectl apply --namespace=kong  -f -

unload_config:
	kustomize build kong-config | kubectl delete --namespace=kong  -f -

gke.deploy_ingress:
	kustomize build ingress/overlays/production | kubectl apply --namespace=kong -f -

gke.clean_ingress:
	kustomize build ingress/overlays/production | kubectl delete --namespace=kong -f -

delete.all:
	kubectl delete daemonsets,replicasets,services,deployments,pods,rc,jobs,roles,ingress --all --namespace=kong

delete.services_ingress:
	kubectl delete services,ingress --all --namespace=kong

kubens:
	kubens

kubectl.all:
	kubectl get all

kubectl.logs.kong-proxy:
	kubectl logs -n kong --selector="app=kong" -c kong-proxy

terraform.init:
	terraform init ./terraform

terraform.build:
	terraform plan ./terraform
	terraform apply ./terraform

terraform.destroy:
	terraform destroy -force ./terraform
	rm -rf terraform.tfstate*
