module FormatFunctions where

-- Formatting function for html output

htmlhead = "<!doctype html><html><head><meta charset=\"UTF-8\"><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"></style></head><body>"

html :: String -> String -> String -> String
html   "s"    k v = "\n<section><h2>" ++ k ++ "</h2>" ++ "<p>" ++ v ++ "</p></section>"
html  "st"    k v = htmlhead ++ "\n<h1>" ++ v ++ "</h1>"
html  "ss"    k v = "\n<section><h3>" ++ k ++ "</h3>" ++ "<p>" ++ v ++ "</p></section>"
html  "sh"    k v = "\n<h2>" ++ k ++ "</h2>"
html "img"    k v = "\n<span class = \"imgspan\"><img src=\"" ++ v ++ "\" alt=\"" ++ k ++ "\"/><br/>"
html "imgCap" k v = "\n<em>" ++ v ++ "</em></span>"
html  "es"    k v = "\n<section><h2>" ++ k ++ "</h2>" ++ "<p>" ++ v ++ "</p></section></html>"
html  "ts"    k v = "\n<table><tr><td>" ++ k ++ "</td>" ++ "<td>" ++ v ++ "</td></tr>"
html  "tr"    k v = "\n<tr><td>" ++ k ++ "</td>" ++ "<td>" ++ v ++ "</td></tr>"
html "tro"    k v = "\n<table><tr><td>" ++ k ++ "</td>" ++ "<td>" ++ v ++ "</td></tr></table>"
html  "te"    k v = "\n<tr><td>" ++ k ++ "</td>" ++ "<td>" ++ v ++ "</td></tr></table>"
html  "de"    k v = "\n</html>"
html   "-"    _ _ = ""
html    _     _ _ = ""

-- Formatting function for Markdown output
md :: String -> String -> String -> String
md   "s"    k v = "\n## " ++ k ++ "\n" ++ v
md  "st"    k v = "\n# " ++ v
md  "ss"    k v = "\n### " ++ k ++ "\n" ++  v
md  "sh"    k v = "\n## " ++ k
md "img"    k v = "\n!["++ k ++"](" ++ v ++ ")"
md "imgCap" k v = "\n*" ++ v ++ "*"
md  "es"    k v = "\n## " ++ k ++ "\n" ++ v
md  "ts"    k v = "\n|||\n| ---: | --- |\n|" ++ k ++ " | " ++ v ++ " |"
md  "tr"    k v = "\n| " ++ k ++ " | " ++ v ++ " |"
md "tro"    k v = "\n|||\n| ---: | --- |\n|" ++ k ++ " | " ++ v ++ " |\n"
md  "te"    k v = "| " ++ k ++ " | " ++ v ++ " |\n"
md  "de"    k v = ""
md   "-"    _ _ = ""
md    _     _ _ = ""


-- Formatting function for ReStructured text
rs :: String -> String -> String -> String
rs   "s"    k v = "\n" ++ k ++ "\n------\n" ++ v
rs  "st"    k v = "\n" ++ v ++ "\n======\n"
rs  "ss"    k v = "\n" ++ k ++ "\n~~~~~~~\n" ++  v
rs  "sh"    k v = "\n " ++ k ++ "\n------\n"
rs "img"    k v = "\n!["++ k ++"](" ++ v ++ ")"
rs "imgCap" k v = "\n*" ++ v ++ "*"
rs  "es"    k v = "\n" ++ k ++ "\n------\n" ++ v
rs  "ts"    k v = "\n|||\n| ---: | --- |\n|" ++ k ++ " | " ++ v ++ " |"
rs  "tr"    k v = "\n| " ++ k ++ " | " ++ v ++ " |"
rs "tro"    k v = "\n|||\n| ---: | --- |\n|" ++ k ++ " | " ++ v ++ " |\n"
rs  "te"    k v = "| " ++ k ++ " | " ++ v ++ " |\n"
rs  "de"    k v = ""
rs   "-"    _ _ = ""
rs    _     _ _ = ""
