# E-commerce-Online-Shopper-Intention-Prediction
Primary goal of this project is to predict what customers are going to purchase on the e-commerce site, in order to develop personalized marketing strategy to boost actual purchase. 

## Overview  
This project evaluates three different machine learning models—**Decision Tree, Random Forest, and Support Vector Machine (SVM)**—to predict whether a customer will make a purchase based on their website behavior. The goal is to enhance precision marketing and optimize e-commerce performance.  

## Dataset  
We use the **Online Shoppers Purchasing Intention Dataset** from the **UC Irvine Machine Learning Repository**. It contains **12,330 sessions** with 18 features (10 numerical, 8 categorical) and is highly imbalanced (about **15% purchases vs. 85% non-purchases**).  

## Models Evaluated  

### 1️. Decision Tree  
- Identifies key features affecting customer purchases.  
- **Best Accuracy:** ~84.9%  
- **Key Features:** PageValues, Month, TrafficType, ProductRelated, Administrative
<img width="333" alt="截圖 2025-03-05 下午1 14 20" src="https://github.com/user-attachments/assets/a9c41173-9a24-456a-851d-91bc76e706b8" />

### 2️. Random Forest  
- Uses bagging to improve robustness and reduce overfitting.  
- **Best Accuracy:** ~91% (fine-tuned model)  
- **Best Precision & Recall:** ~95% each
<img width="280" alt="截圖 2025-03-05 下午1 14 53" src="https://github.com/user-attachments/assets/dc50de1c-fe09-421d-9495-0da10af702cf" />


### 3️. Support Vector Machine (SVM)  
- Linear kernel used for simplicity and efficiency.  
- **Best Accuracy:** ~87.5%  
- **Balanced performance across metrics**
<img width="251" alt="截圖 2025-03-05 下午1 15 24" src="https://github.com/user-attachments/assets/e5abbe09-bd9f-4c0f-b6c2-8be41519f8cf" />


## Key Findings  
- **Random Forest** achieved the highest accuracy and stability.  
- **Decision Tree** provided interpretability but had lower performance.  
- **SVM** performed well despite its simpler approach.  
- Applying **class weights** helped address the imbalanced dataset.  

## Dependencies  
- R  
- Packages: `rpart`, `randomForest`, `e1071`, `caret`  

## References  
- Dataset: [UCI ML Repository](https://archive.ics.uci.edu/dataset/468/online+shoppers+purchasing+intention+dataset)  
