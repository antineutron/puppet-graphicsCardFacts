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

### What graphicsCardFacts affects

* Nothing on the system is affected by this module, it provides facts only.

### Beginning with graphicsCardFacts

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
