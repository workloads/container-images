# Container Image: `minecraft-bot`

![Container Image: `minecraft-bot`](https://assets.workloads.io/container-images/minecraft-bot.png)

## Table of Contents

<!-- TOC -->
* [Container Image: `minecraft-bot`](#container-image-minecraft-bot)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
  * [Usage](#usage)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.0` or [newer](https://developer.hashicorp.com/packer/downloads)
- Docker `24.0.0` or [newer](https://www.docker.com/products/docker-desktop/)
  - alternate compatible runtimes (e.g.: Podman, OrbStack) may be used

## Overview

|                 |                                       |
|-----------------|---------------------------------------|
| image template  | [template.pkr.hcl](template.pkr.hcl)               |
| image variables | [variables.pkr.hcl](variables.pkr.hcl)              |
| build command   | `make build template=./minecraft-bot` |
| lint command    | `make lint template=./minecraft-bot`  |

## Usage

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
