% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fun.DateFormat.R
\name{fun.DateTimeFormat}
\alias{fun.DateTimeFormat}
\title{Date Format (wrapper)}
\usage{
fun.DateTimeFormat(fun.DateTime, fun.dt.Type)
}
\arguments{
\item{fun.DateTime}{Date, Time, or DateTime data}

\item{fun.dt.Type}{type of input; date, time, or date}
}
\value{
Returns a text string representing the date/time format of the input
fun.DateTime.  Wrapper function for fun.dt.Type2().
}
\description{
Input a date/time string and output R date/time *format*. The format can then
be used to convert to a different format.  Determine Date and Time *format*
from input (single record) using Perl regular expressions.
Perl Code prepared by Ann Roseberry Lincoln
Not all possible formats recognized but the most common are accepted.
If AM/PM is left off them assume 24 hr time.
}
\examples{
#Not intended to be accessed indepedently.
#format of current date
fun.DateTimeFormat(Sys.Date(),"date")
fun.DateTimeFormat(Sys.time(),"datetime")
}
\keyword{#date,}
\keyword{datetime,}
\keyword{format}
\keyword{internal}
\keyword{time,}
