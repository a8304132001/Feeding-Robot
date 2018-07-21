# Feeding Robot
Final Project for the robotics class at University of Houston by Dr. Aaron Becker.
We programmed a UR Robot that detect pieces of food with vision processing to feed a human. 
You can see the video of our project here: https://youtu.be/DAX02D7Bwss
![alt text](https://github.com/GuillermoHra/FeedingRobot/blob/master/IntroImage.png)

In this project we used a UR3 robot and a USB camera compatible with Matlab (you can find a cheap one here: https://www.amazon.com/Sea-Wit-Recording-Computer-External/dp/B074252LWL/ref=sr_1_14?s=pc&ie=UTF8&qid=1512875748&sr=1-14&keywords=usb+camera).

The connection between the robot and the computer running matlab was made with a TCP/IP socket.
A socket is created in FinalRoboticsProject.m, it sends the commands to the UR controller, which runs matlabcontrol.urp, a script that parses matlab commands to the UR programming language. With this, we can take advantage of the UR functions and at the same time, we can use a camera or other feedback sensor to control the robot. The UR functions used for this project are:
1. moverobot.m - Sends a vector with position(1:3) in mm and orientation(4:6).
2. readrobotpose.m - Reads the position and orientation from the robot.

FinalRoboticsProject.m uses the function AutoThreshold for the vision processing (blob detection, connected components, centroids).

We also designed a holder for the camera, it was made for the UR3, but I think it also works for the UR5 and the UR10.
Thingiverse link: https://www.thingiverse.com/thing:2704146
![alt text](https://github.com/GuillermoHra/FeedingRobot/blob/master/CameraHolder.png)
