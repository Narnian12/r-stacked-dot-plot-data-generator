# R-Stacked-Dot-Plot-Data-Generator
Contains functions used to reformat MiSeq SOP data into a version usable for ggplots stacked dot plots.

All of the code here requires that your data goes through the MiSeq SOP pipeline (https://www.mothur.org/wiki/MiSeq_SOP).

# Generating Stacked Dot Plots for Organs by Day

## SDPDataGen() Function

```r
SDPDataGen(ind_sample_grep, sample_ordering, otu.good.norm_in, otu.good.taxonomy_in)
```

The R code will have an RME for more specific information on variable specifications, but we will go through an example to clarify the function usage.

### Example
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

# The variable that holds the result from SDPDataGen()
cecum_d0_ggdata <- SDPDataGen(cecum_d0, cecum_d0.order, otu.good.norm, otu.good.taxonomy)
```

## GGPlotGen() Function

```r
GGPlotGen(stacked_data_in, ggtitle_in)
```

This function should be used *immediately* after finishing the **SDPDataGen()** function

### Example

```r
cecum_d0_ggplot <- GGPlotGen(cecum_d0_ggdata, "Stacked Dot Plot of Cecum Day 0 Rank Abundances")
```

# Generating Stacked Dot Plots of Number of Otus per Sample per Day

## GenerateNumOtus() Function

```r
GenerateNumOtus(sample_vec, sample_order_vec, day_vec_in, samples_per_day_vec_in, otu.good.norm_in)
```

