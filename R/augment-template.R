add_author_block <- function(x) {
  from <- grep("$if(author)$", x, fixed = TRUE)

  if (!length(from))
    warning("no author line in template, so do not know where to insert",
            "authors block.")

  end <- grep("$endif$", x, fixed = TRUE)
  to <- end[which(end - from > 0)[1]]

  author_block <- c(
    "% Authors",
    "\\usepackage[$if(authorstyle)$$authorstyle$$endif$]{authblk}",
    "\\renewcommand\\Affilfont{$if(affilfont)$$affilfont$$else$\\itshape\\small$endif$}",
    "\\renewcommand\\Authfont{$if(authfont)$$authfont$$endif$}",
    "$for(author)$",
    "\\author{$if(author.name)$$author.name$$else$$author$$endif$}",
    "$for(author.affiliation)$",
    "\\affil{$author.affiliation$}",
    "$endfor$",
    "$endfor$",
    "$for(affiliation)$",
    "\\affil{$affiliation$}",
    "$endfor$"
  )
  c(x[1:(from - 1)], author_block, x[(to+1):length(x)])
}

add_marginals <- function(x) {
  from <- grep("$for(header-includes)$", x, fixed = TRUE)

  if (!length(from))
    warning("no header-includes in template, so do not know where to insert",
            "authors block.")

  marginals <- c(
    "% Add marginal material",
    "$if(marginals)$",
    "\\makeatletter",
    "\\@ifundefined{KOMAClassName}{% if non-KOMA class",
    "  \\IfFileExists{fancyhdr.sty}{%",
    "    \\usepackage{fancyhdr}",
    "    \\setlength{\\headheight}{15.2pt}",
    "    \\pagestyle{$if(marginals.pagestyle)$marginals.pagestyle$else$fancy$endif$}",
    "$for(marginals.header)$",
    "    \\$marginals.header.pos$head[$marginals.header.text$]{$marginals.header.text$}",
    "$endfor$",
    "$for(marginals.footer)$",
    "    \\$marginals.footer.pos$foot[$marginals.header.text$]{$marginals.footer.text$}",
    "$endfor$",
    "  }",
    "}{% if KOMA class",
    "  \\usepackage[automark,autooneside=true]{scrlayer-scrpage}",
    "  \\pagestyle{$if(marginals.pagestyle)$marginals.pagestyle$else$scrheadings$endif$}",
    "$for(marginals.header)$",
    "  \\$marginals.header.pos$ohead[]{$marginals.header.text$}",
    "$endfor$",
    "$for(marginals.header)$",
    "  \\$marginals.footer.pos$ofoot[]{$marginals.footer.text$}",
    "$endfor$",
    "}",
    "\\makeatother",
    "$endif$"
  )

  c(x[1:(from-1)], marginals, x[from:length(x)])
}