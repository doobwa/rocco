# rocco 
 A library for creating html documentation for R scripts to encourage
 literate programming.  The project essentially leverages the docco
 project <http://jashkenas.github.com/docco/> to be used for R
 scripts.  Code highlighting is performed by the
 google-code-prettify.

 To run rocco you will need to specify the path to:
- docco.css: https://github.com/jashkenas/docco/blob/master/resources/docco.css
- google-code-pretty: download at http://code.google.com/p/google-code-prettify/

 This is not meant as a replacement to a more full featured documentation system such a roxygen nor a literate programming solution like Sweave and noweb.

## how to use rocco
- Sections: use an empty line in your code
- Headers: begin line with double pound symbols
- Comments: begin line with a single pound symbol
- Lists: begin line with pound symbol then dash
- Variables: denoted by left apostrophe [under construction]

 Note: Within a section, html is created for all headers, then all comments, then all list items.

 We run rocco on its own source code as an example in test.rocco.R.
 Example output can be found at test.rocco.html.
