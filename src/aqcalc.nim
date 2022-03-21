import docopt, os, strformat, strutils, db_sqlite, algorithm, aqcalcpkg/aq

const doc = """
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
"""

let
  dbpath = getHomeDir() & ".local/share/aqcalc/"
  db = open(dbpath & "entries.db", "", "", "")
  args = docopt doc

discard existsOrCreateDir dbpath

proc writeDB(entry: string, dbname: string) =
  db.exec(sql(&"CREATE TABLE IF NOT EXISTS {dbname} (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, entry VARCHAR(250) UNIQUE);"))
  db.exec(sql(&"INSERT OR IGNORE INTO {dbname} (entry) VALUES ({dbQuote entry});"))

if args["--aqqa"]:
  for word in @(args["<word>"]):
    let
      aqres = word.aq
      dbname = "aq" & $aqres
    writeDB(word.strip.toUpperAscii, dbname)
    echo "AQ ", aqres, " ="
    for r in db.fastRows(sql(&"SELECT entry FROM {dbname} ORDER BY entry")):
      echo "  ", r[0]

else:
  for word in @(args["<word>"]):
    echo "AQ ",word.aq, " = ", word.strip.toUpperAscii

if args["--revaq"]:
  for number in @(args["<number>"]):
    try: discard number.parseInt
    except: quit("Error: \"--revaq\" only accepts integers.", 1)
    let dbname = "aq" & number
    try: db.exec(sql(&"SELECT entry FROM {dbname} ORDER BY entry"))
    except: quit(&"No results for {number}.", 0)
    echo "AQ ", number, " ="
    for r in db.fastRows(sql(&"SELECT entry FROM {dbname} ORDER BY entry")):
      echo "  ", r[0]

if args["-e"]:
  var dump: string = "# aqcalc plain txt db export\n# This is a comment"
  var tables: seq[int]
  for t in db.fastRows(sql"SELECT name FROM sqlite_sequence ORDER BY name;"):
    tables.add(t[0][2..^1].parseInt)
  for t in tables.sorted:
    dump.add &"aq{t}\n"
    for r in db.fastRows(sql(&"SELECT entry FROM aq{t} ORDER BY entry")):
      dump.add &"  {r[0]}\n" 
    dump.add "\n"
  writeFile($args["<filename>"], dump)

if args["-i"]:
  let file: string = $args["<filename>"]
  var curdb: string
  try: discard file.readFile
  except: quit(&"Error: File {file} not found.", 1)
  for line in file.lines:
    if line.startsWith("aq"): curdb = line
    if line.startsWith("  "): writeDB(line.strip.toUpperAscii, curdb)
    if line.startsWith("#"): discard

db.close()
