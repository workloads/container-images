# Container Images

> This repository manages container images for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Container Images](#container-images)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
    * [Development](#development)
  * [Usage](#usage)
  * [Notes](#notes)
    * [Specifying a Platform](#specifying-a-platform)
    * [Publishing Images](#publishing-images)
    * [Version Names](#version-names)
    * [Security Scanning](#security-scanning)
    * [Development Helpers](#development-helpers)
    * [Colorized Output](#colorized-output)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.10.x` or [newer](https://developer.hashicorp.com/packer/downloads)
- Docker `24.0.0` or [newer](https://www.docker.com/products/docker-desktop/)
  - alternate compatible runtimes (e.g.: Podman, OrbStack) may be used
- a copy of [@workloads/tooling](https://github.com/workloads/tooling)

### Development

For development and testing of this repository:

- `terraform-docs` `0.17.0` or [newer](https://terraform-docs.io/user-guide/installation/)

## Usage

This repository provides a [Makefile](./Makefile)-based workflow.

Running `make` without commands will print out the following help information:

```text
🐳 CONTAINER IMAGES

Target            Description                                                        Usage
init              initialize a Packer Template                                       `make init template=<template>`
lint              lint a Container Image Template                                    `make lint template=<template>`
build             build a Container Image                                            `make build template=<template>`
docs              generate documentation for all Packer Images                       `make docs template=<template>`
console           start Packer Console                                               `make console template=<template>`
print-secrets     print (sanitized) environment variables                            `make print-secrets`
snyk_test         test Image with Snyk Container                                     `make snyk_test image=<image>`
_registry_login   log in to a (Docker) Registry                                      `make _registry_login`
yaml_lint         lint YAML files                                                    `make yaml_lint`
_link_vars        create a symlink to the shared variables file for a new builder    `make _link_vars builder=<builder>`
help              display a list of Make Targets                                     `make help`
_listincludes     list all included Makefiles and *.mk files                         `make _listincludes`
_selfcheck        lint Makefile                                                      `make _selfcheck`
```

> All workflows _may_ be executed manually, though this is not advisable. See the [Makefile](./Makefile) for more information.

## Notes

### Specifying a Platform

The `platform` flag may be used to specify the name of the (Image) Platform to use.

```shell
make build template=<template> PLATFORM=arm64
````

When omitted, the `platform` flag defaults to the host system's CPU architecture (as reported by `uname -m`).

### Publishing Images

Images may be pushed to a Container Registry by setting the `push` flag to `true` as part of the `make build` target.

This will run the [`docker-push`](https://developer.hashicorp.com/packer/plugins/post-processors/docker/docker-push) Post Processor as part of the Packer build process.

### Version Names

Images are versioned using a string that is derived from the current date and time, normalized to UTC.

The default format is `%Y%m%d-%H%M`, which translates to a string that looks like this: `19701231-2359`.

The default value may be overridden by setting the `VERSION` flag to any (other) string.

### Security Scanning

Images may be scanned for security concerns using [Snyk Container](https://snyk.io/product/container-vulnerability-management/) with the `make snyk_test` command.

> **Note**
> The `snyk_test` target requires the Snyk CLI to be [authenticated](https://docs.snyk.io/snyk-cli/authenticate-the-cli-with-your-account) with the Snyk API.

### Development Helpers

The [Makefile](./Makefile) includes several unsupported helper targets that _may_ be useful when developing additional templates and functionality.

These targets are prefixed with an underscore (`_`) and may be removed at any time.

### Colorized Output

Colorized CLI output may be disabled by setting the `NO_COLOR` environment variable to any non-empty value.

```shell
export NO_COLOR=1 && make
```

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
