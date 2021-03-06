function vr = setInitialMaze(vr)
% Initialize fist mazeID for current session
%This information is sent from BControl
% Input
% vr     = vr virmen handle (structure with initial maze needed)
% Output
% vr     = ve virmen handle, some initial vars started

vr.mainMazeID         = 4;
vr.mazeID             = 4;
vr.warmupIndex        = [];
vr.iMemEntry          = vr.iterFcn(0);
vr.iTurnEntry         = vr.iterFcn(0);