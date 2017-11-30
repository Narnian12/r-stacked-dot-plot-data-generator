---
title: "RMarkdown Analysis with Defaults to Generate Stacked Dot Plots"
author: "Peter Sun"
output:
  pdf_document: default
---
---
geometry: margin = 1cm
---

```{r global.options, include = FALSE}
knitr::opts_chunk$set(
    cache       = TRUE,     # if TRUE knitr will cache the results to reuse in future knits
    fig.align   = 'center', # how to align graphics in the final doc. 'left', 'right', 'center'
    warning     = FALSE)    # if FALSE knitr will not display any warning messages in the final document
```

```{r set-options, echo=FALSE}
options(width = 200)
```

```{r include = FALSE}
# Add in necessary libraries and sem
library(vegan)
library(mvabund)
library(gplots)
library(RColorBrewer)
library(MASS)
library(psych)
library(plyr)
library(tidyr)
library(ggplot2)
library(lattice)
library(latticeExtra)

sem <- function(x) { sqrt(var(x, na.rm = TRUE) / length(na.omit(x))) }
```

```{r engine = 'Rcpp', include = FALSE}
#include <Rcpp.h>
#include <string>
#include <vector>
#include <utility>
#include <iostream>

using namespace Rcpp;

// This converts the Otu####Order### to ####OtuOrder##
// [[Rcpp::export]]
std::string OtuConvert(std::string otuNum, int order, std::string otuTax) {
  // Erase "Otu" from the string and replace to the end with string-converted order
  otuNum.erase(0, 3);
  int incr = 0;
  for (unsigned int i = 0; i < otuNum.size(); ++i) {
    if (otuNum[i] == '0') {
      ++incr;
    }
    else {
      break;
    }
  }
  // Deletes the unnecessary 0's
  otuNum.erase(0, incr);
  otuNum = otuNum + "Otu" + std::to_string(order) + ":" + otuTax;
  return otuNum;
}
// ~~~
```