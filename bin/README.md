# GoodData ACME Demo Scripts

This folder contains mostly scripts for the ACME demo.
However, there are a few scripts here that may be generally useful.

You must edit `bin/lib/creds.sh` with the correct username and password for SFTP uploads.

Scripts that use SFTP rely on the `sshpass` utility, which can be installed via brew on Mac OS X like this:

```
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

Scripts that use S3 rely on the [AWS Command Line Interface](https://aws.amazon.com/cli/).

Generally useful scripts:

* add2manifest.sh -- given a csv file, creates a manifest file, or adds to an existing manifest file.
