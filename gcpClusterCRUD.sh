function create_gcp_cluster() {
    user=$(gcloud config get core/account 2> /dev/null  | awk -F '[/@]' '{ gsub(/\./, "-", $(NF-1)); print tolower($(NF-1))}')
    rand_suffix=$(openssl rand -base64 6 | head -c 5 | tr '[:upper:]' '[:lower:]')
    default_cluster_name="${user}-${rand_suffix}"
    cluster_name=${1:-${default_cluster_name}}
    num_nodes=${2:-3}
    project=${3:-k8s-brewery}
    os=$(uname -o)
    if [[ $os == "Darwin" ]]; then
        expiry_date=$(date -v+30d "+%Y-%m-%d")
    else
        expiry_date=$(date -d "+30 days" +"%Y-%m-%d")
    fi

    echo "Creating cluster with name: ${cluster_name}, num nodes: ${num_nodes}, in project: ${project}, with expiry on: ${expiry_date}"

    gcloud container clusters create "${cluster_name}" \
        --project k8s-brewery \
        --machine-type c3d-highcpu-60 \
        --addons GcsFuseCsiDriver \
        --addons GcpFilestoreCsiDriver \
        --zone us-central1-c \
        --num-nodes "${num_nodes}" \
        --enable-ip-alias \
        --release-channel rapid \
        --workload-pool="${project}.svc.id.goog" \
        --labels=tech-owner="team-k8s,approving-manager=vikas-rana,expiry=${expiry_date}"
}

function delete_gcp_cluster() {
    if [[ $# -ne 1 ]]; then
        echo 'Usage: delete_gcp_cluster CLUSTER_NAME'
        return 1
    fi
    gcloud container clusters delete "${1}" --location us-central1-c
}

function list_gcp_clusters() {
   gcloud container clusters list --project=k8s-brewery
}
