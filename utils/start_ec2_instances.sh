#!/usr/bin/env bash

IFS=',' read -ra INSTANCE_IDS <<< "$INSTANCES"
TOTAL_INSTANCES="${#INSTANCE_IDS[@]}"

trigger_jenkins () {
    echo "Sleeping now to get Jenkins in ready state..."

    sleep 60

    echo "Posting to Jenkins..."

	curl -X POST "$JOB/buildWithParameters" --user user:"$APIKEY"

    echo "SUCCESS"
}

for (( i=1; i<TOTAL_INSTANCES+1; i++ ));
do
    aws ec2 start-instances --instance-ids "${INSTANCE_IDS[$i-1]}"

    while :
    do
        INSTANCE_STATE=$(aws ec2 describe-instances --instance-ids "${INSTANCE_IDS[$i-1]}" --output text --query 'Reservations[*].Instances[*].State.Name')

        if [[ $INSTANCE_STATE == "running" ]]; then
            echo "Instance $INSTANCE_STATE for ${INSTANCE_IDS[$i-1]}";
            break
        else
            echo 'Waiting for ready state...';
            sleep 10;
        fi
    done

    if [[ $i == "$TOTAL_INSTANCES" ]]; then
        trigger_jenkins
    fi
done
