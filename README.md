Image Classification using Convolutional Neural Networks (CNN) with Keras and EBImage in R


Overview


This repository contains R code for building and training a convolutional neural network (CNN) using Keras and EBImage to classify images into three categories: planes, cars, and bikes. We utilize a dataset of 18 images (6 planes, 6 cars, and 6 bikes) to demonstrate image classification.


Repository Contents


- image_classification.R: R script containing code for data loading, preprocessing, model building, training, and evaluation.
- images: Folder containing 18 images (6 planes, 6 cars, and 6 bikes) used for training and testing.
    - planes: Folder containing 6 plane images.
    - cars: Folder containing 6 car images.
    - bikes: Folder containing 6 bike images.
- model_architecture.png: Visualization of the CNN architecture.



Requirements


- R version 4.0 or higher.
- Following R packages:
    - keras
    - tensorflow (backend for Keras)
    - EBImage
    - dplyr
    - ggplot2
