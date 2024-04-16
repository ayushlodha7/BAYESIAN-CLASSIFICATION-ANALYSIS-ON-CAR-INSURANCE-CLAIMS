# Car Insurance Claim Approval: Bayesian Statistical Analysis

## Overview
This repository contains the analysis of car insurance claim data to determine whether claims should be approved. The analysis employs Bayesian statistical methods to handle the uncertainty and incorporates various models to predict claim approval. 

## Table of Contents
- [Project Description](#project-description)
- [Dataset](#dataset)
- [Preprocessing Steps](#preprocessing-steps)
- [Models](#models)
- [Results](#results)
- [Installation and Usage](#installation-and-usage)
- [Files Description](#files-description)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

## Project Description
This project aims to enhance decision-making in car insurance claims through Bayesian models. We compare these models to traditional logistic regression to demonstrate the advantages of Bayesian methods in such binary classification problems.

## Dataset
The dataset used for this analysis consists of various features that contribute to the decision of approving a car insurance claim. It can be accessed at [Kaggle: Car Insurance Claim Data](https://www.kaggle.com/code/kerneler/starter-car-insurance-claim-data-62f4f91c-d/data).

## State of the art - model results
! <img width="539" alt="image" src="https://github.com/ayushlodha7/BAYESIAN-CLASSIFICATION-ANALYSIS-ON-CAR-INSURANCE-CLAIMS/assets/63442869/05f30fd6-8489-4db4-a101-43874d311cea">

*Image: Comparative results of different Bayesian models.*

## Preprocessing Steps
The data was preprocessed to clean and prepare for analysis. This involved:
- Dropping duplicate rows
- Replacing null values with interpolation
- Normalizing and log-transforming certain features for better model performance

## Models
We utilized several Bayesian models with different priors to analyze the data:
- Model 1: Bayesian model with normal and uninformative priors
- Model 2: Bayesian model with normal and informative priors
- Model 3: Bayesian model with Student's t and uninformative priors
- Model 4: Bayesian model with Student's t and informative priors

## Results
The models were assessed based on their accuracy and the confusion matrix results. The findings are visualized in the presentation slides and detailed in the final report.

## Installation and Usage
To run the analysis, ensure you have R installed with the necessary libraries. Scripts can be executed in the R environment to reproduce the results.

## Files Description
Below is the list of files and their purpose in this repository:
- `Cauchy_Importance.R`: Script related to Cauchy distribution analysis
- `Normal_Importance.R`: Script related to Normal distribution analysis
- `df_log_preprocess.csv`: Preprocessed dataset with log transformation
- `df_new.csv`: Newly created dataset after initial preprocessing
- `df_preprocess.csv`: Dataset after preliminary preprocessing
- Other `.R` files correspond to the specific models and their priors used in the analysis.

## Detailed Analysis and Findings
For a comprehensive understanding of our methodology, models, and findings, please refer to the following resources:

- **Medium Blog Post**: Dive into our detailed blog post on Medium for an in-depth narrative of the Bayesian approach used in building our classification models. [Read the blog post here](https://medium.com/@ayushlodha7/bayesian-way-of-building-classification-models-7b409500bb41).

- **Project Report**: The complete report provides a thorough explanation of the project's scope, methodology, results, and conclusions. The report can be found in the repository.

- **Presentation Slides**: The slides from our project presentation give a visual overview of the research, approach, and key takeaways. These are also available in the repository.

## Contributing
If you would like to contribute to this project, please fork the repository and create a pull request with your suggestions.


## Contact
Ayush Lodha (Email: amlodha@purdue.edu )

## Acknowledgments
- Prof. Ben Boukai for guidance and insights
- Kaggle for the dataset
- Colleagues and peers for their support
