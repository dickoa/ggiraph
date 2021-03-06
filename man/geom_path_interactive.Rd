% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_path_interactive.R
\name{geom_path_interactive}
\alias{geom_path_interactive}
\alias{geom_line_interactive}
\title{interactive observations connections}
\usage{
geom_path_interactive(mapping = NULL, data = NULL, stat = "identity",
  position = "identity", lineend = "butt", linejoin = "round",
  linemitre = 1, na.rm = FALSE, arrow = NULL, show.legend = NA,
  inherit.aes = TRUE, ...)

geom_line_interactive(mapping = NULL, data = NULL, stat = "identity",
  position = "identity", na.rm = FALSE, show.legend = NA,
  inherit.aes = TRUE, ...)
}
\arguments{
\item{mapping}{The aesthetic mapping, see \code{\link[ggplot2]{geom_point}}.}

\item{data}{A data frame, see \code{\link[ggplot2]{geom_point}}.}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string, see \code{\link[ggplot2]{geom_point}}.}

\item{position}{Postion adjustment, see \code{\link[ggplot2]{geom_point}}.}

\item{lineend}{Line end style (round, butt, square)}

\item{linejoin}{Line join style (round, mitre, bevel)}

\item{linemitre}{Line mitre limit (number greater than 1)}

\item{na.rm}{See \code{\link[ggplot2]{geom_point}}.}

\item{arrow}{Arrow specification, as created by \link[grid]{arrow}}

\item{show.legend}{See \code{\link[ggplot2]{geom_point}}.}

\item{inherit.aes}{See \code{\link[ggplot2]{geom_point}}.}

\item{...}{other arguments passed on to layer. See \code{\link[ggplot2]{geom_point}}.}
}
\description{
These geometries are based on \code{\link[ggplot2]{geom_path}} and
\code{\link[ggplot2]{geom_line}}.
See the documentation for those functions for more details.
}
\examples{
# add interactive paths to a ggplot -------
library(ggplot2)
# geom_line_interactive example -----
if( requireNamespace("dplyr", quietly = TRUE)){
  gg <- ggplot(economics_long,
    aes(date, value01, colour = variable, tooltip = variable, data_id = variable)) +
    geom_line_interactive(size = .75)
  ggiraph(code = {print(gg)}, hover_css = "stroke:red;")
}

# create datasets -----
id = paste0("id", 1:10)
data = expand.grid(list(
	variable = c("2000", "2005", "2010", "2015"),
	id = id
	)
)
groups = sample(LETTERS[1:3], size = length(id), replace = TRUE)
data$group = groups[match(data$id, id)]
data$value = runif(n = nrow(data))
data$tooltip = paste0('line ', data$id )
data$onclick = paste0("alert(\\"", data$id, "\\")" )

cols = c("orange", "orange1", "orange2", "navajowhite4", "navy")
dataset2 <- data.frame(x = rep(1:20, 5),
		y = rnorm(100, 5, .2) + rep(1:5, each=20),
		z = rep(1:20, 5),
		grp = factor(rep(1:5, each=20)),
		color = factor(rep(1:5, each=20)),
		label = rep(paste0( "id ", 1:5 ), each=20),
		onclick = paste0(
		  "alert(\\"",
		  sample(letters, 100, replace = TRUE),
		  "\\")" )
)


# plots ---
gg_path_1 = ggplot(data, aes(variable, value, group = id,
		colour = group, tooltip = tooltip, onclick = onclick, data_id = id)) +
	geom_path_interactive(alpha = 0.5)

gg_path_2 = ggplot(data, aes(variable, value, group = id, data_id = id,
		tooltip = tooltip)) +
	geom_path_interactive(alpha = 0.5) +
	facet_wrap( ~ group )

gg_path_3 = ggplot(dataset2) +
	geom_path_interactive(aes(x, y, group=grp, data_id = label,
		color = color, tooltip = label, onclick = onclick), size = 1 )

# ggiraph widgets ---
ggiraph(code = {print(gg_path_1)}, hover_css = "stroke-width:3px;")
ggiraph(code = {print(gg_path_2)}, hover_css = "stroke:orange;stroke-width:3px;")
ggiraph(code = {print(gg_path_3)}, hover_css = "stroke-width:10px;")

}
\seealso{
\code{\link{ggiraph}}
}
