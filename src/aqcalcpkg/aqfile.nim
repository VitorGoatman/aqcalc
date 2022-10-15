from strutils import split
from aq import aq
proc aqFile*(file: string): string =
  for line in file.lines:
    let lineaq = line.aq
    if lineaq != 0:
      let words = line.split
      var tline,nline:string
      for word in words:
        if word != "":
          if word.len == 1: tline.add word&"  "
          else: tline.add word&" "
          let sum = word.aq
          let slen = ($sum).len
          var offset = word.len - slen
          if offset < 0: offset = 0
          nline.add $sum&" "
          for i in 0..<offset: nline.add " "
      tline.add "= " & $lineaq
      result.add tline&"\n"&nline&"\n"
    else: result.add "\n"
