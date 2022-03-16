import strutils, docopt, db_sqlite, os, aqcalcpkg/aq

const doc = """
Aqqabala Calculator

Usage:
  aqcalc <word>...
  aqcalc --aqqa <word>...
  aqcalc --revaq <number>...

Options:
  -h, --help  Show this message
  --aqqa      Save AQ result to local database. (~/.local/share/aqcalc)
  --revaq     Show all database entries that have this result.
"""

let
  dbpath = getHomeDir() & ".local/share/aqcalc/"
  db = open(dbpath & "entries.db", "", "", "")
  args = docopt doc

discard existsOrCreateDir dbpath

proc writeDB(entry: string, aqres: int) =
  let dbname = "aq" & $aqres
  db.exec(sql("CREATE TABLE IF NOT EXISTS $# (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, entry VARCHAR(250) UNIQUE);".format dbname))
  db.exec(sql("INSERT OR IGNORE INTO $# (entry) VALUES ('$#');".format(dbname, entry)))

if isMainModule:
  if args["--aqqa"]:
    for word in @(args["<word>"]): 
      let aqres = word.aq
      writeDB($word, aqres)
      echo "AQ ", $aqres, " ="
      for r in db.fastRows(sql("SELECT entry FROM $# ORDER BY entry".format("aq" & $aqres))):
        echo "  ", r[0]
  elif args["--revaq"]:
    for number in @(args["<number>"]):
      try:
        discard number.parseInt
      except:
        quit("Error: \"--revaq\" only accepts integers.", 1)

      db.exec(sql("CREATE TABLE IF NOT EXISTS $# (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, entry VARCHAR(250) UNIQUE);".format("aq" & $number)))
      echo "AQ ", $number, " ="
      for r in db.fastRows(sql("SELECT entry FROM $# ORDER BY entry".format("aq" & $number))):
        echo "  ", r[0]
  else:
    for word in @(args["<word>"]): 
      echo "AQ ",$word.aq, " = ", $word

db.close()
