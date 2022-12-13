import gc

import cv2
import numpy as np
import cvlib as cv
from PIL import ImageFont, ImageDraw, Image
from modelData import *
from time import sleep


# 이미지 전처리 함수
def preprocessing(image) :
    size = (224, 224)
    # 이미지의 크기를 (높이 224, 너비 224) 픽셀로 조정
    image_resized = cv2.resize(image, size, interpolation=cv2.INTER_AREA)

    # 이미지 차원 재조정 : 예측을 위해 reshape 해 줌.
    # 이미지를 numpy 배열로 만들고 모델 입력 모양으로 모양을 변경.
    image_reshaped = np.array(image_resized, dtype=np.float32).reshape(1, 224, 224, 3)

    # 이미지 정규화
    image_normalized  = (image_reshaped / 127.5) - 1

    return image_normalized

def faceDetect(image):
    faces = []
    # cv.detect_face(image) -> OpenCV의 DNN 모듈에서 미리 구현되어 있음
    faces, confidencs = cv.detect_face(image)  # faces : 이미지에서 얼굴 위치 좌표, conf : 얼굴일 확률
    if len(faces) > 0:

        for (x, y, x2, y2), conf in zip(faces, confidencs): # 얼굴일 확률 나타내기
            # 확률이 0.8 미만이라면 재시도
            if conf < 0.8:
                cv2.putText(image, 'row!', (x, y - 10), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 1)
                detect_image = image
                return image, detect_image, False

            cv2.putText(image, str(conf), (x, y-10), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 1)
            cv2.rectangle(image, (x, y), (x2, y2), (0, 255, 0), 2)

            # 검출된 얼굴만을 crop 하여 반환하기
            start_x, start_y, end_x, end_y = faces[0]
            detect_image = image[start_y:end_y, start_x:end_x, :]
            return image, detect_image, True
    else:
        cv2.putText(image, 'no face', (100, 100), cv2.FONT_HERSHEY_PLAIN, 6, (0, 255, 0), 5, 1)
        print('----------------------')
        detect_image = image
        return image, detect_image, False

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
    image_fliped = cv2.flip(image, 1)  # 이미지 좌우반전

    # 종료
    if cv2.waitKey(200) > 0:
        break

    # image_fliped를 그레이스케일로 변환하여서
    gray = cv2.cvtColor(image_fliped, cv2.COLOR_BGR2GRAY)
    # Detect (얼굴 검출) 하기
    canvas, detectImage, result = faceDetect(image_fliped)

    sleep(0.5)   # 시간 지연

    while result:

        # 이미지 전처리
        preprocessed = preprocessing(detectImage)

        # 현재 이미지가 무엇인지 예측. (모델 예측) -> 카메라 속 인물이 누구인지!
        # 백분율 배열을 반환. (예:[0.2,0.8]은 20% 확신을 의미)
        # 첫 번째 레이블이고, 80%가 두 번째 레이블이라고 확신
        probabilities = model.predict(preprocessed)

        # 확률이 가장 높은 label을 maxProb변수에 저장하기.
        maxProb = labels[np.argmax(probabilities)]
        # labels에서 이름만 따로 저장 (인덱스, (학번_이름))
        name = maxProb.split()[1]  # 학번_이름
        index = name.split('_')[0]   # 학번

        canvas = font(canvas, name)

        # 출력하여 확인하기
        # print(maxProb)
        # print(name)
        # print("인증 중인 학생의 학번 : ", index)
        # print(np.max(probabilities))

        if check == 3 :
            falseNum = input("인식에 실패하였습니다. 학번을 기입하십시오. (단, 외부인은 기입 금지.) : ")
            sql = "UPDATE FaceMask SET whether = '확인요망', dateTime = " + today + " WHERE id = " + "'" + falseNum + "'"

            if falseNum in log:
                print(falseNum + " 학번의 학생은 이미 출석 인증을 완료하였습니다.")
                check = 0
                break

            log.append(falseNum)
            log = list(set(log))
            print(sql)
            check = 0
            cur.execute(sql)
            conn.commit()  # 입력한 데이터 저장
            break

        # 외부인으로 인식될 시
        if index == '101' or index == '102':
            print("정확도가 낮습니다. 다시 측정합니다.")
            check += 1
            break

        # 이미 출석 인증을 한 수강생일 시
        if index in log:
            print(name + " 학생은 이미 출석 인증을 완료하였습니다.")
            break

        print(name, "학생의 출석이 인증되었습니다.")
        print("SQL문 실행")
        sql = "UPDATE FaceMask SET whether = '출석', dateTime = " + today + " WHERE id = " + "'" + index + "'"
        print(sql)
        cur.execute(sql)
        conn.commit()  # 입력한 데이터 저장

        log.append(index)
        log = list(set(log))

        break

    cv2.imshow("web cam", canvas)

# sql = "select * from FaceMask"
# cur.execute(sql)
# rows = cur.fetchall()
# print(rows)

conn.close()
camera.release()
cv2.destroyAllWindows()
