FROM phusion/baseimage

ENV PGADMIN_VERSION=3.1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DEBIAN_FRONTEND=noninteractive

# Install postgresql tools for backup/restore
RUN apt update -y \
 && apt install --force-yes -y postgresql postgresql-contrib \
 && apt install --force-yes -y python2.7 python2.7-dev

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python2.7 get-pip.py

RUN apt install --force-yes -y build-essential autoconf libpq-dev

RUN pip install --upgrade pip \
 && echo "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${PGADMIN_VERSION}/pip/pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" | pip install --no-cache-dir -r /dev/stdin \
 && mkdir -p /pgadmin/config /pgadmin/storage

EXPOSE 5050

COPY LICENSE config_distro.py /usr/local/lib/python2.7/dist-packages/pgadmin4/

CMD ["python2.7", "./usr/local/lib/python2.7/dist-packages/pgadmin4/pgAdmin4.py"]
VOLUME /pgadmin/