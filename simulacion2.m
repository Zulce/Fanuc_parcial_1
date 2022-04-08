%Simulación 2: obtención de la cinemática inversa
%clc; close all; clear all;
parametros 

global xe ye ze alfa betha gamma

% xe=0.924;ye=-0.172;ze=0.950;
% alfa=pi/2;betha=pi;gamma=pi/2;

xe=1.185;ye=0;ze=0.550;
alfa=0;betha=-pi/2;gamma=-pi;

%q0=[pi,0,pi/2,pi,pi,0]
q0=[0,0,0,0,0,0]

q=fsolve(@c_inv,q0)
robot(q(1),q(2),q(3),q(4),q(5),q(6))
hold on 
plot3(xe,ye,ze,'r*')