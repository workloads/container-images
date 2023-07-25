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
    * [Development Helpers](#development-helpers)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.1` or [newer](https://developer.hashicorp.com/packer/downloads)
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

Target          Description                                     Usage
init            initialize a Packer Template                    `make init template=my_template`
lint            lint a Container Image Template                 `make lint template=my_template`
build           build a Container Image                         `make build template=my_template`
docs            generate documentation for all Packer Images    `make docs template=my_template`
console         start Packer Console                            `make console template=my_template`
snyk_test       test Image with Snyk Container                  `make snyk_test image=my_image`
yaml_lint       lint YAML files                                 `make yaml_lint`
help            display a list of Make Targets                  `make help`
_listincludes   list all included Makefiles and *.mk files      `make _listincludes`
_selfcheck      lint Makefile                                   `make _selfcheck`
```

> All workflows _may_ be executed manually, though this is not advisable. See the [Makefile](./Makefile) for more information.

## Notes

### Publishing Images

Images can be pushed to a Container Registry by setting the `push-image` flag to `true` as part of the `make build` target.

This will run the [`docker-push`](https://developer.hashicorp.com/packer/plugins/post-processors/docker/docker-push) Post Processor as part of the Packer build process.

### Development Helpers

The [Makefile](./Makefile) includes several unsupported helper targets that _may_ be useful when developing additional templates and functionality.

These targets are prefixed with an underscore (`_`) and may be removed at any time.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.