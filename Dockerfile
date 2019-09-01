FROM python:alpine

RUN apk add --no-cache ansible docker-cli gcc musl-dev python3-dev openssl-dev libffi-dev curl-dev libressl-dev make libxml2

WORKDIR /app

RUN wget -qO- https://github.com/ansible/awx/archive/6.1.0.tar.gz | \
    tar -xz -C /app --strip-components=1 

WORKDIR /app/installer
#changes parameters
RUN sed -i "s|postgres_data_dir=/tmp/pgdocker|postgres_data_dir=/var/pgdocker|g" inventory ;\
    sed -i "s|docker_compose_dir=/tmp/awxcompose|docker_compose_dir=/var/lib/awx|g" inventory ;\
    sed -i "s|#project_data_dir=/var/lib/awx/projects|project_data_dir=/var/awx_projects|g" inventory 

RUN apk add --no-cache libxslt-dev docker-compose git
#install awx
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

CMD ansible-playbook install.yml -i inventory -v
 
# docker run -ti --rm -v $PWD:/var/lib/awx -v /var/run/docker.sock:/var/run/docker.sock awx-builder 
# ash