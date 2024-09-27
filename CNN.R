
library(EBImage)
library(keras)


##read images
pic1<-c('p1.jpg','p2.jpg','p3.jpg','p4.jpg','p5.jpg',
        'c1.jpg','c2.jpg','c3.jpg','c4.jpg','c5.jpg',
        'b1.jpg','b2.jpg','b3.jpg','b4.jpg','b5.jpg' )

train<-list()
for (i in 1:15) {train[[i]]<-readImage(pic1[i])}


pic2<-c('p6.jpg','c6.jpg','b6.jpg')
test<-list()
for (i in 1:3) {test[[i]]<-readImage(pic2[i])}

###explore

print(train)
print(train[[11]])
display(train[[11]])
summary(train[[11]])
hist(train[[11]])
plot(train[[11]])
str(train)

par(mfrow=c(3,5))
for (i in 1:15) plot(train[[i]])
  
par(mfrow=c(1,1))

###resize and combine

str(train)
for (i in 1:15) {train[[i]]<-resize(train[[i]],100,100)}
for (i in 1:3) {test[[i]]<-resize(test[[i]],100,100)}

train<-combine(train)
x<-tile(train,5)
display(x,title='pictures')

test<-combine(test)
y<-tile(test,3)
display(y,title='pics')


###reorder dimension

train<-aperm(train,c(4,1,2,3))
test<-aperm(test,c(4,1,2,3))


###response

trainy<-c(0,0,0,0,0,1,1,1,1,1,2,2,2,2,2)

testy<-c(0,1,2)




###one hot encoding

trainlabels<-to_categorical(trainy)
testlabels<-to_categorical(testy)


###model

model<-keras_model_sequential()

model %>% 
 layer_conv_2d(filters = 32,
               kernel_size = c(3,3),
               activation = 'relu',
               input_shape = c(100,100,3)) %>% 
  
  layer_conv_2d(filters = 32,
                kernel_size = c(3,3),
                activation = 'relu') %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_dropout(rate = 0.25) %>% 
  layer_conv_2d(filters = 64,
                kernel_size = c(3,3),
                activation = 'relu') %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_dropout(rate = 0.25) %>% 
  layer_flatten() %>% 
  layer_dense(units = 256,activation = 'relu') %>% 
  layer_dropout(rate = 0.25) %>% 
  layer_dense(units = 3,activation = 'softmax') %>% 
  
  
  
  compile(loss='categorical_crossentropy',
          optimizer=optimizer_sgd(lr=0.01,
                                  decay=1e-6,
                                  momentum = 0.9,
                                  nesterov = T),
          metrics=c('accuracy'))
                                  


##fit model


history<-model %>% 
  fit(train,
      trainlabels,
      epochs=60,
      batch_size=32,
      validation_split=0.2)


plot(history)









### evaluation and prediction-   train data


model %>% evaluate(train,trainlabels)
pred<-model %>% predict_classes(train)

table(predicted=pred,actual=trainy)


prob<-model %>% predict_proba(train)

cbind(prob,predicted_class=pred,actual=trainy)




### evaluation and prediction-   test data


model %>% evaluate(test,testlabels)
pred<-model %>% predict_classes(test)

table(predicted=pred,actual=testy)


prob<-model %>% predict_proba(test)

cbind(prob,predicted_class=pred,actual=testy)

