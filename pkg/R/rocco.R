## rocco
# A library for creating html documentation for R scripts to encourage
# literate programming.  The project essentially leverages the docco
# project <http://jashkenas.github.com/docco/> to be used for R
# scripts.  Code highlighting is performed by the
# google-code-prettify.

# To run rocco you will need to specify the path to:
#- docco.css: https://github.com/jashkenas/docco/blob/master/resources/docco.css
#- google-code-pretty: download at http://code.google.com/p/google-code-prettify/

# This is not meant as a replacement to a more full featured documentation system such a roxygen nor a literate programming solution like Sweave and noweb.

## how to use rocco
#- Sections: use an empty line in your code
#- Headers: begin line with double pound symbols
#- Comments: begin line with a single pound symbol
#- Lists: begin line with pound symbol then dash
#- Variables: denoted by left apostrophe [under construction]

# Note: Within a section, html is created for all headers, then all comments, then all list items.

# We run rocco on its own source code as an example in test.rocco.R.
# Example output can be found at test.rocco.html.

## Beginning of rocco.R source code:
# Load in file
rocco <- function(input.file,output.file=paste(input.file,'.html',sep=''),
                  path.to.prettify="google-code-prettify",
                  path.to.docco=".",browse=FALSE) {
  lines <- readLines(input.file)

# Split the file into sections
  sections <- list()
  emptylines <- which(lines %in% c(""," ","  ","    "))
  start <- 1
  for (i in 1:length(emptylines)) {
    end <- emptylines[i] - 1
    sections[[i]] <- lines[start:end]
    start <- emptylines[i] + 1
  }

# Create function for text lines and properties
  processed <- list()
  for (k in 1:length(sections)) {
    section <- sections[[k]]#lapply(sections[1:8],function(section) {
    
# Decide what each line is: header, comment or list item
    linetypes <- sapply(section,function(s)
                        switch(substr(s,1,2),"##"="header","# "="comment","#-"="list","code")
                        )
    names(linetypes) <- c()
    
# Strip prefix depending on line type
    content <- c()
    for (i in 1:length(section)) {
      content[i] <- switch(linetypes[i],
                           "header" = substring(section[i],4),
                           "comment" = substring(section[i],3),
                           "list" = substring(section[i],3),
                           "code" = section[i],
                           section[i])
    }

# Combine adjacent comments (and code?)
    combined <- list()
    j <- 1
    combined[[j]] <- list(content=content[1],type=linetypes[1])
    if (length(section)>1) {
      for (i in 2:length(section)) {
        if (linetypes[i] == "comment" & linetypes[i-1] == "comment") {
          combined[[j]]$content <- paste(combined[[j]]$content,content[i])
        } else {
          j <- j + 1
          combined[[j]] <- list(content=content[i],type=linetypes[i])
        }
      }
    }
    processed[[k]] <- combined
  }

# Load html template snippets
  data(html)

# For each section
  body <- ""
  for (i in 1:length(processed)) {
    section <- processed[[i]]

# Print out all headers and comments
    doc <- ''
    for (j in 1:length(section)) {
      if (section[[j]]$type=="header") {
        doc <- paste(doc,html$h2.s,section[[j]]$content,html$h2.e,sep='')
      }
      if (section[[j]]$type=="comment") {
        doc <- paste(doc,section[[j]]$content,collapse=html$p)
      }
    }

# Collect all list items in section
    if (any(sapply(section,function(x) (x$type=="list")))) {
        doc <- paste(doc,html$ul.s)
        for (j in 1:length(section)) {
          if (section[[j]]$type=="list") {
            doc <- paste(doc,html$li,section[[j]]$content,sep='')
          }
        }
        doc <- paste(doc,html$ul.e)
    }

# Collect all code in section
    code <- ''
    code <- paste(code,html$pre.s)
    for (j in 1:length(section)) {
      if (section[[j]]$type=="code") {
        code <- paste(code,section[[j]]$content,sep='\n')
      }
    }
    code <- paste(code,html$pre.e)
    
# Collect html code, documention, code into a section and append to body
    body <- paste(body,html$sec.1(i),doc,html$sec.2,code,html$sec.3,sep="")
  }

# Create a single string and write to a file
  out <- paste(html$header(path.to.prettify,path.to.docco),
               body,
               html$footer)
  write(out,file=output.file)

# Optionally open a browser to view the produced html file
  if (browse)
    browseURL(paste("file://", getwd(),"/",output.file, sep = ""))
}

