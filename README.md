# R-Stacked-Dot-Plot-Data-Generator
Contains functions used to reformat MiSeq SOP data into a version usable for ggplots stacked dot plots.

All of the code here requires that your data goes through the MiSeq SOP pipeline (https://www.mothur.org/wiki/MiSeq_SOP).

# Generating Stacked Dot Plots for Organs by Day

## SDPDataGen Function

```r
SDPDataGen(ind_sample_grep, sample_ordering, otu.good.norm_in, otu.good.taxonomy_in)
```

The R code will have an RME for more specific information on variable specifications, but we will go through an example to clarify the function usage.

### Preliminary Variables
```r
# Assume it contains Cecum_D0_1, Cecum_D0_2 and Cecum_D0_3
otu.good.norm
# It's associated taxonomy table
otu.good.taxonomy 
# Samples from an organ within one day
cecum_d0 <- grep("Cecum_D0_", rownames(otu.good.norm))

# Order from the cecum day's samples
cecum_d0 <- grep("Cecum_D0", rownames(otu.good.norm))
cecum_d0.order <- names(sort(otu.good.norm[cecum_d0, ], decreasing = T))

cecum_d0_ggplot <- SDPDataGen(cecum_d0, cecum_d0.order, otu.good.norm, otu.good.taxonomy)
```
