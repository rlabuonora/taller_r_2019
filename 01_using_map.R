library(XML)
library(dplyr)
library(readr)
library(purrr)
library(tools)


xml_path_to_csv_path <- function(path) {
  # vector the paths a los csv -> vector de paths a los html
  # xml_path_to_csv_path(c("algo.xml", "nada.xml))
  name <- file_path_sans_ext(basename(path))
  file.path('data', 'csv', paste0(name, '.csv'))
}

convertir <- function(path) {
  xmlParse(path) %>% # abrir el archivo
    xmlToList %>%    # convertir xml a lista
    purrr::map_df(~as.vector(.x)) %>%  # convertir a data frame
    write_csv(xml_path_to_csv_path(path)) # escribir a csv con el nombre correcto
}


list.files('./data/xml/', full.names=TRUE) %>%
  purrr::walk(convertir)