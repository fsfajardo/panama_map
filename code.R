# DIRECTORY

# PACKAGES
library(leaflet)
library(tidyverse)
library(htmlwidgets)
library(dplyr)
#library(webshot)

# DATA
panama <- read.csv("data.csv", stringsAsFactors=F)
color1 <- colorFactor(palette = c("#696969","#696969","#696969","green","green","green","red","red","red","blue","blue","blue","red","blue"), 
                      levels = c("g_1","g_2","g_3","g_4","g_5","g_6","g_7","g_8","g_9","g_10","g_11","g_12","g_98","g_99"))
color2 <- colorFactor(palette = c("#696969","red","blue","#696969","red","blue","#696969","red","blue","#696969","red","blue","red","blue"), 
                      levels = c("g_1","g_2","g_3","g_4","g_5","g_6","g_7","g_8","g_9","g_10","g_11","g_12","g_98","g_99"))

# MAPS
#for (i in 18:19) { 
i=8
centro <- c(mean((panama %>% filter(pareja_aux == i&  type == "g_98"))$longitude,(panama %>% filter(pareja_aux == i&  type == "g_99"))$longitude),mean((panama %>% filter(pareja_aux == i&  type == "g_98"))$latitude,(panama %>% filter(pareja_aux == i&  type == "g_99"))$latitude))
m <- leaflet(panama %>% filter(pareja_aux == i)) %>% addProviderTiles(provider = "CartoDB.Positron") %>% 
        setView(0,0, zoom = 14)  %>%
        setMaxBounds(  lng1 = min((panama %>% filter(pareja_aux == i))$longitude),    
                       lat1 = min((panama %>% filter(pareja_aux == i))$latitude),
                       lng2 = max((panama %>% filter(pareja_aux == i))$longitude),
                       lat2 = max((panama %>% filter(pareja_aux == i))$latitude))  %>%
        addCircleMarkers(~longitude, ~latitude, popup=(panama %>% filter(pareja_aux == i))$type,
                         color=~color1(type), fillColor = ~color2(type),
                         opacity =1 , fillOpacity = 1, weight = 2,
                         radius = (panama %>% filter(pareja_aux == i))$radius,
                         label = (panama %>% filter(pareja_aux == i))$name,
                         labelOptions = labelOptions(noHide=TRUE,textOnly=TRUE,
                                                     direction="center", style = list(
                                                             "color" = "black",
                                                             "font-size" = "14px",
                                                             "border-color" = "black"))) %>%
        addLegend("bottomleft", colors= c("gray","green","red","blue"),
                  labels=c("sin cupo","cupo T y C","cupo C","cupo T"),
                  opacity = 1,title="BORDER") %>%
        addLegend("bottomright", colors= c("gray","red","blue"),
                  labels=c("no matriculado","matriculad C","matriculad C"),
                  opacity = 1,title="FILL")
m

#agrego comentario extra
