import logging
import sys
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0, '/var/flask')
from app import app as application
