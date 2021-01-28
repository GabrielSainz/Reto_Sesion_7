# Reto 2. Extracción de tablas en un HTML ----

# Ahora es momento de realizar la extracción de una tabla desde un html, realiza 
# este reto desde tu RStudio Desktop.

#De la siguiente dirección donde se muestran los sueldos para Data Scientists
# (https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm),
# realiza las siguientes acciones:
      
# - Extraer la tabla del HTML

library(rvest)

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file<-read_html(theurl)

tables<-html_nodes(file, "table")
# Hay que analizar 'tables' para determinar cual es la posición en la lista que contiene la tabla, en este caso es la no. 4 

table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   # Quitamos NA´s que meten filas extras y convertimos la lista en un data frame para su manipulación con R

str(table)  # Vemos la naturaleza de las variables


# - Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea
#   número), para dejar solamente la cantidad mensual (Hint: la función gsub podría
#   ser de utilidad)

a <- gsub("MXN","",table$Sueldo)
a <- gsub("[^[:alnum:][:blank:]?]", "", a)
a <- gsub("mes", "", a)

# - Asignar ésta columna como tipo numérico para poder realizar operaciones con ella

a <- as.numeric(a)
table$Sueldo <- a

# Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y la que 
# menos paga?

#Removiendo caracteres inncesarios
b <- gsub("Sueldos para Data Scientist en ", "", table$Cargo)
table$Cargo <-b

# Maximo sueldo
table %>% filter(Sueldo == max(table$Sueldo))

# max.sueldo <- which.max(table$Sueldo)
# table[max.sueldo,]

# Minimo sueldo

table %>% filter(Sueldo == min(table$Sueldo))

# min.sueldo <- which.min(table$Sueldo)
# table[min.sueldo,]
