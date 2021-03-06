% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom-timeline.R
\docType{data}
\name{GeomTimeline}
\alias{GeomTimeline}
\alias{geom_timeline}
\title{Timeline geom}
\format{An object of class \code{GeomTimeline} (inherits from \code{Geom}, \code{ggproto}) of length 8.}
\usage{
GeomTimeline

geom_timeline(mapping = NULL, data = NULL, stat = "identity",
  position = "identity", na.rm = FALSE, show.legend = NA,
  inherit.aes = TRUE, xmin = as.Date("0001-01-01"),
  xmax = as.Date("2020-01-01"), ...)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link{aes}} or
\code{\link{aes_}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{The data to be displayed in this layer. There are three
   options:

   If \code{NULL}, the default, the data is inherited from the plot
   data as specified in the call to \code{\link{ggplot}}.

   A \code{data.frame}, or other object, will override the plot
   data. All objects will be fortified to produce a data frame. See
   \code{\link{fortify}} for which variables will be created.

   A \code{function} will be called with a single argument,
   the plot data. The return value must be a \code{data.frame.}, and
   will be used as the layer data.}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string.}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{na.rm}{If \code{FALSE}, the default, missing values are removed with
a warning. If \code{TRUE}, missing values are silently removed.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link{borders}}.}

\item{xmin}{Minimum date to represent}

\item{xmax}{Maximum date to represent}

\item{...}{other arguments passed on to \code{\link{layer}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{color = "red"} or \code{size = 3}. They may also be parameters
to the paired geom/stat.}
}
\value{
Returns the geom for ggplot2 graphics
}
\description{
Timeline geom for earthquake data
}
\details{
This geom is for plotting a time line of earthquakes ranging from xmin to xmax dates
with a point for each earthquake.
Optional aesthetics include color, size, and alpha (for transparency).

some stratification in which case multiple time lines will be plotted for each
level of the factor (e.g. country).
}
\examples{
library(ggplot2)
library(lubridate)
clean <- eq_clean_data(earthquake_data_raw)
ggplot(clean, aes(x = DATE, y = COUNTRY, size=EQ_PRIMARY, fill = DEATHS)) +
    geom_timeline(alpha = 0.25, xmin = ymd('2000-01-01'), xmax = ymd('2015-12-31'))
}
\keyword{datasets}
