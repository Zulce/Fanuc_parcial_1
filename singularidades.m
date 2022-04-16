clc;close all; clear all;
parametros
%% DET=
%                                     2 /                                / pi      \                          \
%   l3 l4 cos(q3) sin(q5) (cos(pi) - 1)  | 2 l2 + l4 cos(q2 + q3) + l3 cos| -- + q2 | 2 - l4 cos(pi + q2 + q3) |
%                                        \                                \  2      /                          /
% - ------------------------------------------------------------------------------------------------------------
%                                                         8
%% Dado que q2, q3 y q5 son las articulaciones dominantes en la ocurrencia de
%singularidades para los siguiente valores:
    %q3 = (n*pi)/2; donde n=0,1,2,3,4...
    %q5= = n*pi; donde n=0,1,2,3,4...
tic
inc=20;
c=1;
for i=0:inc:360
    for j=0:inc:360
        for k=0:inc:360
            for l=0:inc:360
                for m=0:inc:360
                    for n=0:inc:360
                        
                        q1=deg2rad(i); q2=deg2rad(j);
                        q3=deg2rad(k); q4=deg2rad(l);
                        q5=deg2rad(m); q6=deg2rad(n);
                        
                        DET(c)=(l3*l4*cos(q3)*sin(q5)*(cos(pi) - 1)^2*(2*l2 + l4*cos(q2 + q3) + 2*l3*cos(pi/2 + q2) - l4*cos(pi + q2 + q3)))/8;
                        
                        if DET(c)==0
                            Q1(c)=q1;
                            Q2(c)=q2;
                            Q3(c)=q3;
                            Q4(c)=q4;
                            Q5(c)=q5;
                            Q6(c)=q6;
                        end
                        c=c+1;
                    end
                end
            end
        end
    end
end 
toc

for i=1:1000:length(Q1)
    clf
    robot(Q1(i),Q2(i),Q3(i),Q4(i),Q5(i),Q6(i))
    pause(0.001)
end
