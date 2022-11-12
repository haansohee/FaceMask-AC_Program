import cv2
from keras.models import load_model
import pymysql

# 모델 불러오기
model = load_model('../model/keras_model.h5')

# haar 분류기 불러오기 (모델 불러오기)
face_cascade = cv2.CascadeClassifier('../model/haarcascade_frontalface_default.xml')  # 얼굴
eye_cascade = cv2.CascadeClassifier('../model/haarcascade_eye.xml')  # 눈

# 카메라 캡처 객체 0 -> 내장카메라
camera = cv2.VideoCapture(0)

# 캡처 프레임 사이즈(해상도) 조절
camera.set(cv2.CAP_PROP_FRAME_WIDTH, 1080)
camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 760)

# label 가져오기
labels = open('../model/labels.txt', 'r').readlines()
print(labels)  # label 출력해서 확인

stuNameTest = labels.copy()  # 이름만 따로 저장하려고 원본 복사해 오기
stuNumTest = labels.copy()
stuName = []  # 이름_학번 저장할 리스트 -> 출결 처리 시 사용
stuNum = []  # 학번만 저장할 리스트 -> sql 쿼리문에서 사용

for i in range(0, 16):
    studentName = stuNameTest[0]
    del(stuNameTest[0])
    studentName = studentName.split()
    stuName.append(studentName[1])

for i in range(0, 16):
    studentNum = stuNumTest[0]
    del(stuNumTest[0])
    studentNum = studentNum.split()[1]
    studentNum = studentNum.split('_')
    stuNum.append(studentNum[0])

print(stuNum)  # 잘 저장됐는지 확인
print(stuName)

log = []  # 출결 처리 된 수강생은 쿼리문 실행 X => 서버 과부하 방지


# 데이터베이스 서버에 연결, 정상적으로 연결이 수립되면 커넥션 객체를 반환
# conn = pymysql.connect(host='localhost', user='sohee', password = 'wnsgur0702',
#                        db='FaceMask_Program', charset = 'utf8')  # charset = 'utif8' => 한글 처리
#
# # 커서 생성.
# cur = conn.cursor()