% Final Robotics Project: Feeding Robot
clear all;
Robot_IP = '0.0.0.0';
robot = tcpip(Robot_IP,30000,'NetworkRole','server');
fclose(robot);
disp('Press Play on Robot...')
fopen(robot);
disp('Connected!');

% Move to a position close to the bowl
closeT(1,1) = -307.1500;
closeT(1,2) = -70.8902;
closeT(1,3) = 384.2300; 
closeO(1,1) = -3.1093;
closeO(1,2) = 0.2014;
closeO(1,3) = 0.0583;
moverobot(robot, 1, closeT, closeO);

% Start Image Processing
cam = webcam( 'USB2.0 PC CAMERA');
preview(cam);
pause(3);
bool = 0;
cpxI = 321.2241;
cpyI = 338.79;
while bool == 0
    img = snapshot(cam); 
    % Function that calls AutoTrheshold, Blurring, Connected Components
    % and Centroid Computation for each object
    centroids = AutoThreshold(img);
    [rS, cS] = size(centroids);
    if rS >= 1
        if (rS == 1)
            bool = 1;
        end 
        cpx = centroids(1,1);
        cpy = centroids(1,2);
        % Read current Translation and Orientation
        Robot_Pose = readrobotpose(robot) %Returns P(6): Translation, Orientation
        cT = Robot_Pose(1:3);
        cO = Robot_Pose(4:6);
        % Move robot to cpx, cpy
        % Robot_pose + cpx, cpy, cpz = costant = 95
        % Proportional control, proportional to the distance to the centroid
        dX = cpx - cpxI;
        dY = cpy - cpyI;
        % Mapping, 1 pixel = .267mm
        dMMX = abs(dX) * .267;
        dMMY = abs(dY) * .267;
        % if dX is negative, move cT(1)(-), if positive, move cT(1)(+)
        % if dY is negative, move cT(2)(+), if positive, move cT(2)(-)
        if dX < 0
            tT(1) = (cT(1) - dMMX) + 5;
        else
            tT(1) = (cT(1) + dMMX) + 5;
        end
        
        if dY < 0
            tT(2) = (cT(2) + dMMY) - 95;
        else
            tT(2) = (cT(2) - dMMY) - 95;
        end
            tT(3) = cT(3) - 145;
        
        moverobot(robot, 1, tT, cO);
        
        % Go to position mouth
        mouthT(1,1) = -549.4160;
        mouthT(1,2) = -40.4847;
        mouthT(1,3) = 281.9220;
        mouthO(1,1) = -2.2000;
        mouthO(1,2) = 0.1857;
        mouthO(1,3) = 2.1167;
        moverobot(robot, 1, mouthT, mouthO);
        pause(7);
        % Return to position: closer position
        moverobot(robot, 1, closeT, closeO);
    else
       bool = 1; 
    end
    pause(2);
end

clear('cam');


