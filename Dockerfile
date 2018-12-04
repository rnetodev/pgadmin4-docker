FROM phusion/baseimage:master

ENV PGADMIN_VERSION=3.6 \
    PYTHONDONTWRITEBYTECODE=1 \
    DEBIAN_FRONTEND=noninteractive

# Install postgresql tools for backup/restore
RUN apt-get update -y \
 && apt-get install -y postgresql-client curl libpq-dev python2.7 python2.7-dev build-essential autoconf \
 && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
 && python2.7 get-pip.py \
 && rm get-pip.py \
 && curl "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${PGADMIN_VERSION}/pip/pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" -o "pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" \
 && pip install "pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" \
 && rm *.whl \
 && apt-get remove --auto-remove build-essential autoconf -y \
 && rm -rf /root/.cache \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
 && mkdir -p /pgadmin/config /pgadmin/storage

EXPOSE 5050

COPY LICENSE config_distro.py /usr/local/lib/python2.7/dist-packages/pgadmin4/

CMD ["python2.7", "./usr/local/lib/python2.7/dist-packages/pgadmin4/pgAdmin4.py"]
VOLUME /pgadmin/