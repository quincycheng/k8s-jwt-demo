# k8s-jwt-demo
This is a demo on Kubernetes for apps to retrieve secrets based on Conjur Authn-JWT with enhanced JWT summon 

3 pods will be created:
 - Secret injection into environment variable with summon when app starts/restarts
 - App fetches secrets using Conjur API & authn-jwt

No init container or side car are required for application pods

This demo tested on minikube v1.24.0 (kubernetes v.1.22.3)

## Usage

### Environment variables required
- `CONJUR_AUTHN_JWT_SERVICE_ID`  (e.g. `kubernetes`) **NEW!**
- `CONJUR_APPLIANCE_URL` (e.g. `https://conjur-oss.conjur-server.svc.cluster.local`)
- `CONJUR_ACCOUNT` (e.g `default`)
- `CONJUR_SSL_CERTIFICATE` (You can get your Conjur SSL certificate by updating & executing the following command with your Conjur Follower/OSS FQDN & port:

`openssl s_client -showcerts  -connect ${CONJUR_FQDN}:${CONJUR_PORT} </dev/null 2>/dev/null | sed -n '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' )`

### To use summon with Authn-JWT
Make sure you're using summon-conjur v0.6.2 or above

### To use Conjur Golang API with Authn-JWT
Make sure you're using conjur-api-go v0.9.0 or above

### Full Demo
Clone this repo &amp; execute the scripts numbered from 0 to 7 one by one under `bin` folder

### Clean Up
Execute `bin/99-cleanup.sh`

## Useful Links
 - Conjur Golang API: https://github.com/cyberark/conjur-api-go
 - summon-conjur provider with Authn-JWT: (https://github.com/cyberark/summon-conjur)

Maintainer:
- [@QuincyCheng](https://github.com/quincycheng)
