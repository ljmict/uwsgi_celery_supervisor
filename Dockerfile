FROM ljmict/centos7.5_python3
ENV PROJECT_DIR=/root/project/meiduo_mall/ \
    SUPERVISOR_CONF_DIR=/etc \
    MIRRORS=https://pypi.doubanio.com/simple
LABEL maintainer="ljmict@163.com"
RUN yum install -y epel-release \
    && yum install -y supervisor
COPY requirements.txt ${PROJECT_DIR}
COPY supervisor_conf ${SUPERVISOR_CONF_DIR}
WORKDIR ${PROJECT_DIR}
RUN pip3 install pip -U \
    && pip3 config set global.index-url ${MIRRORS} \
    && pip3 install -r requirements.txt \
    && for directory in uwsgi celery;do mkdir -p /var/log/$directory;done
EXPOSE 8001
CMD ["supervisord"]
