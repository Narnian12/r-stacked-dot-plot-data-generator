# REQUIRES: ReturnNumOtus() function (see GitHub) and these following variables - 
  # sample_vec that contains all the individual sample indices in a predetermined order (days, ID, etc.); ie it is a numeric vector
  # sample_order_vec that contains all the individual sample's associated order, with the word "NEXT" separating them
    # EXAMPLE: If sample_vec <- rbind(sample1, sample2), then sample_order_vec <- rbind(sample1.order, "NEXT", sample2.order)
  # day_vec_in that contains all the days we have samples (e.g. day_vec_in <- c(0, 4))
  # samples_per_day_vec_in that contains the number of samples within a particular day (e.g. if day 0 had 5 samples and day 4 had 3 samples then 
    # samples_per_day_vec_in <- c(5, 3))
  # otu.good.norm_in which is otu.good.norm
# MODIFIES: None
# EFFECTS: Generates a 2-D matrix with the first column indicating the day and the 
  # second column indicating how many OTUs are present above 0.01%
GenerateNumOtus <- function(sample_vec, sample_order_vec, day_vec_in, samples_per_day_vec_in, otu.good.norm_in) {
  num_otus_vec <- matrix(nrow = length(sample_vec), ncol = 2)
  num_otus_vec_incr <- 1
  order_incr <- 1
  # Loop through each day
  for (i in 1:length(day_vec_in)) {
    # Loop through samples in each day
    for (j in 1:samples_per_day_vec_in[i]) {
      num_otus_vec[num_otus_vec_incr, 1] <- day_vec_in[i]
      for (k in order_incr:length(sample_order_vec)) {
        if (sample_order_vec[k] == "NEXT") {
          num_otus_vec[num_otus_vec_incr, 2] <- ReturnNumOtus(as.numeric(otu.good.norm_in[sample_vec[num_otus_vec_incr], sample_order_vec[order_incr:(k -1)]]))
          order_incr <- k + 1
          break
        }
        if (k == length(sample_order_vec)) {
          num_otus_vec[num_otus_vec_incr, 2] <- ReturnNumOtus(as.numeric(otu.good.norm_in[sample_vec[num_otus_vec_incr], sample_order_vec[order_incr:(k)]]))
          order_incr <- k
          break
        }
      }
      num_otus_vec_incr <- num_otus_vec_incr + 1
    }
  }
  #num_otus_vec[!rowSums(!is_finite(num_otus_vec)), ]
  write.table(num_otus_vec, file = "~/Desktop/num_otus_vec.csv", sep = "\t", quote = F, row.names = F)
  num_otus_vec <- read.table("~/Desktop/num_otus_vec.csv", sep = "\t", header = T)
  names(num_otus_vec) <- c("Day", "NumOtus")
  return(num_otus_vec)
}