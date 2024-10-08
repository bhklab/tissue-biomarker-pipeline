library(fs)
library(PharmacoGx)
library(tidyverse)

download_dir <- path("0_download_psets")
unfiltered_psets <- dir_create("Data", "unfilteredPSets")
source(path(download_dir, "pset_names.R"))

psets <- availablePSets(canonical = TRUE) |>
  as_tibble() |>
  filter(`PSet Name` %in% pset_names)

for (pset in psets |> pull(`PSet Name`)) {
  downloadPSet(pset, saveDir = unfiltered_psets, timeout = 6000)
}
