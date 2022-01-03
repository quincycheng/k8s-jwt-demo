module api-app

go 1.17

require github.com/cyberark/conjur-api-go v0.8.1

require (
	github.com/bgentry/go-netrc v0.0.0-20140422174119-9fd32a8b3d3d // indirect
	github.com/sirupsen/logrus v1.8.1 // indirect
	golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
)

replace github.com/cyberark/conjur-api-go v0.8.1 => github.com/quincycheng/conjur-api-go v0.8.1-jwt
