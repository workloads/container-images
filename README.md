# Container Images

> This directory manages Container Images for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Container Images](#container-images)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
  * [Notes](#notes)
    * [Publishing Images](#publishing-images)
    * [Security Scanning](#security-scanning)
    * [Development Helpers](#development-helpers)
    * [Colored Output](#colored-output)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.0` or [newer](https://developer.hashicorp.com/packer/downloads)
- Docker `24.0.0` or [newer](https://www.docker.com/products/docker-desktop/)
  - alternate compatible runtimes (e.g.: Podman, OrbStack) may be used
- a check-out of [@workloads/tooling](https://github.com/workloads/tooling)

Optional, and only needed for development and testing of Container Images:

- `terraform-docs` `0.16.0` or [newer](https://terraform-docs.io/user-guide/installation/)

## Usage

This repository provides a workflow that is wrapped through a [Makefile](./Makefile).

Running `make` without commands will print out the following help information:

```text
🐳 CONTAINER IMAGES

Target            Description                                     Usage
init              initialize a Packer Template                    `make init template=<template>`
lint              lint a Container Image Template                 `make lint template=<template>`
build             build a Container Image                         `make build template=<template>`
docs              generate documentation for all Packer Images    `make docs template=<template>`
console           start Packer Console                            `make console template=<template>`
print-secrets     print (sanitized) environment variables         `make print-secrets`
snyk_test         test Image with Snyk Container                  `make snyk_test image=<image>`
yaml_lint         lint YAML files                                 `make yaml_lint`
_registry_login   log in to a (Docker) Registry                   `make _registry_login`
help              display a list of Make Targets                  `make help`
_listincludes     list all included Makefiles and *.mk files      `make _listincludes`
_selfcheck        lint Makefile                                   `make _selfcheck`
```

> All workflows _may_ be executed manually, though this is not advisable. See the [Makefile](./Makefile) for more information.

## Notes

### Publishing Images

Images may be pushed to a Container Registry by setting the `push` flag to `true` as part of the `make build` target.

This will run the [`docker-push`](https://developer.hashicorp.com/packer/plugins/post-processors/docker/docker-push) Post Processor as part of the Packer build process.

### Security Scanning

Images may be scanned for security concerns using [Snyk Container](https://snyk.io/product/container-vulnerability-management/) with the `make snyk_test` command.

> **Note**
> The `snyk_test` target requires the Snyk CLI to be [authenticated](https://docs.snyk.io/snyk-cli/authenticate-the-cli-with-your-account) with the Snyk API.

### Development Helpers

The [Makefile](./Makefile) includes several unsupported helper targets that _may_ be useful when developing additional templates and functionality.

These targets are prefixed with an underscore (`_`) and may be removed at any time.

### Colored Output

Colorized CLI output may be disabled by setting the `NO_COLOR` environment variable to any non-empty value.

```shell
export NO_COLOR=1 && make
```

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
