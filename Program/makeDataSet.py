# face mask detect 하기 위해 data set 원본 사진을 face detect할 부분만 자르는 코드. makeDataSet.py
import cv2
import cvlib as cv
import os
# #
# 이미지 목록 불러오기
# list_202144020 = os.listdir('../dataSet/101')
# # print(list_202144020)
# # print(len(list_202144020))
#
# for i in range(122, len(list_202144020) + 1):
#     print(i)
#     print('------------------')
#     # 한 장씩 읽어오기
#     image = cv2.imread('../dataSet/101/1.' + str(i) + '.jpg')
#
#     # cv.detect_face(image) : OpenCV의 DNN 모듈에서 미리 구현되어 있음.
#     faces, confidences = cv.detect_face(image) # faces: detect한 얼굴 위치 좌표, confidences: 얼굴일 확률
#
#     for face, conf in zip(faces, confidences):
#         print(conf) # 얼굴일 확률 확인하기.
#         if conf < 0.8:  # 얼굴일 확률이 0.8 미만이라면 재시도
#             continue
#         start_x, start_y, end_x, end_y = faces[0]
#         # 이미지 속 얼굴을 detect한 얼굴 위치 좌표대로 resize하여 저장.
#         cv2.imwrite('../dataSet/101_resize/' + str(i) + '.jpg', image[start_y:end_y, start_x:end_x, :])



# resize
image = cv2.imread('../model/1.150.JPG')

faces, confidences = cv.detect_face(image)

for (x, y, x2, y2), conf in zip(faces, confidences):
    # 확률 나타내기
    cv2.putText(image, str(conf), (x,y-10), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 1)
    cv2.rectangle(image, (x,y), (x2, y2), (0, 255, 0), 2)

# for face, conf in zip(faces, confidences):
#     if conf < 0.8:
#         continue
#     start_x, start_y, end_x, end_y = faces[0]
    # cv2.imwrite('/Users/hansohee/inhatc/2-2/Project/135.jpg', image[start_y:end_y, start_x:end_x, :])

print(faces)
print(confidences)

cv2.imshow('image', image)
key = cv2.waitKey(0)
cv2.destroyAllWindows()
