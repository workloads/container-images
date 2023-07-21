# Docker Images

> This directory manages Docker Images for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Docker Images](#docker-images)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
  * [Notes](#notes)
    * [Development Helpers](#development-helpers)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.1` or [newer](https://developer.hashicorp.com/packer/downloads)
- Docker `24.0.4` or [newer](https://www.docker.com/products/docker-desktop/)
  - alternatively Docker-compatible runtimes (e.g.: Podman, OrbStack) may be used
- a check-out of [@workloads/tooling](https://github.com/workloads/tooling)

Optional, and only needed for development and testing of Packs:

- `terraform-docs` `0.16.0` or [newer](https://terraform-docs.io/user-guide/installation/)

## Usage

This repository provides a workflow that is wrapped through a [Makefile](./Makefile).

Running `make` without commands will print out the following help information:

```text
🐳 DOCKER IMAGES

Target          Description                                     Usage
init            initialize a Packer Template                    `make init image=my_image`
lint            lint a Docker Image Template                    `make lint image=my_image`
build           build a Docker Image                            `make build image=my_image`
docs            generate documentation for all Packer Images    `make docs image=my_image`
console         start Packer Console                            `make console image=my_image`
yaml_lint       lint YAML files                                 `make yaml_lint`
help            display a list of Make Targets                  `make help`
_listincludes   list all included Makefiles and *.mk files      `make _listincludes`
_selfcheck      lint Makefile                                   `make _selfcheck`

```

> All workflows _may_ be executed manually, though this is not advisable. See the [Makefile](./Makefile) for more information.

## Notes

### Development Helpers

The [Makefile](./Makefile) includes several unsupported helper targets that _may_ be useful when developing additional templates and functionality.

These targets are prefixed with an underscore (`_`) and may be removed at any time.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/docker-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
