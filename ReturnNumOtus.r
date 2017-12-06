
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