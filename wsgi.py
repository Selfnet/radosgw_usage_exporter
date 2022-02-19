import logging
import os

from prometheus_client import make_wsgi_app

from radosgw_usage_exporter import REGISTRY, RADOSGWCollector

host = os.environ.get('RADOSGW_SERVER', 'http://radosgw:80')
admin_entry = os.environ.get('ADMIN_ENTRY', 'admin')
access_key = os.environ.get('ACCESS_KEY', 'NA')
secret_key = os.environ.get('SECRET_KEY', 'NA')
cluster = os.environ.get('CLUSTER_NAME', 'ceph')
debug = os.environ.get('DEBUG', '0') == '1'

if debug:
    logging.basicConfig(level=logging.DEBUG)

REGISTRY.register(RADOSGWCollector(host, admin_entry, access_key, secret_key, cluster, False))

exporter = make_wsgi_app()
