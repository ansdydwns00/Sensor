<details>
	<summary>CUDA 삭제</summary>
  	<div markdown="1">
	
	CUDA 삭제

	$ sudo rm -rf /usr/local/cuda*
		
	$ sudo apt-get --purge remove 'cuda*'
		
	$ sudo apt-get autoremove --purge 'cuda*'
	

	
	제거 확인
	
	$ sudo dpkg -l|grep cuda
			
	# 만약 설치된게 남았다면:
	$ sudo apt-get remove --purge 남은 찌꺼기 이름
	



	이후 재부팅
	
	$ sudo reboot
	

</details> 


<details>
	<summary>CUDA 설치</summary>
  	<div markdown="1">
	
	CUDA 설치

 	# 해당 링크에 접속하여 본인 driver에 맞는 cuda 버전 확인
 	https://developer.nvidia.com/cuda-toolkit-archive

	# 해당 사이트 참고
	https://honbul.tistory.com/41

</details> 

<details>
	<summary>torch & torchvision 삭제 및 설치</summary>
  	<div markdown="1">
	
	torch & torchvision 삭제
 	$ pip uninstall torch torchvision

	torch & torchvision 설치(아래 링크 참고)
	https://pytorch.org/get-started/locally/

 	# 버전 확인
  	python3 -c "import torch; print(torch.__version__)"
  	python3 -c "import torchvision; print(torchvision.__version__)"

</details> 

<details>
	<summary>Cudnn</summary>
  	<div markdown="1">
	

	Cudnn 설치(아래 링크 참고)
	https://hjh1023.tistory.com/59

</details> 

<details>
	<summary>matlab ros msg</summary>
  	<div markdown="1">
	

 	# Matlab에 존재하는 ros2 msg list
	>> ros2 msg list

 	# 만약 Matlab에 원하는 ros2 msg가 없을경우 따로 build 해줘야 함
  	# build 하기 원하는 ros2 msg가 포함되어 있는 폴더의 경로로 이동 후 아래 명령어 실행
   	>> ros2genmsg(pwd)

</details> 


## Development Environment 
```
# Intel i7-9700 CPU 3.60Hz x 8
# NVIDIA GeForce GTX 1660 Ti
# Driver Version: 535.171.04
# CUDA Version: 12.2

# Ubuntu 20.04.6 LTS 
# ROS2 - foxy version
```


## Installation Dependency
```
$ git clone https://github.com/ansdydwns00/YongJun_ws.git

# Yolov8
$ cd YongJun_ws/src
$ pip3 install -r YOLO/Yolov8/requirements.txt
$ cd ../
$ rosdep install --from-paths src --ignore-src -r -y

# USB_CAM
$ sudo apt-get install ros-foxy-usb-cam
$ rosdep install --from-paths src --ignore-src -y


# Before build, remove build, install, log folder
$ colcon build --symlink-install 
```



## USB_CAM
```
# usb_cam launch
$ cd YongJun_ws
$ source install/setup.bash
$ ros2 launch usb_cam camera.launch.py

```


If you want setting camera config
```
$ sudo apt install guvcview
$ guvcview
```

## YOLOV8
```
# Yolov8 launch
$ cd YongJun_ws
$ source install/setup.bash
$ ros2 launch yolov8_bringup yolov8.launch.py

```






https://github.com/ansdydwns00/YongJun_ws/assets/81146105/5b0c084b-5386-486c-bef9-30e43c3b9cea












## Build custom ros msg in MATLAB
```
% Matlab 내 정의되어 있는 ros msg type
>> ros2 msg list

% Custom ros msg를 사용하기 위해 custom msg가 정의되어 있는 작업 공간에서 Build 진행
>> msg_path =  '/home/yong/YongJun_ws/src/YOLO/Yolov8';
>> ros2genmsg(msg_path)

% Custom ros msg가 제대로 추가 되었는지 확인
>> ros2 msg list
```








## Reference
[Yolov8](https://github.com/kirkfreire/yolov8_ros2) 


[USB_CAM](https://github.com/ros-drivers/usb_cam)

https://kr.mathworks.com/help/ros/ref/ros2genmsg.html
