FROM python:3-slim

ARG UNAME=exporter
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

COPY radosgw_usage_exporter.py wsgi.py /usr/src/app


USER $UNAME

ENV RADOSGW_SERVER=http://radosgw:80
ENV VIRTUAL_PORT=9242
ENV DEBUG=0
EXPOSE 9242

CMD gunicorn --workers=1 wsgi:exporter -b [::]:$VIRTUAL_PORT
