setwd("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/AT-insert/")
getwd()

library("htmltools")
library("formattable")

###############
# Formattable #
###############

Supl_table_format = read.table(file = "AT-insert-in-species.txt", sep = "\t", header = T)
Ft_Supl_table = formattable(Supl_table_format, align = c("l", "l", "l", "l", "r", "r"),
                            list('Read.count' = color_bar("#DeF7E9"), 'Insert.Count' = FALSE,
                                 `Insert` = formatter("span", 
                                                      x ~ icontext(ifelse(x == "No", "remove", "ok"), ifelse(x == "No", "No", "Yes")), 
                                                      style = x ~ style(color = ifelse(x == "No", "red", "green"))),
                                 `Insert.Percentage` = formatter("span", 
                                                                 x ~ percent(x / 100, digits = 2),
                                                                 style = x ~ style(color = ifelse(x < 0.1, "black", ifelse(x < 25, "red", ifelse(x < 75, "#FFCB15", "green")))))))
Ft_Supl_table
htmlwidgets::saveWidget(as.htmlwidget(Ft_Supl_table, width = 275), "Supl_Table01.html", selfcontained = TRUE)



`Insert` = formatter("span", 
                          x ~ icontext(ifelse(x = "No", "ok", "remove"), ifelse(x == "No", "Yes", "No")), 
                          style = x ~ style(color = ifelse(x = "No", "red", "green"))))
