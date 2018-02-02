
<!-- README.md is generated from README.Rmd. Please edit that file -->

# earthquakes

The earthquakes package is created for the Mastering Software
Development in R capstone from coursera.

This capstone project will be centered around a dataset obtained from
the U.S. National Oceanographic and Atmospheric Administration (NOAA) on
significant earthquakes around the world. This dataset contains
information about 5,933 earthquakes over an approximately 4,000 year
time span.

The overall goal of the capstone project is to integrate the skills you
have developed over the courses in this Specialization and to build a
software package that can be used to work with the NOAA Significant
Earthquakes dataset. This dataset has a substantial amount of
information embedded in it that may not be immediately accessible to
people without knowledge of the intimate details of the dataset or of R.
Your job is to provide the tools for processing and visualizing the data
so that others may extract some use out of the information embedded
within.

The ultimate goal of the capstone is to build an R package that will
contain features and will satisfy a number of requirements that will be
laid out in the subsequent Modules. You may want to begin organizing
your package and insert various features as you go through the capstone
project.

Dataset

  - [NOAA Significant Earthquake
    Database](https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1)

## Installation

You can install earthquakes from github with:

``` r
# install.packages("devtools")
devtools::install_github("raggaraluz/mastering_r_capstone")
```

## Example

### Downloading data

Data can be downloaded from NOAA Significant Earthquake Database as TSV
and converted to a data frame:

``` r
library(readr)

location <- 'https://www.ngdc.noaa.gov/nndc/struts/results?type_0=Exact&query_0=$ID&t=101650&s=13&d=189&dfn=signif.txt'
raw <- read_tsv(location)
```

Then, the dataframe can be cleaned using the earthquakes package
functions

``` r
library(earthquakes)
library(dplyr)
clean <- eq_clean_data(raw) %>%
  eq_location_clean()

knitr::kable(clean %>%
               select(DATE, LATITUDE, LONGITUDE, LOCATION_NAME, EQ_PRIMARY) %>%
               tail)
```

| DATE       | LATITUDE | LONGITUDE | LOCATION\_NAME | EQ\_PRIMARY |
| :--------- | -------: | --------: | :------------- | ----------: |
| 2018-01-10 |   17.469 |  \-83.520 | Honduras       |         7.6 |
| 2018-01-11 |   33.764 |    45.749 | Kermanshah     |         5.5 |
| 2018-01-14 | \-15.776 |  \-74.744 | Arequipa       |         7.1 |
| 2018-01-23 |  \-7.196 |   105.918 | Banten         |         6.0 |
| 2018-01-23 |   56.046 | \-149.073 | Kodiak Island  |         7.9 |
| 2018-01-31 |   36.543 |    70.816 | Baluchistan    |         6.1 |
