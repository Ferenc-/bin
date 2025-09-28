curl -X POST -k -u "${USERNAME}:${API_KEY}"  'https://api.fyre.ibm.com/rest/v1/?operation=build' --data \
'{
    "fyre": {
        "creds": {
            "username": "'"${USERNAME}"'",
            "api_key": "'"${API_KEY}"'",
            "public_key": "'"${SSH_PUBLIC_KEY}"'"
        }
    },
    "product_group_id" : "632",
    "cluster_prefix": "ferenc-g",
    "clusterconfig" : {
        "instance_type" : "virtual_server",
        "platform" : "x"
    },
    "ferenc-g" : [
        {
            "name" : "selfhosted",
            "count" : 1,
            "cpu" : 16,
            "memory" : 64,
            "os" : "Ubuntu 24.04",
            "publicvlan" :"y",
            "privatevlan" : "y",
            "additional_disks" : [{
                "size" : 300
            },{
                "size" : 500
            }]
        }]
}'
