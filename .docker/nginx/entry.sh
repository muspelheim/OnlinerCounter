#!/bin/bash

data_path=/var/www/html/;

mkdir -p ${data_path};

for page in `seq 1 ${PAGES_COUNT}`
do
  touch ${data_path}${page}.html

  cat > ${data_path}${page}.html << EOF

  <!DOCTYPE html>
  <html>
    <head>
      <title>New Page ${page}</title>
      <link rel="preload" href="/counter.php?stat=${page}" as="script">
    </head>
    <body>
      <h1>Hello page, ${page}!</h1>
      <div>
        Visitors: <b>
          <!--# block name="counter" -->0<!--# endblock -->
          <!--# include virtual="/counter.php?page=${page}" stub="counter" -->
        </b>
      </div>
    </body>
  </html>
EOF

done

