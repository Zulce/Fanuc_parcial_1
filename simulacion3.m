%Simulación 3: Movimiento en trayectoria quíntica
clc; close all; clear all;
parametros
global xe ye ze 
%Tiempo final de la trayectoria
tf=10;
c=1;
%Posicion inicial y final del vector sobre el cual se desplazará el efector
%final
Pi=[0.7;0.7;0.6];
pf=[1;1;1];

for t=0:1/10:tf
   time(c)=t;
   %Expresión que representa el cambio de posción en función del tiempo y
   %los puntos final e inicial
   Rt=Pi+(10*(t/tf)^3-15*(t/tf)^4+6*(t/tf)^5)*(pf-Pi)
   x(c)=Rt(1);
   y(c)=Rt(2);
   z(c)=Rt(3);
   c=c+1;
end

%Vector de inicio para método numérico para resolver c_inv
q0=[0,0,0,0,0,0];
c=1;
%Graficación del robot y su trayectoria quíntica
f=figure(1)
for i=1:1:length(x)
    xe=x(i);ye=y(i); ze=z(i); 
    clf
    q=fsolve(@c_inv,q0);
    q1(c)=q(1); q2(c)=q(2); q3(c)=q(3);
    q4(c)=q(4); q5(c)=q(5); q6(c)=q(6);
    
    robot(q(1),q(2),q(3),q(4),q(5),q(6));
    hold on
    plot3(x,y,z,'r','LineWidth',2)
  %  campos([0.1 0.1 0.1])
    pause(0.001)
    q0=q;
    c=c+1;
    F(i)=getframe(f);
end

vidObj=VideoWriter('trayectoria_c_inv','MPEG-4');
vidObj.FrameRate=10;
open(vidObj)
writeVideo(vidObj,F)
close(vidObj)

figure(2)
title("Posición de las juntas")
plot(time,rad2deg(q1),'r')
hold on
plot(time,rad2deg(q2),'g')
plot(time,rad2deg(q3),'b')
plot(time,rad2deg(q4),'r*')
plot(time,rad2deg(q5),'g*')
plot(time,rad2deg(q1),'b*')
xlabel('Eje X')
ylabel('Eje Y')
legend('q1','q2','q3','q4','q5','q6')
grid on
    