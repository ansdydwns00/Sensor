%% Timer for Handshake protocol

% Initialize workspace
clear; clc;

% Connect udp handshake communication
udpObj = udpport("datagram","LocalPort",55501);

% Start timer
t = timer;
t.Period = 1;
t.TimerFcn = {@InitProtocol,udpObj};
t.ExecutionMode = 'fixedRate';

start(t)

%% Initialize ROS Node

Node = ros2node("/MATLAB");

LidarPub = ros2publisher(Node,"/Avia","sensor_msgs/PointCloud2");
LidarMsg = ros2message(LidarPub);
LidarMsg.header.frame_id = 'map';

%% Connect AVIA UDP Communication

% Connect udp data communication
Avia_UDP = udpport("byte","LocalPort",56001,"ByteOrder","little-endian");


%% Load pointPillars model

load pointpillarModel.mat detector

%% Visualization using 600 packet messages

% Setting point cloud viewer parameter
xmin = 0;  xmax = 10;
ymin = -5; ymax = 5;
zmin = -2; zmax = 5;

player = pcplayer([xmin xmax],[ymin ymax],[zmin zmax]);


% Set values for frame count 
frameCount = 1;

% Flag for first Run
reset_flag = single(0);


while true
    
    % Read 1 packet
    packet = single(read(Avia_UDP,1362))';

    [xyzCoords,xyzIntensity,isValid] = Avia_parsing_single_mex(packet,reset_flag);

    if isValid

        reshape_xyzPointsBuffer = reshape(xyzCoords, 32, [], 3);
        reshape_xyzIntensityBuffer = reshape(xyzIntensity, 32, [], 1);

        ptCloud = pointCloud(reshape_xyzPointsBuffer,"Intensity",reshape_xyzIntensityBuffer);
        
        % LidarMsg = rosWriteXYZ(LidarMsg,(ptCloud.Location));
        % LidarMsg = rosWriteIntensity(LidarMsg,(ptCloud.Intensity));
        % send(LidarPub,LidarMsg);
        
        % Object Detection
        [bboxes, scores, labels] = detect(detector,ptCloud,"ExecutionEnvironment","gpu","Threshold",0.2);
        
        % Compute Object Distance
        [Distances,Ids] = LR_computeDistance(ptCloud,bboxes);

        % Delete 0 distance
        idx = find(Distances);
        
        Distances = Distances(idx,:);
        Ids = Ids(idx,:);
        bboxes = bboxes(idx,:);
        scores = scores(idx,:);
        labels = string(labels(idx,:));

        % bboxes(:,3) = bboxes(:,3) + 1.3;


        % Match Distances & Labels
        showShape('cuboid',bboxes,'Parent',player.Axes,'Opacity',0.2,'Color','red','LineWidth',0.5,...
                  'Label',"ID:" + Ids + "," + labels + "," + Distances + "m",...
                  'LabelOpacity',0.8);
        % showShape('cuboid',bboxes,'Parent',player.Axes,'Opacity',0.2,'Color','red','LineWidth',0.5);
        
        
        % Display ptCloud 
        view(player,ptCloud);
        
        frameCount = frameCount + 1;
        
        flush(Avia_UDP)
    end
   
    reset_flag = single(1);
end