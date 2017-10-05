# gcloud-snapshot

Create a snapshot of gcloud persistent disks every day.

# Usage

Create a service account with a custom role that allows only creating snapshots of disks.

Environment variables:  
`PROJECT_NAME`  
`ZONE`  
`EXCLUDE_DISKS` (gcloud expression) if the disk name matches, it will not be backed up.

You also need to mount the key JSON file for the service account to `/key/key.json`.

## Kubernetes example

Create the Secret using this here handy script:

```bash
./create-secret.sh <key-file>
kubectl apply -f secret.yaml
```

Then use something like this deployment:
```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: snapshot-disks
spec:
  replicas: 1
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: snapshot-disks
    spec:
      containers:
        - name: snapshot-disks
          image: dangerfarms/gcloud-snapshot
          tty: true
          imagePullPolicy: Always
          env:
          - name: PROJECT_NAME
            value: myproject
          - name: EXCLUDE_DISKS
            value: gke-cluster-default-pool-xxxxxxx # won't back up any nodes' disks
          - name: ZONE
            value: europe-west1-b
          volumeMounts:
          - name: key
            mountPath: "/key/key.json"
            readOnly: true
      volumes:
      - name: key
        secret:
          secretName: gcloud-snapshot

      restartPolicy: Always
```