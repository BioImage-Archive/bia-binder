# Kubernetes Secret

Helm chart to manage Kubernetes secrets

## Values
The only value is `data` which is a dictionary of key value pairs where all values are base64 encoded as required by Kubernetes Secrets.
Base64 encoding is not done automatically because values may not be representable in plain text format.
