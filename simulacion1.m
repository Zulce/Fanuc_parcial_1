%Simulación 1: movimiento articulación a articulación 
clc; close all; clear all;
parametros 

f=figure(1)
%Poste
for i=0:10:360
    clf 
    robot(deg2rad(i),0,0,0,0,0)
    pause(0.001)
end 

%Codo
for i=0:10:360
    clf 
    robot(0,deg2rad(i),0,0,0,0)
    pause(0.001)
end 

%Hombro
for i=0:10:360
    clf 
    robot(0,0,deg2rad(i),0,0,0)
    pause(0.001)
end 

%Brazo
for i=0:10:360
    clf 
    robot(0,0,0,deg2rad(i),0,0)
    pause(0.001)
end 

%Muñeca
for i=0:10:360
    clf 
    robot(0,0,0,0,deg2rad(i),0)
    pause(0.001)
    F(i+1)=getframe(f);
end 

%Efector final
for i=0:10:360
    clf 
    robot(0,0,0,0,0,deg2rad(i))
    pause(0.001)
    F(i+1)=getframe(f);
end 

vidObj=VideoWriter('Comprobación_CD','MPEG-4');
vidObj.FrameRate=10;
open(vidObj)
writeVideo(vidObj,F)
close(vidObj)
