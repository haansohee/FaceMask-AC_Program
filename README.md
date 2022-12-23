# S/W프로젝트 : Face Mask A-C Program
## 마스크 착용한 얼굴 인식을 통한 출석 체크 프로그램

<br>

## 1. Face Mask A-C Program
해당 프로그램은 티처블머신을 활용한 얼굴 인식 프로그램으로, 수강생들이 마스크를 착용한 후 카메라 얼굴 인식을 통해 출석 체크를 할 수 있다. 수강생은 강의실에 입실 후 출석 체크를 하고, 교수는 강의 시간이 시작되면 웹 페이지를 통해 수강생들의 출석 여부를 확인한다. 더 자세한 내용은 맨 하단의 링크를 통해 확인할 수 있다.

<br>

## 2. 계획

<img width="770" alt="plan" src="https://user-images.githubusercontent.com/90755590/209362548-281fdf5d-99f4-4d49-b590-7b9e05d1aeb5.png">

<br>

## 3. 개발 환경 및 개발 언어
<b>운영체제</b>
<table>
  <tr><td> 프로세서 <td> Apple M1 pro  </td></tr>
    <tr><td> RAM </td> <td> 16GB </td></tr>
  </table>

웹 페이지 부분에서는 Intel i5 16GB

<br>

<b>개발 언어 및 라이브러리 </b>

<table>
  <tr><td> 프로그램 언어  <td> Python 3.8, JSP </td></tr>
    <tr><td> IDE  </td> <td> Pycharm, Eclipse  </td></tr>
	<tr><td> Database </td> <td> MySQL </td> </tr>
	<tr><td> 라이브러리 및 패키지 </td> <td>OpenCV, Numpy, Keras, PIL, JDK  </td> </tr>
	<tr><td> 서버 </td> <td> Apache Tomcat v9.0 </td> </tr>
	<tr><td> 가상환경 </td> <td> Conda </td> </tr>
  </table>

<br>

## 4. 시스템 구성 및 아키텍처
<b> 영상 처리 프로그램 </b>

![VideoProgram](https://user-images.githubusercontent.com/90755590/209362359-d2fe08a0-8c2a-4cb7-8d51-a901eeb5f592.png)

<br>

<b> 웹 페이지 </b>

![WebProgram](https://user-images.githubusercontent.com/90755590/209362444-ab83bd38-11d7-4a51-b45e-fb093c1fc5a9.png)



<a href="https://velog.io/@haansohee/SW-프로젝트-준비-과x정-1"> 프로젝트 준비 과정 </a>



<br>

## 5. 팀원 역할

<table>
  <tr style="text-align:center;"> <td> 한소희 (본인)  </td> <td> 박인수 학우님 </td> <td> 박세현 학우님 </td></tr>
  <tr> <td> - 프로젝트 총괄 <br>
    		- 데이터베이스 구축 <br>
    		- 학습 모델 생성 <br>
    		- 데이터 모델링을 위한 <br>
    		얼굴 검출 프로그램 구현 <br>
    		- 얼굴 인식 프로그램 구현 <br>
    - 웹 사이트 구성도 구현	 </td>
    <td> - 데이터 확보 <br>
      - 날짜별 데이터 저장을 <br>
      위한 데이터베이스 구현 <br>
      - 웹 사이트 구현 </td>
    <td> - 데이터 확보 <br>
      - 날짜별 데이터 저장을 <br>
      위한 데이터베이스 구현 <br>
      - 웹 사이트 UI, UX </td>
  </table>
