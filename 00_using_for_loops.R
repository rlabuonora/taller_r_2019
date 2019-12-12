library(XML)
library(tools)
library(tidyverse)
# para cada archivo en el directorio

for (f in list.files("./data/xml", full.names = TRUE)) {
  f <- xmlParse(f)
}


# Paso 1: Agarro el primer archivo

f <- list.files("./data/xml", full.names = TRUE)[1]

foo <- xmlParse(f)
typeof(foo) # externalptr
str(foo)
# Ahora tengo una lista
baz <- xmlToList(foo)
typeof(baz)
str(baz)
#View(baz)
length(baz)

# Ahora tengo algo parecido a lo que busco
baz[[10]]
baz[[10]][[1]]
baz[[10]][[2]]


# Itero en los elementos de la lista y lo acumulo en un data.frame
result <- data.frame()
for (linea in baz) {
  vec <- data.frame(c(linea[1], linea[2]))
  result <- rbind(result, vec)
}


# poniendo todo junto:
for (f in list.files("./data/xml", full.names = TRUE)) {
  foo <- xmlParse(f)
  baz <- xmlToList(foo)
  
  # Iteracion anidada:
  resultado <- data.frame()
  for (linea in baz) {
    vec <- data.frame(c(linea[1], linea[2]))
    resultado <- rbind(resultado, vec)
  }
  # salvar el resultado
  name <- file_path_sans_ext(basename(f))
  output <- file.path('data', 'csv', paste0(name, '.csv'))
  write_csv(resultado, output)
}

