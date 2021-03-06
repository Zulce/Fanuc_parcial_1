function []=robot(q1,q2,q3,q4,q5,q6)
global l1 l2 l3 l4 l5
parametros
%Vectores relativos representafos por MH)
%para cada sistema de referencia ocupando
%los parámetros DHC(alfa, a, theta, d)
S01=DHC(0,0,q1,l1);
S12=DHC(pi/2,l2,pi/2+q2,0);
S23=DHC(0,l3,q3,0);
S34=DHC(pi/2,0,q4,l4);  
S45=DHC(-pi/2,0,q5,0);
S56=DHC(pi/2,0,q6,0);
S67=roty(-pi/2)*rotx(pi)*transl(l5,0,0);

%Vectores de posición
S02=S01*S12;
S03=S01*S12*S23;
S04=S01*S12*S23*S34;
S05=S01*S12*S23*S34*S45;
S06=S01*S12*S23*S34*S45*S56;
S07=S01*S12*S23*S34*S45*S56*S67;
%r=S07;

%Vector con puntos que apuntan al origen de cada sistema
x=[0 S01(1,4) S02(1,4) S03(1,4) S04(1,4) S05(1,4) S06(1,4) S07(1,4)];
y=[0 S01(2,4) S02(2,4) S03(2,4) S04(2,4) S05(2,4) S06(2,4) S07(2,4)];
z=[0 S01(3,4) S02(3,4) S03(3,4) S04(3,4) S05(3,4) S06(3,4) S07(3,4)];
plot3(x,y,z,'LineWidth',3)
hold on 
frame(eye(4),'r',0.2);
% frame(S01,'g',0.2);
% frame(S02,'b',0.2);
% frame(S03,'r',0.2);
% frame(S04,'g',0.2);
% frame(S05,'b',0.2);
% frame(S06,'r',0.2);
frame(S07,'c',0.2);
grid on 
n=1.7;
axis([-n n -n n -n n])
campos([n n n])
end 