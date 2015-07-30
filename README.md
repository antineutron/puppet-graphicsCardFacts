# graphicsCardFacts

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with graphicsCardFacts](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Provides custom facts to list installed graphics cards and their properties.

## Module Description

This module is used to provide facts for each installed graphics card as follows:

* Class: this is always "VGA compatible controller"
* Class PCI ID: this is always 0300
* Vendor name e.g. NVIDIA
* Vendor PCI ID e.g.10de
* Device name e.g. GTX590
* Device PCI ID e.g. beef

## Setup

* Install the module

### What graphicsCardFacts affects

Nothing on the system is affected by this module, it provides facts only.

## Usage

* Run facter to show graphics card facts:

```
myhostname #facter graphicscards
[{"class"=>"VGA compatible controller ", "class_numeric"=>"0300", "vendor"=>"InnoTek Systemberatung GmbH ", "vendor_numeric"=>"80ee", "device"=>"VirtualBox Graphics Adapter ", "device_numeric"=>"beef"}]
```

## Limitations

Currently only supported/tested on Linux as it requires the lspci command.

## Development

Pull requests welcome, or raise an issue on GitHub.

