from strutils import Digits, toLowerAscii

func aq*(input: string): int =
  for c in input.toLowerAscii:
    case c:
      of Digits: result += c.int - 48
      of 'a': result += 10
      of 'b': result += 11
      of 'c': result += 12
      of 'd': result += 13
      of 'e': result += 14
      of 'f': result += 15
      of 'g': result += 16
      of 'h': result += 17
      of 'i': result += 18
      of 'j': result += 19
      of 'k': result += 20
      of 'l': result += 21
      of 'm': result += 22
      of 'n': result += 23
      of 'o': result += 24
      of 'p': result += 25
      of 'q': result += 26
      of 'r': result += 27
      of 's': result += 28
      of 't': result += 29
      of 'u': result += 30
      of 'v': result += 31
      of 'w': result += 32
      of 'x': result += 33
      of 'y': result += 34
      of 'z': result += 35
      else: result += 0
