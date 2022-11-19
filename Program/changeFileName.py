import os
# 파일 이름 바꾸기
dir = '../dataSet_resize/202144107_resize'

for i in range(1, 201):
    old_file = os.path.join(dir, '1_' + str(i) + '.jpg')
    new_file = os.path.join(dir, str(i) + '.jpg')

    print(old_file)
    print('---------------------')
    print(new_file)

    os.rename(old_file, new_file)