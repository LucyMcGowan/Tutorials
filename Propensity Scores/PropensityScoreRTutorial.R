##Get packages
install.packages("rms")
install.packages("MatchIt")
require(rms)
require(MatchIt)

##Read in data (change this filepath)
dat<-read.csv("/Users/lucymcgowan/Documents/Consulting/data.csv")

##Look at data
describe(dat)

##Look at Missingness
n<-naclus(dat)
a<-naplot(n, which=('na per var'))

##Multiple Imputation
set.seed(91690)
dat.imp<-aregImpute(~age+sex+dx_diabetes+dx_chf+smoking+race+treat,n.impute=20,nk=4,data=dat,pr=F)

##Fit propensity score model
fit<-fit.mult.impute(treat~rcs(age,3)+sex+race+smoking+dx_diabetes+dx_chf,fitter=lrm,data=dat,xtrans=dat.imp,pr=F)
fit

##Get propensity scores
dat$p<-predict(fit)

##Plot propensity scores
p1<-hist(dat$p[dat$treat==1])
p2<-hist(dat$p[dat$treat==0])
plot(p1,col=rgb(0,0,1,1/4),ylim=c(0,150),xlim=c(-4,4),main="Propensity Score Distribution", xlab="Propensity Score (logit)")
plot(p2,col=rgb(1,0,0,1/4),add=T)

##Matching
prop<-data.frame(id=dat$id,treat=dat$treat,p=dat$p)
match<-matchit(treat~p,data=prop,method="nearest",caliper=.2)
summary(match)
m.dat<-match.data(match)
m.dat<-dat[dat$id %in% m.dat$id,]

##Make a pretty table 1 (this will print latex code)
vars<-Cs(age,race,sex,smoking,dx_diabetes,dx_chf)
summByDx<-summaryM(as.formula(paste(paste(vars,collapse="+"),"~ treat")),data=dat,overall=T)
summByDx2<-summaryM(as.formula(paste(paste(vars,collapse="+"),"~ treat")),data=m.dat,overall=T)
latex(summByDx,file="",center="centering",what = "%",where="H"
,caption="Pre-Matching Descriptive Statistics")
latex(summByDx2,file="",center="centering",what = "%",where="H"
,caption="Post-Matching Descriptive Statistics")

##To look at the tables without latex:
summByDx
summByDx2

##plot post matching propensity scores
p1<-hist(m.dat$p[dat$treat==1])
p2<-hist(m.dat$p[dat$treat==0])
plot(p1,col=rgb(0,0,1,1/4),ylim=c(0,150),xlim=c(-4,4),main="Post-Matching Propensity Score Distribution", xlab="Propensity Score (logit)")
plot(p2,col=rgb(1,0,0,1/4),add=T)