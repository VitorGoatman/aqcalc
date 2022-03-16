# Package

version       = "0.1.0"
author        = "VitorGoatman"
description   = "Calculate gematria values for Alphanumeric Qabbala"
license       = "Unlicense"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["aqcalc"]


# Dependencies

requires "nim >= 1.6.4"
requires "docopt >= 0.6.7"
