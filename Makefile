## Actions

get_kubeconfig:
	@read -p 'Enter the desired cluser: ' cluster_id; \
	scw k8s kubeconfig get $$cluster_id > ~/.kube/scaleway_fiesta

deploy-kubernetes:
	@cd terraform/kubernetes && terraform apply -auto-approve

delete-kubernetes:
	@cd terraform/kubernetes && terraform destroy

deploy-extra-components:
	@cd terraform/extra-components && terraform apply -auto-approve

delete-extra-components:
	@cd terraform/extra-components && terraform destroy

## 

init-kubernetes:
	@cd terraform/kubernetes && terraform init

init-extra-components:
	@cd terraform/extra-components && terraform init

check-kubernetes: init-kubernetes
	@cd terraform/kubernetes && terraform validate
	@cd terraform/kubernetes && terraform fmt

check-extra-components: init-extra-components
	@cd terraform/extra-components && terraform validate
	@cd terraform/extra-components && terraform fmt

plan-kubernetes: check-kubernetes
	@cd terraform/kubernetes && terraform plan

plan-extra-components: check-extra-components
	@cd terraform/extra-components && terraform plan
