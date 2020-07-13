
from datetime import *

print(datetime.utcnow() )

print(datetime.now(timezone.utc))

print(datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3] + 'Z')
