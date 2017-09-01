wk1 <- seq(as.Date("2017-09-04"),by="1 weeks",length.out=14)
all_dates <- sort(c(wk1,wk1+1,wk1+3)) ## Mon, Tues, Thurs
first_last <- as.Date(c("2017-09-05","2017-12-06"))
all_dates <- all_dates[all_dates>=first_last[1] & all_dates<=first_last[2]]
midterm <- as.Date(c("2017-10-9","2017-10-15"))
all_dates <- all_dates[all_dates<midterm[1] | all_dates>=midterm[2]]
write.csv(data.frame(date=format(all_dates,format="%a, %d %b %Y")),
          row.names=FALSE,file="dates.csv")
