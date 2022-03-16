from strutils import Digits, parseInt

func aq*(input: string): int =
  for c in input:
    case c:
      of Digits:
        let cr: string = $c
        result += cr.parseInt
      of 'A','a': result += 10
      of 'B','b': result += 11
      of 'C','c': result += 12
      of 'D','d': result += 13
      of 'E','e': result += 14
      of 'F','f': result += 15
      of 'G','g': result += 16
      of 'H','h': result += 17
      of 'I','i': result += 18
      of 'J','j': result += 19
      of 'K','k': result += 20
      of 'L','l': result += 21
      of 'M','m': result += 22
      of 'N','n': result += 23
      of 'O','o': result += 24
      of 'P','p': result += 25
      of 'Q','q': result += 26
      of 'R','r': result += 27
      of 'S','s': result += 28
      of 'T','t': result += 29
      of 'U','u': result += 30
      of 'V','v': result += 31
      of 'W','w': result += 32
      of 'X','x': result += 33
      of 'Y','y': result += 34
      of 'Z','z': result += 35
      else: result += 0

