## TOOLS
library(sf) # reading/writing/analysis of spatial data
library(viridis) # a nice color palette
library(measurements) # for converting measurements (DMS to DD or UTM)
library(mapview) # interactive maps
library(tmap) # good mapping package mostly for static chloropleth style maps
library(ggspatial) # for adding scale bar/north arrow and basemaps
library(ggrepel) # labeling ggplot figures
library(ggforce) # amazing cool package for labeling and fussing 
library(cowplot) ## MOOOOOOO!! for plotting multiple plots

## DATA
library(tigris) # ROAD/CENSU DATA, see also the "tidycensus" package
library(USAboundaries) # great package for getting state/county boundaries
library(sharpshootR)  # CDEC.snow.courses, CDECquery, CDECsnowQuery
