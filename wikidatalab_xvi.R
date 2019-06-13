# install.packages('readxl')
# install.packages('tidyverse')
  
library(dplyr)
museus <- readxl::read_xlsx(path = "~/Downloads/Wikidata Lab XVI - Atividades.xlsx", sheet = 1)

museus <- dplyr::select(museus, c('item', 'itemLabel','ID Museus.br'))

museusbr <- readxl::read_xlsx(path = "~/Downloads/Wikidata Lab XVI - Atividades.xlsx", sheet = 2)

museusbr  <- museusbr %>% select(c('Id', "Nome", "Site"))

bla <-left_join(museus, museusbr, by = (c("itemLabel" = "Nome")))

failed_museus <- bla[is.na(bla$Id),]

ble <-right_join(museus, museusbr, by = (c("itemLabel" = "Nome")))

failed_museusbr <-  ble[is.na(ble$item),]

any(failed_museusbr$itemLabel %in% failed_museus)

library(data.table)
#install.packages("fuzzyjoin")
library(dplyr)
library(fuzzyjoin)
data(misspellings)
misspellings
library(qdapDictionaries)
words <- tbl_df(DICTIONARY)

set.seed(2016)
sub_misspellings <- misspellings %>% sample_n(1000)
colnames(failed_museus)[3] <- 'id'
colnames(failed_museusbr)[3] <- 'id'


joined <- failed_museus %>%   stringdist_inner_join(failed_museusbr, by = "itemLabel", max_dist = 1)
joined

joined <- joined %>% select("item.x", "itemLabel.x", "itemLabel.y", "Id.y")

joined

quickstatem