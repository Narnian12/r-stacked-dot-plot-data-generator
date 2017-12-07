# REQUIRES: otuVec which is as.numeric(otu.good.norm[sample_id, order]) where:
  # sample_id = the specific index of the sample within otu.good.norm to be analyzed
  # order = the specific sample's order
  # e.g. if my specific sample is balb_2l_feces_d0 and its order is balb_2l_feces_d0.order,
    # the variable would be as.numeric(otu.good.norm[balb_2l_feces_d0, balb_2l_feces_d0.order])
  # NOTE - ReturnNumOtus() is ONLY used within GenerateNumOtus(), so you will not need to worry
    # about sample_id and order
# MODIFIES: None
# EFFECTS: Returns the number of OTUs within the specific sample that has a higher relative abundance than 0.01%
ReturnNumOtus <- function(otuVec) {
  numOtus <- 0
  for (k_in in 1:length(otuVec)) {
    if (!is.na(otuVec[k_in]) && otuVec[k_in] > 0.01) {
      numOtus <- numOtus + 1
    }
    else {
      break
    }
  }
  return(numOtus)
}