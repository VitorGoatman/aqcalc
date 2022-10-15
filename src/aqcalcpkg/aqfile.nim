import strutils, re, aq
proc aqFile*(file: string): string =
  for line in file.lines:
    if line.aq != 0:
      result.add line.strip&" = " & $line.aq&"\n"
      let words = line.split(re"\s")
      for word in words:
        if word != "":
          let sum = word.aq
          let slen = ($sum).len
          var offset = word.len - slen
          if offset < 0: offset = 0
          result.add $sum&" "
          for i in 0..<offset: result.add " "
      result.add "\n"
    else: result.add "\n"
