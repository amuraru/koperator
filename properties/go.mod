module github.com/banzaicloud/koperator/properties

go 1.19

require (
	emperror.dev/errors v0.8.1
	github.com/onsi/gomega v1.27.10
)

require (
	github.com/google/go-cmp v0.5.9 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	golang.org/x/net v0.12.0 // indirect
	golang.org/x/text v0.11.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)

// remove once https://github.com/cert-manager/cert-manager/issues/5953 is fixed
replace github.com/Venafi/vcert/v4 => github.com/jetstack/vcert/v4 v4.9.6-0.20230519122548-219f317ae107
