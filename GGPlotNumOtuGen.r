# REQUIRES: The following variables - 
	# num_otus_vec_in which is the result of SDPDataGen()
	# ggtitle_in which is what you want the ggplot title to be (must be within quotations, eg "Stacked Dot Plot of Number of OTUs per Day in Cecum")
# MODIFIES: None
# EFFECTS: Returns ggplot of stacked dot plots for number of OTUs per sample per day (based on result of SDPDataGen())
GGPlotGen <- function(num_otus_vec_in, ggtitle_in) {
  ggplot(num_otus_vec_in, aes(x = Day, y = RelAbund)) + theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + geom_count(col = "black", show.legend = F, shape = 21, size = 3) + ggtitle(ggtitle_in) + theme(plot.title = element_text(hjust = 0.5)) + ylab("# of OTUs") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
}