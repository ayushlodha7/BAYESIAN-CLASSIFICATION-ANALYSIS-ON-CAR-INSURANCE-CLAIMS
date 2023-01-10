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
df <- df[,c("AGE","INCOME","TRAVTIME","BLUEBOOK","CAR_AGE","YOJ","TGT_CLAIM_FLAG")]
summary(df)

for (i in 1:6) {
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
(reg_formula <- formula(paste("TGT_CLAIM_FLAG ~", paste(names(train_Data)[1:6], collapse = " + "))))

normal_prior <- normal(location =0,scale = 10)
post_norm_uni <- stan_glm(reg_formula, data = train_Data,
                 family = binomial(link = "logit"), 
                 prior = normal_prior, 
                 prior_intercept = normal_prior,
                 QR=TRUE,
                 chain=3,
                 iter=50000,
                 warmup=10000,
                 thin = 5,
                 cores = 8)

summary(post_norm_uni)
prior_summary(post_norm_uni)

pplot<-plot(post_norm_uni, "areas", prob = 0.95, prob_outer = 1)
pplot+ geom_vline(xintercept = 0)

mcmc_dens_overlay(post_norm_uni)
mcmc_trace(post_norm_uni)
plot(post_norm_uni,"acf_bar")


classification_summary(model = post_norm_uni,data = train_Data,cutoff = 0.5)
classification_summary(model = post_norm_uni,data = test_Data,cutoff = 0.5)

pp_check(post_norm_uni)
pp_check(post_norm_uni,plotfun = "hist",nreps=5)
pp_check(post_norm_uni, plotfun = "error_binned")

