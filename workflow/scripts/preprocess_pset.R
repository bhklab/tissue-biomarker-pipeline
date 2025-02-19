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
  # Saves the workspace to "resources/"preprocess_pset"
  file.path("resources", paste0(snakemake@rule, WILDCARDS$pset_NAME, ".RData")) |> 
    save.image()
}else{
  # If the snakemake object does not exist, load the workspace
  file.path("resources", paste0("preprocess_pset", WILDCARDS$pset_NAME, ".RData")) |>
    load()
}
options(warn=-1)



# Copy the input file to the output file
file.copy(INPUT[["pset"]], OUTPUT[["pset"]], overwrite = TRUE)