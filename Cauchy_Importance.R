#Without Importance Sampling (integration starting from 4 to infinity)
integrate(dnorm, mean=0, sd=1,4, Inf)$value

#Importance sampling Monte Carlo
Y_big <- c()
for (i in 1:100){
  w <- rcauchy(100)
  f <- function(X) 1/(sqrt(2*pi))*exp(-0.5*(X^2))
  # x_pre <- (rexp(1000,rate=0.5))
  # x_pre <- x_pre[x_pre>4]
  # X <- x_pre[1:100]
  X <- runif(100,4,1000)
  Y <- w*f(X)/(sum(w))
  sum_Y  = as.numeric(sum(Y))
  Y_big<-c(Y_big,sum_Y)}

c(mean(Y_big),var(Y_big))