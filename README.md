# graphicsCardFacts

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with graphicsCardFacts](#setup)
    * [What graphicsCardFacts affects](#what-graphicsCardFacts-affects)
    * [Beginning with graphicsCardFacts](#beginning-with-graphicsCardFacts)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
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

The facts are gathered using the 'lspci' command and is only tested on Linux-based systems.

## Setup

* Install the module
* Run facter to show graphics card facts:

facter graphicscard

### What graphicsCardFacts affects

Nothing on the system is affected by this module, it provides facts only.

### Beginning with graphicsCardFacts


## Usage


## Reference


## Limitations

Currently only supported/tested on Linux as it requires the lspci command.

## Development

Pull requests welcome, or raise an issue on GitHub.

