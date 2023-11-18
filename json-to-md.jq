##
## convert firefox bookmarks json into markdown file
##

# jq -rf json-to-md.jq programming_bookmarks.json > README.md

def indent($i): "  " + $i;
def heading($header): $header + "#";

def title: if has("uri") then "[\(.title)](\(.uri // ""))" else .title end;

def list($i; $prefix):
  $i + $prefix + " " + title , (.children[]? // {} | if has("title") and has("uri") then list(indent($i); "-") elif has("title") then list(indent($i); heading("- " + $prefix)) else "" end);

list(""; "#")
