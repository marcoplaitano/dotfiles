#!/bin/bash


file=$1
name=$2


echo $"\
<!--
@file $(basename "$file")
@author Marco Plaitano
@date $(date +'%d %b %Y')
-->

<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <link rel=\"shortcut icon\" href=\"#\" />
    <link rel=\"stylesheet\" href=\"./style.css\">
    <script type=\"text/javascript\" src=\"./script.js\"></script>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>${name^^}</title>
</head>
<body>

</body>
</html>" > "$file"
