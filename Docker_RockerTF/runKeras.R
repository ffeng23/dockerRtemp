#R code for doing examples using keras for NN learning
#
#
library(keras)
library(lime)
library(tidyquant)
library(rsample)
library(recipes)
library(yardstick)
library(corrr)
library(here)
library(readxl)
library(tidyr)
library(ggplot2)


#import data
# Import data
churn_data_raw <- read_xlsx("Telco_customer_churn.xlsx")

glimpse(churn_data_raw)

#preprocessing
churn_data_tbl <- churn_data_raw %>%
	rename(Churn=`Churn Label`, SeniorCitizen=`Senior Citizen`,
		tenure="Tenure Months", TotalCharges="Total Charges"
		)%>%
    select(-CustomerID, -`Churn Reason`,
    	-`Churn Score`,-Country, -State, -Count,
    	-City,-`Zip Code`,-`Lat Long`,
    	-Latitude, -Longitude, -`Churn Value`,
    	-CLTV) %>%
    drop_na() %>%
    select(Churn, everything())
    
glimpse(churn_data_tbl)

#split training/testing set
# Split test/training sets
set.seed(100)
train_test_split <- initial_split(churn_data_tbl, prop = 0.8)
train_test_split

# Retrieve train and test sets
train_tbl <- training(train_test_split)
test_tbl  <- testing(train_test_split) 

# Determine if log transformation improves correlation 
# between TotalCharges and Churn
train_tbl %>%
    select(Churn, TotalCharges) %>%
    mutate(
        Churn = Churn %>% as.factor() %>% as.numeric(),
        LogTotalCharges = log(TotalCharges)
        ) %>%
    correlate() %>%
    focus(Churn) %>%
    fashion()



# Create recipe
rec_obj <- recipe(Churn ~ ., data = train_tbl) %>%
    step_discretize(tenure, options = list(cuts = 6)) %>%
    step_log(TotalCharges) %>%
    step_dummy(all_nominal(), -all_outcomes()) %>%
    step_center(all_predictors(), -all_outcomes()) %>%
    step_scale(all_predictors(), -all_outcomes()) %>%
    prep(data = train_tbl)

# Predictors
x_train_tbl <- bake(rec_obj, new_data = train_tbl)
x_test_tbl  <- bake(rec_obj, new_data = test_tbl)

glimpse(x_train_tbl)

# Response variables for training and testing sets
y_train_vec <- ifelse(pull(train_tbl, Churn) == "Yes", 1, 0)
y_test_vec  <- ifelse(pull(test_tbl, Churn) == "Yes", 1, 0)

#get rid of response variable from the independent data matrix
x_train_tbl <- x_train_tbl %>% 
	dplyr::select(!contains("Churn"))
x_test_tbl <- x_test_tbl %>% 
	dplyr::select(!contains("Churn"))

# Building our Artificial Neural Network
model_keras <- keras_model_sequential()

model_keras %>% 
    # First hidden layer
    layer_dense(
        units              = 16, 
        kernel_initializer = "uniform", 
        activation         = "relu", 
        input_shape        = ncol(x_train_tbl)) %>% 
    # Dropout to prevent overfitting
    layer_dropout(rate = 0.1) %>%
    # Second hidden layer
    layer_dense(
        units              = 16, 
        kernel_initializer = "uniform", 
        activation         = "relu") %>% 
    # Dropout to prevent overfitting
    layer_dropout(rate = 0.1) %>%
    # Output layer
    layer_dense(
        units              = 1, 
        kernel_initializer = "uniform", 
        activation         = "sigmoid") %>% 
    # Compile ANN
    compile(
        optimizer = 'adam',
        loss      = 'binary_crossentropy',
        metrics   = c('accuracy')
    )
model_keras

# Fit the keras model to the training data
fit_keras <- fit(
    object           = model_keras, 
    x                = as.matrix(x_train_tbl), 
    y                = y_train_vec,
    batch_size       = 50, 
    epochs           = 35,
    validation_split = 0.30
    )

    

fit_keras


# Plot the training/validation history of our Keras model
plot(fit_keras) +
    theme_tq() +
    #scale_color_tq() +
    #scale_fill_tq() +
    labs(title = "Deep Learning Training Results")

    # Predicted Class
#yhat_keras_class_vec <- predict_classes(object = model_keras, x = as.matrix(x_test_tbl)) %>%
#    as.vector()
yhat_keras_class_vec<- model_keras %>% predict(as.matrix(x_test_tbl)) %>% `>`(0.5) %>% k_cast("int32") %>% as.vector()
# Predicted Class Probability
yhat_keras_prob_vec  <- predict(object = model_keras, x = as.matrix(x_test_tbl)) %>%
    as.vector()

library(tidyverse)
#
# Format test data and predictions for yardstick metrics
estimates_keras_tbl <- tibble(
    truth      = as.factor(y_test_vec), #%>% fct_recode(yes = "1", no = "0"),
    estimate   = as.factor(yhat_keras_class_vec) ,#%>% fct_recode(yes = "1", no = "0"),
    class_prob = yhat_keras_prob_vec
)

estimates_keras_tbl