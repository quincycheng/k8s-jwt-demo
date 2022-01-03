# k8s-jwt-demo
This is a demo on Kubernetes for apps to retrieve secrets based on Conjur Authn-JWT with enhanced JWT summon (see [link](https://github.com/quincycheng/summon-conjur)) &amp; Golang API (see [link](https://github.com/quincycheng/conjur-api-go))

3 pods will be created:
 - Secret injection into environment variable with summon when app starts/restarts
 - App fetches secrets using Conjur API & authn-jwt

No init container or side car are required for application pods

This demo tested on minikube v1.24.0 (kubernetes v.1.22.3)

## Usage
### To use summon with Authn-JWT
Follow the guideline on offical doc and replace the summon-conjur provider binary file with the one under `summon-conjur-authn-jwt` folder 

### To use Conjur Golang API with Authn-JWT
Add the following line at the end of go.mod file
`replace github.com/cyberark/conjur-api-go v0.8.1 => github.com/quincycheng/conjur-api-go v0.8.1-jwt`
You may need to `go get -u && go mod tidy` to update your own `go.sum` file

Example: `apps/api-app/go.mod`

### Full Demo
Clone this repo &amp; execute the scripts numbered from 0 to 7 one by one under `bin` folder

### Clean Up
Execute `bin/99-cleanup.sh`

## Summon-Conjur Provider for Authn-JWT
`summon-conjur-authn-jwt` folder contains compiled binary on various platform based on `v0.8.1` of `summon-conjur` provider

## Useful Links
 - [Updated Conjur Golang API](https://github.com/quincycheng/conjur-api-go)
 - [Repo of summon-conjur provider with Authn-JWT](https://github.com/quincycheng/summon-conjur)
