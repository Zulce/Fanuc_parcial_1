clc;close all; clear all;
syms q1 q2 q3 q4 q5 q6
syms l1 l2 l3 l4 l5 pi
%Vectores relativos representafos por MH)
%para cada sistema de referencia ocupando
%los parámetros DHC(alfa, a, theta, d)
S01=DHC(0,0,q1,l1);
S12=DHC(-pi/2,l2,pi/2+q2,0);
S23=DHC(0,l3,q3,0);
S34=DHC(0,pi/2,q4,l4);
S45=DHC(-pi/2,0,q5,0);
S56=DHC(pi/2,0,q6,0);
S67=DHC(0,0,0,l5);

%Vectores de posición
S02=S01*S12;
S03=S01*S12*S23;
S04=S01*S12*S23*S34;
S05=S01*S12*S23*S34*S45;
S06=S01*S12*S23*S34*S45*S56;
S07=S01*S12*S23*S34*S45*S56*S67;

%Cinemática directa
CD=S01*S12*S23*S34*S45*S56*S67

%Cinematica inversa
syms xe ye ze alfa betha gamma
%Vector de posición hacia el efector final
P07=transl(xe,ye,ze)*rotz(gamma)*roty(betha)*rotx(alfa)
%CD - vector de posición del efector final en coordenadas cartesianas
eq=CD-P07

%Ecuaciones
eq1=eq(1,1)
eq2=eq(1,2)
eq3=eq(1,3)
eq4=eq(1,4)

eq5=eq(2,1)
eq6=eq(2,2)
eq7=eq(2,3)
eq8=eq(2,4)

eq9=eq(3,1)
eq10=eq(3,2)
eq11=eq(3,3)
eq12=eq(3,4)

eq13=eq(4,1)
eq14=eq(4,2)
eq15=eq(4,3)
eq16=eq(4,4)