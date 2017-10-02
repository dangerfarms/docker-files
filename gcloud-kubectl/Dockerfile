# based on https://hub.docker.com/r/lachlanevenson/k8s-kubectl
FROM google/cloud-sdk:alpine
ENV KUBE_LATEST_VERSION="v1.7.5"
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*
