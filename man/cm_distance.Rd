% Generated by roxygen2 (4.0.2): do not edit by hand
\name{cm_distance}
\alias{cm_distance}
\title{Distance Matrix Between Codes}
\usage{
cm_distance(dataframe, pvals = c(TRUE, FALSE), replications = 1000,
  parallel = TRUE, extended.output = TRUE, time.var = TRUE,
  code.var = "code", causal = FALSE, start.var = "start",
  end.var = "end", cores = detectCores()/2)
}
\arguments{
\item{dataframe}{A data frame from the cm_x2long family
(\code{cm_range2long}; \code{cm_df2long}; \code{cm_time2long}).}

\item{pvals}{A logical vector of length 1 or 2.  If element 2 is blank
element 1 will be recycled.  If the first element is \code{TRUE} pvalues
will be calculated for the combined (main) output for all repeated measures
from simulated resampling of the data.  If the second element is \code{TRUE}
pvalues will be calculated for the individual (extended) repeated measures
output from simulated resampling of the data.  Default is to calculate
pvalues for the main output but not for the extended output.  This process
involves multiple resampling of the data and is a time consuming process.  It
may take from a few minutes to days to calculate the pvalues depending on the
number of all codes use, number of different codes and number of
\code{replications}.}

\item{replications}{An integer value for the number of replications used in
resampling the data if any \code{pvals} is \code{TRUE}.  It is recommended
that this value be no lower than 1000. Failure to use enough replications
may result in unreliable pvalues.}

\item{parallel}{logical.  If \code{TRUE} runs the \code{cm_distance} on
multiple cores (if available).  This will generally be effective with most
data sets, given there are repeated measures, because of the large number of
simulations.  Default uses 1/2 of the available cores.}

\item{extended.output}{logical.  If \code{TRUE} the information on individual
repeated measures is calculated in addition to the aggregated repeated
measures results for the main output.}

\item{time.var}{An optional variable to split the dataframe by (if you have
data that is by various times this must be supplied).}

\item{code.var}{The name of the code variable column.  Defaults to "codes" as
out putted by x2long family.}

\item{causal}{logical.  If \code{TRUE} measures the distance between x and y
given that x must precede y.  That is, only those \eqn{y_i} that begin after
the \eqn{x_i} has begun will be considered, as it is assumed that x precedes
y.  If \code{FALSE} x is not assumed to precede y.  The closest \eqn{y_i}
(either its beginning or end) is calculated to \eqn{x_i} (either it's
beginning or end).}

\item{start.var}{The name of the start variable column.  Defaults to "start"
as out putted by x2long family.}

\item{end.var}{The name of the end variable column.  Defaults to "end" as out
putted by x2long family.}

\item{cores}{An integer value describing the number of cores to use if
\code{parallel = TRUE}.  Default is to use half of the available cores.}
}
\value{
An object of the class \code{"cm_distance"}.  This is a list with the
following components:

\item{pvals}{A logical indication of whether pvalues were calculated}
\item{replications}{Integer value of number of replications used}
\item{extended.output}{An optional list of individual repeated measures
information}
\item{main.output}{A list of aggregated repeated measures information}
\item{adj.alpha}{An adjusted alpha level (based on \eqn{\alpha = .05}) for
the estimated p-values using the upper end of the confidence interval around
the p-values}

Within the lists of extended.output and list of the main.output are the
following items:

\item{mean}{A distance matrix of average distances between codes}
\item{sd}{A matrix of standard deviations of distances between codes}
\item{n}{A matrix of counts of distances between codes}
\item{stan.mean}{A matrix of standardized values of distances between
codes.  The closer a value is to zero the closer two codes relate.}
\item{pvalue}{A n optional matrix of simulated pvalues associated with
the mean distances}
}
\description{
Generate distance measures to ascertain a mean distance measure between codes.
}
\details{
Note that row names are the first code and column names are the
second comparison code. The values for Code A compared to Code B will not be
the same as Code B compared to Code A. This is because, unlike a true
distance measure, cm_distance's matrix is asymmetrical. \code{cm_distance}
computes the distance by taking each span (start and end) for Code A and
comparing it to the nearest start or end for Code B.
}
\section{Warning}{
 p-values are estimated and thus subject to error.  More
replications decreases the error.  Use:

\deqn{p \pm \left (  1.96 \cdot \sqrt{\frac{\alpha(1-\alpha)}{n}}\right )}{p +/- (1.96 * \sqrt[\alpha * (1-\alpha)/n])}

to adjust the confidence in the
estimated p-values based on the number of replications.
}
\examples{
\dontrun{
foo <- list(
    AA = qcv(terms="02:03, 05"),
    BB = qcv(terms="1:2, 3:10"),
    CC = qcv(terms="1:9, 100:150")
)

foo2  <- list(
    AA = qcv(terms="40"),
    BB = qcv(terms="50:90"),
    CC = qcv(terms="60:90, 100:120, 150"),
    DD = qcv(terms="")
)

(dat <- cm_2long(foo, foo2, v.name = "time"))
plot(dat)
(out <- cm_distance(dat, replications=100))
names(out)
names(out$main.output)
out$main.output
out$extended.output
print(out, new.order = c(3, 2, 1))
print(out, new.order = 3:2)
#========================================
x <- list(
    transcript_time_span = qcv(00:00 - 1:12:00),
    A = qcv(terms = "2.40:3.00, 6.32:7.00, 9.00,
        10.00:11.00, 59.56"),
    B = qcv(terms = "3.01:3.02, 5.01,  19.00, 1.12.00:1.19.01"),
    C = qcv(terms = "2.40:3.00, 5.01, 6.32:7.00, 9.00, 17.01")
)
(dat <- cm_2long(x))
plot(dat)
(a <- cm_distance(dat, causal=TRUE, replications=100))

## Plotting as a network graph
datA <- list(
    A = qcv(terms="02:03, 05"),
    B = qcv(terms="1:2, 3:10, 45, 60, 200:206, 250, 289:299, 330"),
    C = qcv(terms="1:9, 47, 62, 100:150, 202, 260, 292:299, 332"),
    D = qcv(terms="10:20, 30, 38:44, 138:145"),
    E = qcv(terms="10:15, 32, 36:43, 132:140"),
    F = qcv(terms="1:2, 3:9, 10:15, 32, 36:43, 45, 60, 132:140, 250, 289:299"),
    G = qcv(terms="1:2, 3:9, 10:15, 32, 36:43, 45, 60, 132:140, 250, 289:299"),
    H = qcv(terms="20, 40, 60, 150, 190, 222, 255, 277"),
    I = qcv(terms="20, 40, 60, 150, 190, 222, 255, 277")
)

datB  <- list(
    A = qcv(terms="40"),
    B = qcv(terms="50:90, 110, 148, 177, 200:206, 250, 289:299"),
    C = qcv(terms="60:90, 100:120, 150, 201, 244, 292"),
    D = qcv(terms="10:20, 30, 38:44, 138:145"),
    E = qcv(terms="10:15, 32, 36:43, 132:140"),
    F = qcv(terms="10:15, 32, 36:43, 132:140, 148, 177, 200:206, 250, 289:299"),
    G = qcv(terms="10:15, 32, 36:43, 132:140, 148, 177, 200:206, 250, 289:299"),
    I = qcv(terms="20, 40, 60, 150, 190, 222, 255, 277")
)

(datC <- cm_2long(datA, datB, v.name = "time"))
plot(datC)
(out2 <- cm_distance(datC, replications=1250))

plot(out2)
plot(out2, label.cex=2, label.dist=TRUE, digits=5)
}
}
\references{
\url{http://stats.stackexchange.com/a/22333/7482}
}
\seealso{
\code{\link[qdap]{print.cm_distance}}
}
\keyword{association}
\keyword{codes}
\keyword{distance}

