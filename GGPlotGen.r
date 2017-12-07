# REQUIRES: The following variables - 
	# stacked_data_in which is the result of SDPDataGen()
	# ggtitle_in which is what you want the ggplot title to be (must be within quotations, eg "Cecum GGPlot Analysis for Day 0")
GGPlotGen <- function(stacked_data_in, ggtitle_in) {
  return(ggplot(stacked_data_in, aes(x = NumOtuOrder, y = RelAbund)) + theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + geom_count(col = "black", show.legend = F, shape = 21, size = 3) + ggtitle(ggtitle_in) + theme(plot.title = element_text(hjust = 0.5)) + xlab("NumberOtuOrder:Taxonomy") + theme(axis.text = element_text(size = 11)) + ylab("% Relative Abundance (Log Scale)") + scale_y_log10(limits = c(0.01, 100), breaks = c(0.01, 0.1, 1, 10, 100)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)))
}