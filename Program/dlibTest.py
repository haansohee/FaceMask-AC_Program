import cv2
import dlib
import numpy as np

faceCascade = cv2.CascadeClassifier('../model/haarcascade_frontalface_default.xml')
predictor = dlib.shape_predictor('../model/shape_predictor_68_face_landmarks.dat')

# 얼굴 각 구역의 포인트들 구분해 노힉
JAWLINE_POINTS = list(range(0, 17))
RIGHT_EYEBROW_POINTS = list(range(17, 22))
LEFT_EYEBROW_POINTS = list(range(22, 27))
NOSE_POINTS = list(range(27, 36))
RIGHT_EYE_POINTS = list(range(36, 42))
LEFT_EYE_POINTS = list(range(42, 48))
MOUTH_OUTLINE_POINTS = list(range(48, 61))
MOUTH_INNER_POINTS = list(range(61, 68))

# def => dlib을 사용한 얼굴 및 눈 찾는 함수
# input => 그레이 스케일 이미지
# output => 얼굴 중요 68개의 포인트에 그려진 점과 이미지

def detect(gray, frame):
    # 1. haar를 이용한 얼굴 찾기
    faces = faceCascade.detectMultiScale(gray,
                                         scaleFactor=1.05,
                                         minNeighbors=5,
                                         minSize=(100, 100),
                                         flags=cv2.CASCADE_SCALE_IMAGE)

    # 얼굴에서 랜드마크 찾기
    for (x, y, w, h) in faces:
        dlib_rect = dlib.rectangle(int(x), int(y), int(x + w), int(y + h))
        landmarks = np.matrix([[p.x, p.y] for p in predictor(frame, dlib_rect).parts()])
        # landmarks_display = landmarks[0:68]
        landmarks_display = landmarks[36:48]

        for idx, point in enumerate(landmarks_display):
            pos = (point[0, 0], point[0, 1])
            cv2.circle(frame, pos, 2, color=(0, 255, 255), thickness=- 1)

    return frame

video_capture = cv2.VideoCapture(0)
video_capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
video_capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 360)

while True:
    _, frame = video_capture.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    canvas = detect(gray, frame)

    cv2.imshow("sohee", canvas)

    if (cv2.waitKey(1)) & 0xFF == ord('q') :
        break

video_capture.release()
cv2.destroyAllWindows()