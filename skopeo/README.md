# skopeo-ubi

[![Docker Repository on Quay](https://quay.io/repository/redhat-emea-ssa-team/skopeo-ubi/status "Docker Repository on Quay")](https://quay.io/repository/redhat-emea-ssa-team/skopeo-ubi)

## Why I build from source

because of https://github.com/containers/skopeo/issues/594

## Image sync example 

How to sync an image from docker.io to quay.io:

1) Create image repo on quay.io
2) Create robot account with write permissions to the new image repo
3) Create secret with the robot account credentials
4) Deploy CronJob, don't forget to adjust command and 
    ```yaml
    apiVersion: batch/v1beta1
    kind: CronJob
    metadata:
    name: registry-image-sync
    spec:
    # Format: https://en.wikipedia.org/wiki/Cron
    schedule: '@weekly'
    suspend: false
    jobTemplate:
        spec:
        template:
            spec:
            restartPolicy: Never
            containers:
                - name: skopeo-ubi
                image: quay.io/redhat-emea-ssa-team/skopeo-ubi:latest
                command:  
                - "/bin/sh"
                - "-c"
                - |
                    skopeo copy \
                    --authfile=/pushsecret/.dockerconfigjson \
                    docker://docker.io/library/registry:2 \
                    docker://quay.io/redhat-emea-ssa-team/registry:2
                imagePullPolicy: Always
                volumeMounts:
                    - mountPath: /pushsecret
                    name: pushsecret
                    readOnly: true
            volumes:
            - name: pushsecret
                secret:
                secretName: redhat-emea-ssa-team-registry-sync-pull-secret
    ```
