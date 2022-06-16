get-kubeconfig:
	@read -p 'Enter the desired cluser: ' cluster_id; \
	read -p 'Enter the scaleway profile: ' scw_profile; \
	scw --profile $$scw_profile k8s kubeconfig get $$cluster_id > ~/.kube/scaleway_fr-production

init:
	@cd terraform/$(topology) && terraform init

check: init
	@cd terraform/$(topology) && terraform validate
	@cd terraform/$(topology) && terraform fmt

plan: check
	@cd terraform/$(topology) && terraform plan

apply:
	@cd terraform/$(topology) && terraform apply -auto-approve

destroy:
	@cd terraform/$(topology) && terraform destroy
