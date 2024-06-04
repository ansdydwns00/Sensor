function [data, info] = visionInfo
%VisionInfo gives an empty data for vision_msgs/VisionInfo
% Copyright 2019-2021 The MathWorks, Inc.
data = struct();
data.MessageType = 'vision_msgs/VisionInfo';
[data.header, info.header] = ros.internal.ros2.messages.std_msgs.header;
info.header.MLdataType = 'struct';
[data.method, info.method] = ros.internal.ros2.messages.ros2.char('string',1,NaN,0);
[data.database_location, info.database_location] = ros.internal.ros2.messages.ros2.char('string',1,NaN,0);
[data.database_version, info.database_version] = ros.internal.ros2.messages.ros2.default_type('int32',1,0);
info.MessageType = 'vision_msgs/VisionInfo';
info.constant = 0;
info.default = 0;
info.maxstrlen = NaN;
info.MaxLen = 1;
info.MinLen = 1;
info.MatPath = cell(1,8);
info.MatPath{1} = 'header';
info.MatPath{2} = 'header.stamp';
info.MatPath{3} = 'header.stamp.sec';
info.MatPath{4} = 'header.stamp.nanosec';
info.MatPath{5} = 'header.frame_id';
info.MatPath{6} = 'method';
info.MatPath{7} = 'database_location';
info.MatPath{8} = 'database_version';