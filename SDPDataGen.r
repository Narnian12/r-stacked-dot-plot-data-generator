# REQUIRES: These following variables -
  # ind_sample_grep that contains all the samples from an organ within a day
  # sample_ordering that contains the combined OTU ordering of all the individual samples (eg if there were three samples in feces_d0, then the sample_ordering <- feces_d0.order)
  # otu.good.norm_in which is otu.good.norm
  # otu.good.taxonomy_in which is otu.good.taxonomy
  # OtuConvert() which is an Rcpp function given in the default .R file within GitHub
# MODIFIES: None
# EFFECTS: Returns stacked_data which is a 2-D matrix with the first column containing the most-to-least abundant OTUs (up to the 50th most abundant)
  # and the second column containing the % relative abundances
SDPDataGen <- function(ind_sample_grep, sample_ordering, otu.good.norm_in, otu.good.taxonomy_in) {
  ordering <- 50
  incr <- 0
  stacked_data <- matrix(nrow = (50 * length(ind_sample_grep)), ncol = 2)
  for (i in 1:50) {
    for (j in 1:length(ind_sample_grep)) {
      stacked_data[i + incr, 1] <- OtuConvert(sample_ordering[i], ordering, as.character(otu.good.taxonomy_in[sample_ordering, 6][i]))
      stacked_data[i + incr, 2] <- otu.good.norm_in[ind_sample_grep[j], sample_ordering[i]]
      incr <- incr + 1
    }
    incr <- incr - 1
    ordering <- ordering - 1
  }
  stacked_data[!rowSums(!is.finite(stacked_data)), ]
  
  write.table(stacked_data, file = "~/Desktop/stacked_data.csv", sep = "\t", quote = F, row.names = F)
  stacked_data <- read.table("~/Desktop/stacked_data.csv", sep = "\t", header = T)
  names(stacked_data) <- c("NumOtuOrder", "RelAbund")
  stacked_data$NumOtuOrder <- factor(stacked_data$NumOtuOrder, levels = unique(as.character(stacked_data$NumOtuOrder)))
  return(stacked_data)
}