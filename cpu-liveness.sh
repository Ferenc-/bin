#!/bin/bash
echo "sampling the CPU metrics for namespace $NS every 2 seconds"
echo "timestamp, pod, cpu_percentage, ready_timestamp"

while true; do
    timestamp=$(date -Iseconds)
    kubectl top pod -n $NS --no-headers |
    while read -r pod CPU _; do
        cpu=${CPU//[^0-9]/}
        # ensure we have milicores
        limit_cpu=$(kubectl get pod $pod -n $NS -o \
        json | jq '[.spec.containers[].resources.limits.cpu // empty] |
                    map(
                        if type=="string" then
                            if endswith("m")
                            then .[:-1]|tonumber
                            else (tonumber*1000)
                            end
                        elif type=="number" then . * 1000
                        else 0
                        end
                    ) | add // 0')
        if [ "$limit_cpu" -eq 0 ]; then
            cpu_percentage=""
        else
            cpu_percentage=$(awk "BEGIN { printf \"%.1f\", $cpu/$limit_cpu*100 }")
        fi

        ready_timestamp=$(kubectl get pod $pod -n $NS \
            -o jsonpath='{.status.conditions[?(@.type=="Ready")].lastTransitionTime}')
        echo "$timestamp, $pod, $cpu_percentage%, $ready_timestamp"
    done
    sleep 2
done
