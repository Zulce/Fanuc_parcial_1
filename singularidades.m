clc;close all; clear all;
parametros
%% DET=
%                                     2 /                                / pi      \                          \
%   l3 l4 cos(q3) sin(q5) (cos(pi) - 1)  | 2 l2 + l4 cos(q2 + q3) + l3 cos| -- + q2 | 2 - l4 cos(pi + q2 + q3) |
%                                        \                                \  2      /                          /
% - ------------------------------------------------------------------------------------------------------------
%                                                         8
%% Dado que q3 y q5 son las articulaciones dominantes en la ocurrencia de
%singularidades para los siguiente valores:
    %q3 = (n*pi)/2; donde n=0,1,2,3,4...
    %q5= = n*pi; donde n=0,1,2,3,4...
tic
inc=1;
c=1;
for i=0:inc:360
    for j=0:inc:360
        for k=0:inc:360
                        
                        q2=deg2rad(i); q3=deg2rad(j);q5=deg2rad(k); 
                        
                        DET(c)=(l3*l4*cos(q3)*sin(q5)*(cos(pi) - 1)^2*(2*l2 + l4*cos(q2 + q3) + 2*l3*cos(pi/2 + q2) - l4*cos(pi + q2 + q3)))/8;
                        
                        if DET(c)==0
                            
                            Q2(c)=q2;
                            Q3(c)=q3;
                            Q5(c)=q5;
                            
                            c=c+1;
                        end
        end
    end
end 
toc

Q2u=unique(Q2);
Q3u=unique(Q3);
Q5u=unique(Q5);

f=figure(1)
for i=1:1:length(Q2u)
    clf
    robot(0,Q2u(i),Q3u(i),0,0,0)
    pause(0.001)
    F(i)=getframe(f);
end

vidObj=VideoWriter('singularidades_2','MPEG-4');
vidObj.FrameRate=10;
open(vidObj)
writeVideo(vidObj,F)
close(vidObj)