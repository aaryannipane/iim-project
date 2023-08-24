#! /usr/bin/Rscript
i=1


#######
######
######
######
#Calculating perceptual map data and updating file#######
#######
######
######
######

library(readxl)


# i_student=read_excel("E:\\downloads\\test\\test\\i_Decision Summary_adv_t.xlsx")
i_student=read_excel("./i_Decision Summary_adv_t.xlsx")
# i_student

# c_data = read_excel("E:\\downloads\\test\\test\\c_Product_Attribute_Perceptions_only.xlsx")
c_data = read_excel("./c_Product_Attribute_Perceptions_only.xlsx")
# c_data

# i_shift=read_excel("E:\\downloads\\test\\test\\i_shift_t.xlsx")
i_shift=read_excel("./i_shift_t.xlsx")
# i_shift

price =0.0834 * as.numeric(i_student$Price) - 33.383
c_data1=c_data
c_data1$Price= round(price,2)
# c_data1

prcpt_change <- function(shift,base=0){
  change=8*pnorm(as.numeric(shift),mean = as.numeric(base),sd = 3,lower.tail = TRUE)-4
  return(change)
}



c_data1$Wt.= as.numeric(c_data$Wt.)+ prcpt_change(i_shift$Weight)
c_data1$Complex.= as.numeric(c_data$Complex.)+ prcpt_change(i_shift$Complexity)
c_data1$Freq.= as.numeric(c_data$Freq.)+ prcpt_change(i_shift$Frequency)
c_data1$Power= as.numeric(c_data$Power)+ prcpt_change(i_shift$Power)
c_data1$Speed= as.numeric(c_data$Speed)+ prcpt_change(i_shift$Speed)

# c_data1
library(openxlsx)
wb <- loadWorkbook(paste0("./calculated_tables_t",".xlsx"))
writeData(wb, sheet = "c_Product Attribute Perceptions", c_data1, colNames = T)
saveWorkbook(wb,paste0("./calculated_tables_t",".xlsx"),overwrite = T)
# c_data1