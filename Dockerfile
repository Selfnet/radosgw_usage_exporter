FROM python:3-slim

ARG UNAME=exporter
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

COPY radosgw_usage_exporter.py /usr/src/app

USER $UNAME

EXPOSE 9242
ENV RADOSGW_SERVER=http://radosgw:80 VIRTUAL_PORT=9242 DEBUG=0

CMD [ "python", "-u", "./radosgw_usage_exporter.py" ]
