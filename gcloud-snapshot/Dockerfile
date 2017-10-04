FROM google/cloud-sdk:alpine
COPY snap /etc/periodic/daily/snap
CMD crond -l 2 -f