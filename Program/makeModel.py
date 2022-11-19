import numpy as np
from keras import Sequential
from keras.layers import *
import matplotlib.pyplot as plt
from imageSizeUify import *
from sklearn.model_selection import train_test_split

x_train, x_test, y_train, y_test = train_test_split(np.array(images), np.array(labels), test_size=0.2)
x_train, x_val, y_train, y_val = train_test_split(x_train, y_train, test_size=0.1)

# CNN 모델 설정
model = Sequential()
model.add(Conv2D(32, kernel_size=(3,3), input_shape=(img_w, img_h, 3), activation="relu"))
model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPool2D(pool_size=2))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(10, activation='softmax'))

# 모델 컴파일
model.compile(loss='cateorical_crossentropy', optimizer='adam', metrics=['accuracy'])

# 모델 학습
history = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=100, batch_size=10)

# 학습 간 정확도 및 오차의 변화도 시각화
accuracy = history.history['accuracy']
val_accuracy = history.history['val_accuracy']

loss = history.history['loss']
val_loss = history.history['val_loss']

epoch_range = range(20)

plt.figure(figsize=(16,8))
plt.subplot(1,2,1)
plt.plot(epoch_range, accuracy, label='Training Accuaracy')
plt.plot(epoch_range, val_accuracy, label='Validation Accuaracy')
plt.legend(loc='lower right')
plt.title('Training and Validation Accuracy')

plt.subplot(1,2,2)
plt.plot(epoch_range, loss, label='Training Loss')
plt.plot(epoch_range, val_loss, label='Validation Loss')
plt.legend(loc='upper right')
plt.title('Training and Validation Loss')
plt.show()

