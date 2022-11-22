import cv2
import numpy as np
import cvlib as cv
from PIL import ImageFont, ImageDraw, Image
from modelData import *

# 이미지 전처리 함수
def preprocessing(image) :
    size = (224, 224)
    # 이미지의 크기를 (높이 224, 너비 224) 픽셀로 조정
    image_resized = cv2.resize(image, size, interpolation=cv2.INTER_AREA)

    # 이미지 차원 재조정 : 예측을 위해 reshape 해 줌.
    # 이미지를 numpy 배열로 만들고 모델 입력 모양으로 모양을 변경.
    image_reshaped = np.array(image_resized, dtype=np.float32).reshape(1, 224, 224, 3)

    # 이미지 정규화
    image_normalized = (image_reshaped / 127.5) - 1

    return image_normalized

def faceDetect(image):
    # cv.detect_face(image) -> OpenCV의 DNN 모듈에서 미리 구현되어 있음
    faces, confidencs = cv.detect_face(image)  # faces : 이미지에서 얼굴 위치 좌표, conf : 얼굴일 확률
    if len(faces) > 0: # 얼굴이 있을 경우에

        for (x, y, x2, y2), conf in zip(faces, confidencs): # 얼굴일 확률 나타내기
            # 확률이 0.8 미만이라면 재시도
            if conf < 0.8:
                cv2.putText(image, 'row!', (x, y - 10), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 1)
                return image, False
            cv2.putText(image, str(conf), (x, y-10), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 1)
            cv2.rectangle(image, (x, y), (x2, y2), (0, 255, 0), 2)

        return image, True
    else: # 얼굴이 없을 경우
        print('----------------------')
        return image, False

# def faceDetect(gray, image):
#     # 얼굴 인식 실행하기 (haar 이용)
#     faces = face_cascade.detectMultiScale(gray,
#                                           scaleFactor=1.05,
#                                           minNeighbors=5,
#                                           minSize=(100, 100),
#                                            flags=cv2.CASCADE_SCALE_IMAGE)
#     # detect 성공
#     if len(faces) > 0:
#         # 얼굴에 사각형 그리고 눈 찾기
#         for (x, y, w, h) in faces :
#             # 얼굴 : 이미지 프레임의 (x, y)에서 시작, (x+넓이, y+길이)까지의 사각형을 그림
#             cv2.rectangle(image, (x, y), (x + w, y + h), (255, 0, 0,), 2)
#             # 이미지를 얼굴 크기만큼 잘라서 그레이스케일 이미지와 컬러 이미지 만듦
#             face_gray = gray[y:y + h, x:x + w]
#             face_color = image[y:y + h, x:x + w]
#             # 얼굴 영역에서의 눈 찾기
#             eyes = eye_cascade.detectMultiScale(face_gray, 1.1, 3)
#             # 눈 찾기 성공
#             if len(eyes) > 0:
#                 # 눈 : 이미지 프레임의 (x, y)에서 시작. (x+넓이, y+길이)까지의 사각형을 그림
#                 for (ex, ey, ew, eh) in eyes :
#                     cv2.rectangle(face_color, (ex, ey), (ex + ew, ey + eh), (0, 255, 0), 2)
#                 return image, True
#             # # 눈 찾기 실패
#             # else:
#             #     print("!!!no eyes!!!")
#             #     cv2.putText(image, "no eyes", (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
#             #     return image, False
#     # 얼굴 detect 실패
#     else:
#         print("!!!no face!!!")
#         cv2.putText(image, "no face", (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
#         return image, False

# cv2.putText 시 한글 깨짐 방지 함수
def font(image, name):
    # opencv로 read한 이미지를 pil로 read
    # pil_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    pil_image = Image.fromarray(image)

    # 설치한 폰트를 사용하기 위해 draw.text에 font 설정해 주기.
    fontpath = '../fonts/nanum.ttf'
    font = ImageFont.truetype(fontpath, 50)
    draw = ImageDraw.Draw(pil_image, 'RGBA')

    draw.text((50, 50,), name, (0, 0, 255), font=font)

    # 다시 opencv로 변환하고 반환해주기
    img_cv2 = np.array(pil_image)
    return img_cv2

while True:
    # camera 이미지 가져오기
    ret, image = camera.read()
    image_fliped  = cv2.flip(image, 1)  # 이미지 좌우반전

    # 종료
    if cv2.waitKey(200) > 0:
        break

    # 이미지 전처리
    preprocessed = preprocessing(image_fliped)

    # image_fliped를 그레이스케일로 변환하여서
    gray = cv2.cvtColor(image_fliped, cv2.COLOR_BGR2GRAY)
    # Detect (얼굴 검출) 하기
    canvas, result = faceDetect(image_fliped)

    if result == True:
        # 현재 이미지가 무엇인지 예측. (모델 예측) -> 카메라 속 인물이 누구인지!
        # 백분율 배열을 반환. (예:[0.2,0.8]은 20% 확신을 의미)
        # 첫 번째 레이블이고, 80%가 두 번째 레이블이라고 확신
        probabilities = model.predict(preprocessed)

        # 확률이 가장 높은 label을 maxProb변수에 저장하기.
        maxProb = labels[np.argmax(probabilities)]
        # labels에서 이름만 따로 저장 (인덱스, (학번_이름))이니까 1번째
        name = maxProb.split()[1]
        index = maxProb.split()[0]

        if index == 14 or index == 15:
            print("외부인입니다. 인식을 재시도합니다.")
            continue

        # 출력하여 확인하기
        print(maxProb)
        print(name)
        print(np.max(probabilities))

        # 정확도가 가장 높은 값이 0.5 이하인지 확인
        if np.max(probabilities) < 0.6:
            print("정확도가 낮습니다. 다시 측정합니다.")
            continue

        else:
            for i in range(0, 16):
                # print('name: ' + name)
                # print("stuName[i]: " + stuName[i])
                # if name == stuName[14] or name == stuName[15]:
                #     print("외부인입니다. 다시 인식 시도.")
                #     continue
                if name == stuName[i]:
                    print(name, "학생의 출석이 인증되었습니다.")
                    print("SQL문 실행")
                    sql = "UPDATE FaceMask SET Whether = 'OK' WHERE id = " + "'" + stuNum[i] + "'"
                    print(sql)
                    # cur.execute(sql)
                    # conn.commit()  # 입력한 데이터 저장

                    canvas = font(canvas, name)

    cv2.imshow("web cam", canvas)

# sql = "select * from FaceMask"
# cur.execute(sql)
# rows = cur.fetchall()
# print(rows)

# conn.close()
camera.release()
cv2.destroyAllWindows()
