#stop_cluster:
#start_cluster:

get_kubeconfig:
	@read -p 'Enter the desired cluser: ' cluster_id; \
	scw k8s kubeconfig get $$cluster_id

tf_init:
	@cd terraform/ && terraform init

tf_check:
	@cd terraform/ && terraform validate
	@cd terraform/ && terraform fmt

tf_plan: tf_check
	@cd terraform/ && terraform plan

tf_apply:
	@cd terraform/ && terraform apply -auto-approve

tf_destroy:
	@cd terraform/ && terraform destroy
