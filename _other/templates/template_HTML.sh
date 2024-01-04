#!/bin/bash


file=$1
name=$2


echo $"\
<!DOCTYPE html>
<html lang=\"en\">

<head>
  <meta charset=\"UTF-8\">
  <link rel=\"shortcut icon\" href=\"#\" />
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">

  <meta name=\"theme-color\" content=\"#FFFFFF\" media=\"(prefers-color-scheme: light)\">
  <meta name=\"theme-color\" content=\"#1A1A1A\" media=\"(prefers-color-scheme: dark)\">
  <link rel=\"stylesheet\" href=\"/style/style.css\">
  <script type=\"text/javascript\" src=\"/script.js\"></script>
  <title>${name^^}</title>
</head>

<body>
  <header>
  </header>

  <main id=\"content\">
    <article>
    </article>
  </main>

  <footer>
  </footer>
</body>

</html>" > "$file"
