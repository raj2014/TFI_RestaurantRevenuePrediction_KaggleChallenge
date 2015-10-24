#Author   : Rajasekhar Jetty 
#LinkedIN : https://www.linkedin.com/pub/rajasekhar-jetty/45/173/623
#set source directory to input folder with setwd() command
#Loading training data with respective classes
classes<-c("numeric","character",rep("factor",40),"numeric")
mytrain<-read.csv(file="train.csv",colClasses=classes,header=TRUE)

#Loading test data with respective classes
classes<-c("numeric","character",rep("factor",40))
mytest<-read.csv(file="test.csv",colClasses=classes,header=TRUE)

#Joining both training and test in to one full dataset
mytest$revenue<-c(rep(0,nrow(mytest))) #Setting revenue to zero
fullset<-rbind(mytrain,mytest)


#Applying uniform weighted k nearest neighbour regression and generating the output file (k-25 neighbours )
model<-knn.reg(train=fullset[c(1:137),c(4:43)],test=fullset[c(138:nrow(fullset)),c(4:43)],y=revenue,k=25,algorithm="brute")
yhat<-model$pred
yid<-fullset[c(138:nrow(fullset)),"Id"]
knn_output<-data.frame(yid,yhat)
colnames(knn_output)<-c("Id","Prediction")
write.csv(knn_output,file="knn_uniformWeight_25.csv",row.names=FALSE)