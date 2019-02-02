# GoodData-ACME-Demo

Demonstration files used in the GoodData Live! Webinar series plus resources.

## Overview

This folder contains the ACME demo files and scripts for the GoodData Live! webinar series. For most visitors, the most useful thing here will be the scripts in the `bin` directory.

The 'ACME' demo is meant to represent a fairly generic company that purchases,
markets and sells things. It's scope will evolve as the Webinar series progresses.

Check the Git tags/releases to obtain the configuration for a specific webinar episode.

## Prerequisites

Scripts that use SFTP rely on the `sshpass` utility, which can be installed via brew on Mac OS X like this:

```
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

You must create `~/.sshpass_acme` a single line file containing the correct password for SFTP uploads.

Scripts that use S3 rely on the [AWS Command Line Interface](https://aws.amazon.com/cli/). After installing the CLI configure the credentials with:

```
$ aws configure
```

A couple of the scripts use [csvkit](https://csvkit.readthedocs.io/en/stable/).

## Generally useful scripts

The scripts in `bin` are mostly to facilitate the webinar demos, but there are a few scripts here that may be generally useful.

* `add2manifest.sh` -- given a csv file, creates a manifest file, or adds to an existing manifest file.
