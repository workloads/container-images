# Container Image: `alpine-with-cloudinit`

![Container Image: `alpine-with-cloudinit`](https://assets.workloads.io/container-images/alpine-with-cloudinit.png)

## Table of Contents

<!-- TOC -->
* [Container Image: `alpine-with-cloudinit`](#container-image-alpine-with-cloudinit)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
  * [Usage](#usage)
    * [Inputs](#inputs)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.10.0` or [newer](https://developer.hashicorp.com/packer/downloads)
- Docker `24.0.0` or [newer](https://www.docker.com/products/docker-desktop/)
  - alternate compatible runtimes (e.g.: Podman, OrbStack) may be used

## Overview

|                 |                                               |
|-----------------|-----------------------------------------------|
| image template  | [template.pkr.hcl](template.pkr.hcl)                       |
| image variables | [variables.pkr.hcl](variables.pkr.hcl)                      |
| build command   | `make build template=./alpine-with-cloudinit` |
| lint command    | `make lint template=./alpine-with-cloudinit`  |

## Usage

The `alpine-with-cloudinit` image should be run with a Docker Volume that maps to `/config`:

```shell
docker \
  run \
    --interactive \
    --quiet \
    --rm \
    --tty \
    --volume "/tmp/user-data:/config" \
    ghcr.io/workloads/alpine-with-cloudinit:latest
```

<!-- BEGIN_PACKER_DOCS -->
### Inputs

| Name | Description | Default |
|------|-------------|---------|
| commit | Toggle to commit the Container Image, rather than export it. | `true` |
| force_tag | Forcibly tag Image, even if an identical Tag already exists. | `true` |
| inline_commands | Commands to run with the Shell Provisioner. | ```[ "apk update", "apk upgrade", "apk add cloud-init", "apk fix" ]``` |
| inline_shebang | Shebang to use with the Shell Provisioner. | `"/bin/sh -e"` |
| keep_input_artifact | Toggle to keep the input Artifact after pushing to an Image Registry. | `true` |
| platforms | Map of Platforms. | ```{ "arm": "linux/arm/v7", "arm64": "linux/arm64/v8", "x86_64": "linux/amd64" }``` |
| pull | Toggle to pull the Container Image prior to building. | `true` |
| source_image | Namespace and Image Slug of the Input Container Image. | `"alpine"` |
| source_payload | File or Directory to upload to the Output Container Image. | `null` |
| source_registry | Registry of the Input Container Image. | `"index.docker.io"` |
| source_version | Platform Map of Versions of the Input Container Image. | ```{ "arm": "3.19.0@sha256:41f5f86616c51186dde18811bae696c689d6d492e1428f84fd74d42b43799c71", "arm64": "3.19.0@sha256:a70bcfbd89c9620d4085f6bc2a3e2eef32e8f3cdf5a90e35a1f95dcbd7f71548", "x86_64": "3.19.0@sha256:13b7e62e8df80264dbb747995705a986aa530415763a6c58f84a3ca8af9a5bcd" }``` |
| target_image_description | Description of the Output Container Image. | `"Alpine Linux with Cloud-Init"` |
| target_image_license | License of the Output Container Image. | `"Apache-2.0"` |
| target_image_name | Name of the Output Container Image. | `"alpine-with-cloudinit"` |
| target_image_org | Namespace / Organization of the Output Container Image. | `"workloads"` |
| target_image_repository_namespace | Source Namespace of the Output Container Image. | `"https://github.com/workloads"` |
| target_image_workdir | WORKDIR of the Output Container Image. | `"/"` |
| target_platform | Target Platform as received from `make`. | n/a |
| target_registry_password | Password of the Container Registry of the Output Container Image. Parsed using `env()`. | `"PACKER_TARGET_REGISTRY_PASSWORD"` |
| target_registry_server | Address of the Container Registry of the Output Container Image. | `"ghcr.io"` |
| target_registry_username | Username of the Container Registry of the Output Container Image. Parsed using `env()`. | `"PACKER_TARGET_REGISTRY_USERNAME"` |
| target_version | Target Version Output Container Image as received from `make`. | n/a |
<!-- END_PACKER_DOCS -->

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
