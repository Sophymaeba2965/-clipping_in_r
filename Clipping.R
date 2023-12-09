library(tidyverse)
library(sf)
library(janitor)
library(tigris)

oregon_sf <- counties(state = "OR") %>% 
  clean_names()

oregon_hospitals <- read_csv("C:\\Users\\ADMIN\\Downloads\\creating-maps-with-R-2825608-04_05b\\creating-maps-with-R-2825608-04_05b\\04_05b\\data\\oregon-hospital-locations.csv")

oregon_hospitals <- oregon_hospitals %>% 
  st_as_sf(coords = c("long", "lat"), crs = 4326)


ggplot() +
  geom_sf(data = oregon_sf,
          fill = "darkolivegreen3",
          color = "white") +
  geom_sf(data = oregon_hospitals,
          color = "darkblue") +
  labs(title = "Hospital locations in Oregon") +
  theme_void()

bbox_Multnomah <- oregon_sf %>%
  filter(name == "Multnomah") %>%
  st_bbox() %>%
  as.list()

ggplot() +
  geom_sf(data = oregon_sf,
          fill = "darkolivegreen3",
          color = "white") +
  geom_sf(data = oregon_hospitals,
          color = "darkblue") +
  labs(title = "Hospital locations in Oregon") +
  coord_sf(xlim = c(bbox_Multnomah$xmin, bbox_Multnomah$xmax),
           ylim = c(bbox_Multnomah$ymin,bbox_Multnomah$ymax))+
  theme_void()


