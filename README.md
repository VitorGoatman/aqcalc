# aqcalc: Alphanumeric Qabbala Calculator

A simple program and Nim library for calculating gematria values with AQ.

## Install

There is a pre-built binary for Windows in the [releases](https://github.com/VitorGoatman/aqcalc/releases) page.

You can install `aqcalc` with the Nimble package manager if you have Nim installed.

```
nimble install aqcalc
```

## Using

`aqcalc` can be used like any other Nim library.

```nim
import aqcalcpkg/aq

assert aq("Hello, World!") == 214
```

Additionally, `aqcalc` can be invoked at the command line.

```
Aqqabala Calculator

Usage:
  aqcalc [--aqqa] <word>...
  aqcalc --revaq <number>...
  aqcalc (-i | -e ) <filename>
  aqcalc (-h | --help )

Options:
  -h, --help  Show this message
  -i          Import from plain text database
  -e          Export to plain text database
  --aqqa      Save AQ result to local database. (~/.local/share/aqcalc)
  --revaq     Show all database entries that have this result
```
