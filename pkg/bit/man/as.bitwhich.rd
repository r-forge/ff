\name{as.bitwhich}
\alias{as.bitwhich}
\alias{as.bitwhich.bit}
\alias{as.bitwhich.bitwhich}
\alias{as.bitwhich.ri}
\alias{as.bitwhich.which}
\alias{as.bitwhich.integer}
\alias{as.bitwhich.double}
\alias{as.bitwhich.logical}
\title{ Coercing to bitwhich }
\description{
  Functions to coerce double, integer
}
\usage{
as.bitwhich(x, \dots)
\method{as.bitwhich}{bitwhich}(x, \dots)
\method{as.bitwhich}{ri}(x, \dots)
\method{as.bitwhich}{which}(x, maxindex, \dots)
\method{as.bitwhich}{integer}(x, \dots)
\method{as.bitwhich}{double}(x, \dots)
\method{as.bitwhich}{logical}(x, \dots)
\method{as.bitwhich}{bit}(x, range=NULL, \dots)
}
\arguments{
  \item{x}{ An object of class 'bitwhich', 'integer', 'logical' or 'bit' or an integer vector as resulting from 'which' }
  \item{maxindex}{ the length of the new bitwhich vector }
  \item{range}{ NULL or a vector with two elements indicating first and last position to be analyzed }
  \item{\dots}{ further arguments }
}
\value{
  a value of class \code{\link{bitwhich}}
}
\author{ Jens Oehlschlägel }
\seealso{ \code{\link{bitwhich}}, \code{\link{as.bit}} }
\examples{
 as.bitwhich(c(FALSE, FALSE, FALSE))
 as.bitwhich(c(FALSE, FALSE, TRUE))
 as.bitwhich(c(FALSE, TRUE, TRUE))
 as.bitwhich(c(TRUE, TRUE, TRUE))
}
\keyword{ classes }
\keyword{ logic }
