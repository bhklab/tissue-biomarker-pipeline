## ------------------- Parse Snakemake Object ------------------- ##
# Check if the "snakemake" object exists
# This snippet is run at the beginning of a snakemake run to setup the env
# Helps to load the workspace if the script is run independently or debugging
if(exists("snakemake")){
  INPUT <- snakemake@input
  OUTPUT <- snakemake@output
  WILDCARDS <- snakemake@wildcards
  THREADS <- snakemake@threads
  PARAMS <- snakemake@params

  # setup logger if log file is provided
  if(length(snakemake@log)>0) 
    sink(
      file = snakemake@log[[1]], 
      append = FALSE, 
      type = c("output", "message"), 
      split = TRUE
  )

  # Assuming that this script is named after the rule
  # Saves the workspace to "resources/"download_pset"
  file.path("resources", paste0(snakemake@rule, WILDCARDS$pset_name, ".RData")) |> 
    save.image()
}else{
  # If the snakemake object does not exist, load the workspace
  # file.path("resources", "download_pset.RData") |>
  # file.path("resources", paste0("download_pset", WILDCARDS$pset_name, ".RData")) |>
  #   load()
}

###############################################################################
# Load INPUT
###############################################################################
options(timeout = PARAMS$timeout)

PSET_NAME=WILDCARDS$pset_name


###############################################################################
# Main Script
###############################################################################
av <- PharmacoGx::availablePSets() |> data.table::as.data.table()

link <- av[`PSet Name` == PSET_NAME, Download] 

print(link)

if(!fs::dir_exists(path=dirname(OUTPUT$pset))){
  print(paste0("Creating directory: ", dirname(OUTPUT$pset)))
  fs::dir_create(path=dirname(OUTPUT$pset))
}




###############################################################################
# Save OUTPUT 
###############################################################################


download.file(
  url = link,
  destfile = OUTPUT$pset,
  mode = "wb"
)

if(!fs::file_exists(OUTPUT$pset)){
  stop("Download failed")
}

