# HTML template code
html <- list()
html$header <- function(prettify.path,docco.path) {
  return(paste('
<html> 
<head>
  <title><%= title %></title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" media="all" href="',docco.path,'/docco.css" />
<link href="',prettify.path,'/src/prettify.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="',prettify.path,'/src/prettify.js"></script>
</head>
<body onLoad="prettyPrint()">
  <div id="container">
    <div id="background"></div>
    <table cellpadding=0 cellspace=0>',sep=''))
}

html$footer <- '</table>
  </div>
</body>
</html>
'
html$h2.s <- "<h2>"
html$h2.e <- "</h2>"
html$p <- "<p/>"
html$pre.s <- '<pre class="prettyprint" style="border:0px;">'
html$ul.s <- "<ul>"
html$li <- "<li>"
html$ul.e <- "</ul>"
html$sec.1 <- function(i) {
  paste('<tr id="section-',i,'">
            <td class="docs">
              <div class="pilwrap">
                <a class="pilcrow" href="#section-',i,'">&#182;</a>
              </div>',sep='')
}
html$sec.2 <- ' </td>
            <td class="code">
              <div class="highlight">'
html$sec.3 <- '</div> </td> </tr>'
