stop_cluster:

start_cluster:

get_kubeconfig:
	@read -p 'Enter the project ID: ' SCW_DEFAULT_PROJECT_ID; \
	@read -p 'Enter the desired region: ' SCW_DEFAULT_REGION; \
	@read -p 'Enter the desired cluster id: ' SCW_CLUSTER_ID; \
	@read -sp 'Enter your secret key: ' SCW_SECRET_KEY; \
	curl -X GET "https://api.scaleway.com/k8s/v1/regions/$SCW_DEFAULT_REGION/clusters/$SCW_CLUSTER_ID/kubeconfig" -H "X-Auth-Token: $SCW_SECRET_KEY" -H "Content-Type: application/json" \
	-d "{\"project_id\":\"$SCW_DEFAULT_PROJECT_ID\"}"

terraform: tf_check tf_plan tf_apply

tf_check:

tf_plan:

tf_apply:
