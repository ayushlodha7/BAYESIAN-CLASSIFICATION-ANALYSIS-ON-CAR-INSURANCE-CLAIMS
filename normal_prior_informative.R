library(tidyverse)
library(caret)
library(GGally)
library(ggplot2)
library(corrplot)
library(bayesplot)
library(bayesrules)
theme_set(bayesplot::theme_default(base_family = "sans"))
library(rstanarm)
options(mc.cores = 2)
library(loo)
library(projpred)

df <- read.csv("df_log_preprocess.csv", header = TRUE)
df <- df[,c("AGE","INCOME","TRAVTIME","BLUEBOOK","CAR_AGE","TGT_CLAIM_FLAG")]
summary(df)

for (i in 1:5) {
  df[i] <- scale(df[i])
}

df$TGT_CLAIM_FLAG<- factor(df$TGT_CLAIM_FLAG)

sample_size = floor(0.70*nrow(df))
train_sample = sample(seq_len(nrow(df)),size = sample_size)
train_Data = df[train_sample,]
test_Data = df[-train_sample,]

summary(train_Data)
summary(test_Data)


y_test = test_Data$TGT_CLAIM_FLAG
x_test = model.matrix(TGT_CLAIM_FLAG ~ . - 1, data = test_Data)

# preparing the inputs
x_train <- model.matrix(TGT_CLAIM_FLAG ~ . - 1, data = train_Data)
y_train <- train_Data$TGT_CLAIM_FLAG
(reg_formula <- formula(paste("TGT_CLAIM_FLAG ~", paste(names(train_Data)[1:5], collapse = " + "))))

normal_prior <- normal(location =c(-0.239,-0.082,0.148,-0.180,-0.172),
                                scale = c(0.026,0.027,0.027,0.027,0.027))
post_norm_in <- stan_glm(reg_formula, data = train_Data,
                 family = binomial(link = "logit"), 
                 prior = normal_prior, 
                 QR=TRUE,
                 chain=3,
                 iter=50000,
                 warmup=10000,
                 thin = 5,
                 cores = 8)

summary(post_norm_in)
prior_summary(post_norm_in)

# pplot<-plot(post_norm_in, "areas", prob = 0.95, prob_outer = 1)
# pplot+ geom_vline(xintercept = 0)

mcmc_dens_overlay(post_norm_in)
mcmc_trace(post_norm_in)
plot(post_norm_in,"acf_bar")


classification_summary(model = post_norm_in_norm_in,data = train_Data,cutoff = 0.5)
classification_summary(model = post_norm_in,data = test_Data,cutoff = 0.5)

pp_check(post_norm_in)
pp_check(post_norm_in,plotfun = "hist",nreps=5)
pp_check(post_norm_in, plotfun = "error_binned")

