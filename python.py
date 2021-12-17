import requests
from requests.auth import HTTPBasicAuth

host = "localhost"
port = 18334
user = "user"
password = "p4ssw0rd"

r = requests.post(
    f"https://{host}:{port}",
    auth=HTTPBasicAuth(user, password),
    json={"jsonrpc": "1.0", "id": "0", "method": "getinfo", "params": []},
    verify="certificates/rpc.cert",
)
print(r.text)
r.raise_for_status()

r = requests.post(
    f"https://{host}:{port}",
    auth=HTTPBasicAuth(user, password),
    json={"jsonrpc": "1.0", "id": "0", "method": "generate", "params": [1]},
    verify="certificates/rpc.cert",
)
print(r.json())
r.raise_for_status

r = requests.post(
    f"https://{host}:{port}",
    auth=HTTPBasicAuth(user, password),
    json={"jsonrpc": "1.0", "id": "0", "method": "setgenerate", "params": [True]},
    verify="certificates/rpc.cert",
)
print(r.json())
r.raise_for_status