library(tidyverse)
library(sf)

df <- read_csv("data/data.csv", col_names = c("id_depto", "depto", "n", "x")) %>% 
  select(1:3)

# Cargar mapa
mapa_deptos <- st_read('shps/ine_depto.shp')

# Estructura
str(mapa_deptos)

# Plotear
plot(st_geometry(mapa_deptos))


mapa_deptos <- mapa_deptos %>% 
  left_join(df, by=c("DEPTO"="id_depto"))


# tmap
# https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html

library(tmap)

mapa <- tm_shape(mapa_deptos) +
  tm_borders() + 
  tm_polygons("n")

