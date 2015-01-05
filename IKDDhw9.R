#read data

remove()
data<-read.table(url("http://www.datagarage.io/api/5488687d9cbc60e12d300ba5"))
o<-seq(2, 4000, by=2)
d_c<-as.character(data[o, ])
p_m<-sapply(strsplit(d_c[], ""), function(d_c) which(d_c == ":"))
data<-data.frame(X=as.double(substr(d_c,p_m[2,]+1, 38)), Y=as.double(substr(d_c,p_m[1,]+1, 17)))

#predict data

attach(data)
l=loess(y~x,span=0.2,degree=2,data.frame(x=X,y=Y))
YY=predict(l,data.frame(x=X))
XX=sort(X)
p=predict(l,data.frame(x=XX))

#print graph and Y data

print(YY)
plot(data)
lines(XX,p,col="red")

#output graph and Y value to file

jpeg("graph.jpg")
plot(data)
lines(XX,p,col="red")
dev.off()
write.table(YY, file="predictY.txt")

detach(data)