# 获取股票原始数据
stock <- function (code){
  file_name <- paste('./input/', code, '.txt', sep='')

  if(!file.exists(file_name)){
    print(paste(file_name, 'is not exists'));
  }else{
    file_data <- read.csv(file_name, header=F);
    file_data <- file_data[-c(1, 2, nrow(file_data)),];

    data.frame(
      date=as.Date(file_data[,1]),
      open=file_data[,2],
      high=file_data[,3],
      low=file_data[,4],
      close=file_data[,5],
      volume=file_data[,6],
      turnover=file_data[,7]);
  }
}
