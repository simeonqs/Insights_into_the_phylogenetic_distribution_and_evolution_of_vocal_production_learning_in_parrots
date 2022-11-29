# Overview

This repo is associated with the following article: 

```
reference
```

**NOTE**: This repo is under development. 

------------------------------------------------
# Requirements

R version 4.2.0 or later. Earlier versions might work if you replace the `|>` function with `%>%`.

Required packages are installed and loaded in each script. However, some need manual installation:

* To run the Stan models *Stan* needs to be installed. This is not an R package, but *Stan* can be run from R. For installation see: https://mc-stan.org/users/interfaces/. 

* To run *Stan* from R *cmdstanr* is required. It can be installed from CRAN, but you need to finish the set-up, see: https://mc-stan.org/cmdstanr/. 

------------------------------------------------
# Workflow

Make sure your working directory is the main repo folder. This is automatically the case if you open the `parrot_mimicry.Rproj` file and run everything from there.

All steps can be sourced individually using the source botton in RStudio or by just running all the lines.

-----------------------------------------------
# Meta data

All analysis related files are in `ANALYSIS`.

All scripts are in `ANALYSIS/CODE`:
  
- `functions/taxize.data.frame.R` function to standardise taxonomy

- `models` contains all the Stan models
	
	- `body_to_nr_unique.stan` total effect of body size on number of unique mimics
	
	- `body_to_presence.stan` total effect of body size on the presence of mimicry
	
	- `brain_to_nr_unique.stan` total effect of relative brain size on number of unique mimics
	
	- `brain_to_presence.stan` total effect of relative brain size on the presence of mimicry
	
	- `longevity_to_nr_unique.stan` total effect of life expectancy on number of unique mimics
	
	- `longevity_to_presence.stan` total effect of life expectancy on the presence of mimicry
	
	- `phylo_signal.stan` phylogenetic signal on the presence of mimicry
	
	- `sociality_to_nr_unique.stan` total effect of sociality on number of unique mimics
	
	- `sociality_to_presence.stan` total effect of sociality on the presence of mimicry
	
- `00_load_data.R` loads the raw data, cleans it and saves several RData in `RESULTS` objects for later steps

- `01_ancestral_state_reconstruction.R` runs ancestral state reconstruction and plots several phylogenetic trees

- `02_model_presence.R` runs the model for presence of mimicry

- `03_plot_presence.R` plots the results of step 02

- `04_model_nr_unique.R` runs the models for number of unique mimics

- `05_plot_nr_unique.R` plots the results of step 04

- `06_model_nr_words.R` runs the models for number of unique words

- `07_plot_nr_words.R` plots the results for step 06

- `08_model_checks.R` checks the Rhat values for all models

- `DAG.R` creates the directed acyclic graph for the paper
  
All data is in `ANALYSIS/DATA`:

- `AFR`, `body weight`, `brain size` and `longevity` are downloaded from Smeele et al. (2022), see <https://github.com/simeonqs/Coevolution_of_relative_brain_size_and_life_expectancy_in_parrots> for meta data

- `IUCN translation list 01 _ manual added.csv` expanded version of the taxonomic translation table from Smeele et al. (2022)

	- `original_species` species names used in data bases and zoos
	- `species` the standardised IUCN species-level name
	- `order` the standardised IUCN order-level name
	- `source` how the IUCN taxonomy was found: `exact_match` - found exactly the same on IUCN, `fuzzy_match` - found with few characters shuffled on ICUN, `manual_avibase` - found manually on Avibase, `synonym_match` - match to synonym listed by IUCN
	- `notes` when species not found this explains why - often a species is a hybrid or is extinct
	
- `5.ParrotSupertree.tre` phylogenetic tree

- `parrot_vocalmimic_detailed_updated_withoutfilter.xlsx` raw data with information per vide

	- **insert meta data**
	
- `parrot_vocalmimic_socioecol.xlsx` raw data with single data point per species

	- **insert meta data**

All results can be found in `ANALYSIS/RESULTS`:

- `DAG.pdf` the directed acyclic graph

- **add other results when finished**
  
Other than the `ANALYSIS` folder the main folder also contains:

- `bibliography.bib` contains all the reference in bibtex format
  
- `README.md` the file you are reading now, should explain everything you need to know

- `methods and results.Rmd` the md to compile parts of the preliminary methods and results

- `methods-and-results.docx` and `methods-and-results.pdf` compiled versions of the above

- `parrot_mimicry.Rproj` opens a new R Project from which all code can be run
  
- `.gitignore` text file that contains all paths of files/folders that should not be tracked by git

------------------------------------------------
# Session info

R version 4.2.1 (2022-06-23)

Platform: x86_64-apple-darwin17.0 (64-bit)

Running under: macOS Catalina 10.15.7

------------------------------------------------
# Maintainers and contact

Please contact Simeon Q. Smeele, <ssmeele@ab.mpg.de>, if you have any questions or suggestions. 
