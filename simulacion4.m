%Simulación 3: Movimiento en trayectoria quíntica
clc; close all; clear all;
parametros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tf=10; % tiempo final de la trayetoria
c=1;
%Posicion inicial y final del vector sobre el cual se desplazará el efector
%final
Pi=[0.6;0.6;0.6];
pf=[1;0.9;0.9];

%Orientaciones iniciales y finales
ai=[deg2rad(-5);deg2rad(0);deg2rad(5)];
af=[deg2rad(5);deg2rad(10);deg2rad(-5)];

%% Posición
for t=0:1/10:tf
   time(c)=t;
   Rt=Pi+(10*(t/tf)^3-15*(t/tf)^4+6*(t/tf)^5)*(pf-Pi);
   x(c)=Rt(1);
   y(c)=Rt(2);
   z(c)=Rt(3);
   c=c+1;
end

c=1;
for t=0:1/10:tf
   Rt=ai+(10*(t/tf)^3-15*(t/tf)^4+6*(t/tf)^5)*(af-ai);
   a1(c)=Rt(1);
   a2(c)=Rt(2);
   a3(c)=Rt(3);
   c=c+1;
end

figure(1)
plot(time,x,'r');
hold on
plot(time,y,'g');
hold on
plot(time,z,'b');
hold on
plot(time,a1,'r');
hold on
plot(time,a2,'g');
hold on
plot(time,a3,'b');
hold on
title('Posición espacio cartesiano')
xlabel('Tiempo[s]')
ylabel('Posición[m] Orientacion[rad]')
legend('x','y','z','\alpha','\beta','\gamma','orientation','horizontal','location','SouthEast')
grid on

%% Velocidad cartesiana
c=1;
for t=0:1/10:tf
   time(c)=t;
   Vt=(30*(t^2/tf^3)-60*(t^3/tf^4)+30*(t^4/tf^5))*(pf-Pi);
   xv(c)=Vt(1);
   yv(c)=Vt(2);
   zv(c)=Vt(3);
   c=c+1;
end

c=1;
for t=0:1/10:tf
   Vt=(30*(t^2/tf^3)-60*(t^3/tf^4)+30*(t^4/tf^5))*(af-ai);
   a1p(c)=Vt(1);
   a2p(c)=Vt(2);
   a3p(c)=Vt(3);
   c=c+1;
end

figure(2)
plot(time,xv,'r');
hold on
plot(time,yv,'g');
hold on
plot(time,zv,'b');
hold on
plot(time,a1p,'r');
hold on
plot(time,a2p,'g');
hold on
plot(time,a3p,'b');
hold on
title('Velocidad espacio cartesiano')
xlabel('Tiempo [s]')
ylabel('Velocidad [m/s]-[rad/s]')
legend('x\prime','y\prime','z\prime','\alpha\prime','\beta\prime','\gamma\prime',...
    'orientation','horizontal','location','SouthEast')
grid on

%% Aceleración cartesiana
c=1;
for t=0:1/10:tf
   time(c)=t;
   At=(60*(t/tf^3)-180*(t^2/tf^4)+120*(t^3/tf^5))*(pf-Pi);
   xa(c)=At(1);
   ya(c)=At(2);
   za(c)=At(3);
   c=c+1;
end

c=1;
for t=0:1/10:tf
   At=(60*(t/tf^3)-180*(t^2/tf^4)+120*(t^3/tf^5))*(af-ai);
   a1pp(c)=At(1);
   a2pp(c)=At(2);
   a3pp(c)=At(3);
   c=c+1;
end

figure(3)
plot(time,xa,'r');
hold on
plot(time,ya,'g');
hold on
plot(time,za,'b');
hold on
plot(time,a1pp,'r');
hold on
plot(time,a2pp,'g');
hold on
plot(time,a3pp,'b');
hold on
title('Aceleración espacio cartesiano')
xlabel('Tiempo [s]')
ylabel('Aceleración [m/s^2]-[rad/s^2]')
legend('x\prime\prime','y\prime\prime','z\prime\prime',...
    '\alpha\prime\prime','\beta\prime\prime','\gamma\prime\prime',...
    'orientation','horizontal','location','SouthEast')
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global xe ye ze 
%Vector de inicio para método numérico para resolver c_inv
figure(4)
q0=[0,0,0,0,0,0];
c=1;
%Graficación del robot y su trayectoria quíntica
for i=1:1:length(x)
    xe=x(i); ye=y(i); ze=z(i); 
    alfa=a1(i); betha=a2(i); gamma=a3(i);
    %%Calculo de la posicón articular
    clf
    q=fsolve(@c_inv,q0);
    q1(c)=q(1); q2(c)=q(2); q3(c)=q(3);
    q4(c)=q(4); q5(c)=q(5); q6(c)=q(6);
    
    DET(c)=(l3*l4*cos(q(3))*sin(q(5))*(cos(pi) - 1)^2*(2*l2 + l4*cos(q(2) + q(3)) + 2*l3*cos(pi/2 + q(2)) - l4*cos(pi + q(2) + q(3))))/8;
    
    %%Caculo de la velocidad articular
    xp=[xv(i);yv(i);zv(i)];
    qp=inv(J77)*xp;
    %%Grficación de movimiento del robot
    robot(q(1),q(2),q(3),q(4),q(5),q(6));
    hold on
    plot3(x,y,z,'r','LineWidth',2)
    pause(0.001)
    q0=q;
    c=c+1;
end

figure(5)
title('Espacio de juntas')
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

figure(6)
title('Determinante')
plot(DET)
grid on

figure(7)
plot(DET)
grid on
