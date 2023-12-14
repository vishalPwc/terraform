from google.auth import crypt
from google.auth import jwt
import os
import io
import json
import time

# Service account key path
credential_path = "atg.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path

sa_keyfile = credential_path

# Get service account email and load the json data from the service account key file.
with io.open(credential_path, "r", encoding="utf-8") as json_file:
    data = json.loads(json_file.read())
    sa_email = data['client_email']

audience = "https://ecom-np-dev-apigw-2qg3ggwzvl11q.apigateway.ecom-np-dev-385017.cloud.goog"
# e.g : "https://pubsub.googleapis.com/google.pubsub.v1.Publisher"
# If you use cloud endpoints for you API, you can take the x-google-audiences value in your security definitions.

# Expiry time for your JWT token
expiry_length = 1000


def generate_jwt(sa_keyfile,
                 sa_email,
                 audience,
                 expiry_length=36000):
    """Generates a signed JSON Web Token using a Google API Service Account."""

    now = int(time.time())

    # build payload
    payload = {
        'iat': now,
        # expires after 'expiry_length' seconds.
        "exp": now + expiry_length,
        # iss must match 'issuer' in the security configuration in your
        # swagger spec (e.g. service account email). It can be any string.
        'iss': sa_email,
        # aud must be either your Endpoints service name, or match the value
        # specified as the 'x-google-audience' in the OpenAPI document.
        'aud':  audience,
        # sub and email should match the service account's email address
        'sub': sa_email,
        'email': sa_email
    }

    # sign with keyfile
    signer = crypt.RSASigner.from_service_account_file(sa_keyfile)
    jwt_token = jwt.encode(signer, payload)
    # print(jwt_token.decode('utf-8'))
    return jwt_token


signed_jwt = generate_jwt(sa_keyfile, sa_email, audience)
print(signed_jwt)
