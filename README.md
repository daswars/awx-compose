# awx-compose
awx for compose and docker swarm


The Dockerfile as well as the requirements.txt file are only for exporting the current awx configs.


After that the docker-compose file can be used directly with:

```
docker-compose up -d
```

For all those who want to use a docker stack, I generated it here.

docker stack deploy -c docker-stack.yml awx --prune