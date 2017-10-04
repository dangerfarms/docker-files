# gcloud-snapshot

Create a snapshot of a gcloud persistent disk every day.

# Usage

Create a service account with a custom role that allows only creating snapshots of disks.

Environment variables:  
`PROJECT_NAME`  
`ZONE`  
`DISK_NAME`  
`SNAPSHOT_NAME` (Optional, defaults to `DISK_NAME`, date automatically appended)

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
  name: snapshot-disk1
spec:
  replicas: 1
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: snapshot-disk1
    spec:
      containers:
        - name: snapshot-disk1
          image: dangerfarms/gcloud-snapshot
          tty: true
          imagePullPolicy: Always
          env:
          - name: PROJECT_NAME
            value: myproject
          - name: DISK_NAME
            value: disk1
          - name: SNAPSHOT_NAME # Optional, defaults to DISK_NAME, date automatically appended
            value: disk1-snapshot
          - name: ZONE
            value: europe-west1-b
          volumeMounts:
          - name: key
            mountPath: "/key/key.json"
            readOnly: true
      volumes:
      - name: key
        secret:
          secretName: df-gcloud-snapshot

      restartPolicy: Always
```