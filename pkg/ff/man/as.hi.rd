\name{as.hi}
\alias{as.hi}
\alias{as.hi.hi}
\alias{as.hi.ri}
\alias{as.hi.bit}
\alias{as.hi.bitwhich}
\alias{as.hi.call}
\alias{as.hi.name}
\alias{as.hi.(}
\alias{as.hi.integer}
\alias{as.hi.which}
\alias{as.hi.double}
\alias{as.hi.logical}
\alias{as.hi.character}
\alias{as.hi.matrix}
\title{ Hybrid Index, coercion to }
\description{
  The generic \command{as.hi} and its methods are the main (internal) means for preprocessing index information into the hybrid index class \code{\link{hi}}.
  Usually \command{as.hi} is called transparently from \code{\link{[.ff}}. However, you can explicitely do the index-preprocessing,
  store the Hybrid Index \code{\link{hi}}, and use the \code{hi} for subscripting.
}
\usage{
as.hi(x, \dots)
\method{as.hi}{hi}(x, \dots)
\method{as.hi}{ri}(x, maxindex = length(x), \dots)
\method{as.hi}{bit}(x, range = NULL, maxindex = length(x), vw = NULL, dim = NULL, dimorder = NULL, \dots)
\method{as.hi}{bitwhich}(x, maxindex = length(x), \dots)
\method{as.hi}{call}(x, maxindex = NA, dim = NULL, dimorder = NULL, vw = NULL, vw.convert = TRUE, pack = TRUE, envir = parent.frame(), \dots)
\method{as.hi}{name}(x, envir = parent.frame(), \dots)
%\method{as.hi}{(}(x, envir = parent.frame(), \dots)
\method{as.hi}{integer}(x, maxindex = NA, dim = NULL, dimorder = NULL, symmetric = FALSE, fixdiag = NULL, vw = NULL, vw.convert = TRUE, dimorder.convert  = TRUE, pack = TRUE, NAs = NULL, \dots)
\method{as.hi}{which}(x, \dots)
\method{as.hi}{double}(x, \dots)
\method{as.hi}{logical}(x, maxindex = NA, dim = NULL, vw = NULL, pack = TRUE, \dots)
\method{as.hi}{character}(x, names, vw = NULL, vw.convert = TRUE, \dots)
\method{as.hi}{matrix}(x, dim, dimorder = NULL, symmetric = FALSE, fixdiag = NULL, vw = NULL, pack = TRUE, \dots)
}
\arguments{
  \item{x}{ an appropriate object of the class for which we dispatched }
  \item{envir}{ the environment in which to evaluate components of the index expression }
  \item{maxindex}{ maximum positive indexposition \code{maxindex}, is needed with negative indices, if vw or dim is given, maxindex is calculated automatically }
  \item{names}{ the \code{\link[ff:names.ff]{names}} of the indexed vector for character indexing }
  \item{dim}{ the \code{\link[ff:dim.ff]{dim}} of the indexed matrix to be stored within the \code{\link{hi}} object }
  \item{dimorder}{ the \code{\link{dimorder}} of the indexed matrix to be stored within the \code{\link{hi}} object, may convert interpretation of \code{x} }
  \item{symmetric}{ the \code{\link{symmetric}} of the indexed matrix to be stored within the \code{\link{hi}} object }
  \item{fixdiag}{ the \code{\link{fixdiag}} of the indexed matrix to be stored within the \code{\link{hi}} object }
  \item{vw}{ the virtual window \code{\link{vw}} of the indexed vector or matrix to be stored within the \code{\link{hi}} object, see details }
  \item{vw.convert}{ FALSE to prevent doubly virtual window conversion, this is needed for some internal calls that have done the virtual window conversion already, see details }
  \item{dimorder.convert}{ FALSE to prevent doubly dimorder conversion, this is needed for some internal calls that have done the dimorder conversion already, see details }
  \item{NAs}{ a vector of NA positions to be stored \code{\link[bit]{rlepack}ed}, not fully supported yet }
  \item{pack}{ FALSE to prevent \code{\link[bit]{rlepack}ing} }
  \item{range}{ NULL or a vector with two elements indicating first and last position to be converted from 'bit' to 'hi' }
  \item{\dots}{ further argument passed from generic to method or from wrapper method to \code{as.hi.integer} }
}
\details{
  The generic dispatches appropriately, \code{as.hi.hi} returns an \code{\link{hi}} object unchanged,
  \code{as.hi.call} tries to \code{\link{hiparse}} instead of evaluate its input in order to save RAM.
  If parsing fails it evaluates the index expression and dispatches again to one of the other methods.
  \code{as.hi.name} and \code{as.hi.(} are wrappers to \code{as.hi.call}.
  \code{as.hi.integer} is the workhorse for coercing evaluated expressions
  and \code{as.hi.which} is a wrapper removing the \code{which} class attribute.
  \code{as.hi.double}, \code{as.hi.logical} and \code{as.hi.character} are also wrappers to \code{as.hi.integer},
  but note that \code{as.hi.logical} is not memory efficient because it expands \emph{all} positions and then applies logical subscripting.
  \cr
  \code{as.hi.matrix} calls \code{\link{arrayIndex2vectorIndex}} and then \code{as.hi.integer} to interpret and preprocess matrix indices.
  \cr
  If the \code{dim} and \code{dimorder} parameter indicate a non-standard dimorder (\code{\link{dimorderStandard}}), the index information in \code{x} is converted from a standard dimorder interpretation to the requested \code{\link{dimorder}}.
  \cr
  If the \code{vw} parameter is used, the index information in \code{x} is interpreted relative to the virtual window but stored relative to the abolute origin.
  Back-coercion via \code{\link{as.integer.hi}} and friends will again return the index information relative to the virtual window, thus retaining symmetry and transparency of the viurtual window to the user.
  \cr
  You can use \code{\link[ff:length.hi]{length}} to query the index length (possibly length of negative subscripts),
  \code{\link[ff:poslength.hi]{poslength}} to query the number of selected elements (even with negative subscripts),
  and \code{\link[ff:maxindex.hi]{maxindex}} to query the largest possible index position (within virtual window, if present)
  \cr
  Duplicated negative indices are removed and will not be recovered by \code{\link{as.integer.hi}}.
}
\value{
  an object of class \code{\link{hi}}
}
\author{ Jens Oehlschlägel }
\note{ Avoid changing the Hybrid Index representation, this might crash the \code{\link{[.ff}} subscripting }
\seealso{ \code{\link{hi}} for the Hybrid Index class, \code{\link{hiparse}} for parsing details, \code{\link{as.integer.hi}} for back-coercion, \code{\link{[.ff}} for ff subscripting }
\examples{
  cat("integer indexing with and without rel-packing\n")
  as.hi(1:12)
  as.hi(1:12, pack=FALSE)
  cat("if index is double, the wrapper method just converts to integer\n")
  as.hi(as.double(1:12))
  cat("if index is character, the wrapper method just converts to integer\n")
  as.hi(c("a","b","c"), names=letters)
  cat("negative index must use maxindex (or vw)\n")
  as.hi(-(1:3), maxindex=12)
  cat("logical index can use maxindex\n")
  as.hi(c(FALSE, FALSE, TRUE, TRUE))
  as.hi(c(FALSE, FALSE, TRUE, TRUE), maxindex=12)

  cat("matrix index\n")
  x <- matrix(1:12, 6)
  as.hi(rbind(c(1,1), c(1,2), c(2,1)), dim=dim(x))

  cat("first ten positions within virtual window\n")
  i <- as.hi(1:10, vw=c(10, 80, 10))
  i
  cat("back-coerce relativ to virtual window\n")
  as.integer(i)
  cat("back-coerce relativ to absolute origin\n")
  as.integer(i, vw.convert=FALSE)

  cat("parsed index expressions save index RAM\n")
    as.hi(quote(1:1000000000))
\dontrun{
  cat("compare to RAM requirement when the index experssion is evaluated\n")
    as.hi(1:1000000000)
}

cat("example of parsable index expression\n")
  a <- seq(100, 200, 20)
  as.hi(substitute(c(1:5, 4:9, a)))
  hi(c(1,4, 100),c(5,9, 200), by=c(1,1,20))

cat("example of index expression partially expanded and accepting token\n")
  as.hi(quote(1+(1:16)))  # non-supported use of brackets '(' and mathematical operators '+' expands 1:16, parsing is aborted because length>16

cat("example of index expression completely evaluated after token has been rejected\n")
  as.hi(quote(1+(1:17)))  # non-supported use of brackets '(' and mathematical operators '+' expands 1:17, parsing is aborted because length>16
}
\keyword{ IO }
\keyword{ data }
