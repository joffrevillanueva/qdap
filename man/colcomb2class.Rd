% Generated by roxygen2 (4.0.2): do not edit by hand
\name{colcomb2class}
\alias{colcomb2class}
\title{Combine Columns to Class}
\usage{
colcomb2class(dataframe, combined.columns, class = "list", percent = TRUE,
  digits = 2, elim.old = TRUE, zero.replace = 0, override = FALSE)
}
\arguments{
\item{dataframe}{A dataframe or qdap class (e.g.,
\code{termco}, \code{question_type}, \code{pos_by}, \code{character_table}).}

\item{combined.columns}{A list of named vectors of the colnames/indexes
of the numeric columns to be combined (summed).  If a vector is unnamed a
name will be assigned.}

\item{class}{The class to assign to the output.}

\item{percent}{logical.  If \code{TRUE} output given as percent.  If
\code{FALSE} the output is proportion.}

\item{digits}{Integer; number of decimal places to round when printing.}

\item{elim.old}{logical.  If \code{TRUE} eliminates the columns that are
combined together by the named match.list. \code{TRUE} outputs the table
proportionally (see \code{\link[qdap]{prop}}).}

\item{zero.replace}{Value to replace 0 values with.}

\item{override}{logical.  If \code{TRUE} the printing options (e.g.,
percent, digits, etc.) of the dataframe argument are overrode.}
}
\value{
Returns a list with raw counts, percents and combined raw
and percents.
}
\description{
Combine columns from qdap classes or a \code{data.frame}.
}
\examples{
## `termco` example
ml <- list(
    cat1 = c(" the ", " a ", " an "),
    cat2 = c(" I'" ),
    "good",
    the = c("the", " the ", " the", "the")
)
dat1 <- with(raj.act.1,  termco(dialogue, person, ml))
colcomb2class(dat1, list(cats = c("cat1", "cat2")))

## `question_type` example
dat2 <- question_type(DATA.SPLIT$state, DATA.SPLIT$person)
combs <- list(
    `wh/how` = c("what", "how"),
    oth = c("shall", "implied_do/does/did")
)
colcomb2class(dat2, combs)

## `pos_by` example
dat3 <- with(DATA, pos_by(state, list(adult, sex)))
colcomb2class(dat3, qcv(DT, EX, FW))


## data.frame example
dat4 <- data.frame(X=LETTERS[1:5], matrix(sample(0:5, 20, TRUE), ncol = 4))
colcomb2class(dat4, list(new = c("X1", "X4")))
}

