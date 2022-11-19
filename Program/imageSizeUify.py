# 데이터(이미지) 전처리 : CNN 모델에서 이미지를 인식할 때 각 이미지를 동일한 크기의 픽셀로
# 나누기 때문에 현재 모든 이미지를 동일한 크기로 포맷함. 그러기 위해 가장 보편적인 이미지의 크기 찾아보자

import os
from keras.utils import load_img, img_to_array

# 이미지 크기 통일하기
img_w, img_h = 760, 1080
images = []
labels = []

filePath = '../dataSet_resize'
fileName = os.listdir(filePath)
print(fileName)

for i in range(0, 16):
    imgFilePath = filePath + '/' + fileName[i] + '/'
    for j in range(1, 201):
        image = load_img(imgFilePath + str(j) + '.jpg', target_size=(img_w, img_h))
        image = img_to_array(image)
        images.append(image)
    labels.append(i)

# print(images[0].shape)