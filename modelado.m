clc;close all; clear all;
syms q1 q2 q3 q4 q5 q6
syms l1 l2 l3 l4 l5 pi
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

%Cinemática directa
CD=S01*S12*S23*S34*S45*S56*S67;

%Cinematica inversa
syms xe ye ze alfa betha gamma
%Vector de posición hacia el efector final
P07=transl(xe,ye,ze)*rotz(gamma)*roty(betha)*rotx(alfa);
%CD - vector de posición del efector final en coordenadas cartesianas
eq=CD-P07;

%Ecuaciones
eq1=eq(1,1);
eq2=eq(1,2);
eq3=eq(1,3);
eq4=eq(1,4);

eq5=eq(2,1);
eq6=eq(2,2);
eq7=eq(2,3);
eq8=eq(2,4);

eq9=eq(3,1);
eq10=eq(3,2);
eq11=eq(3,3);
eq12=eq(3,4);

eq13=eq(4,1);
eq14=eq(4,2);
eq15=eq(4,3);
eq16=eq(4,4);

%%Modelo cinemático diferencial

%Matrices de rotación del eslabón i a i+1 para 
%velocidad angular
R01=S01(1:3,1:3);
R12=S12(1:3,1:3);
R23=S23(1:3,1:3);
R34=S34(1:3,1:3);
R45=S45(1:3,1:3);
R56=S56(1:3,1:3);
R67=S67(1:3,1:3);
%Vectores de posición para velocidad lineal 
P01=S01(1:3,4);
P12=S12(1:3,4);
P23=S23(1:3,4);
P34=S34(1:3,4);
P45=S45(1:3,4);
P56=S56(1:3,4);
P67=S67(1:3,4);

%Propagación de velocidades
syms q1p q2p q3p q4p q5p q6p
v00=[0;0;0]; w00=[0;0;0];
Z=[0;0;1];

%No hay velocidad lineal; el sistema está en la base
v11=transpose(R01)*(v00+cross(w00,P01));
%Sólo contribuye la articulación 1 (motor 1) 
w11=transpose(R01)*w00+q1p*Z;

%La velocidad del motor 1 se proyecta en los 3 ejes del sistema 2
v22=transpose(R12)*(v11+cross(w11,P12));
%El motor 1 contibuye en los xyz y q2p solo en z
w22=transpose(R12)*w11+q2p*Z;

%El motor 1 y 2 contribuyen en xy y el motor 1 sólo en z
v33=transpose(R23)*(v22+cross(w22,P23));
%El motor q1 proyectado contribuye en xyz y el motor 2 y 3 directo en z
w33=transpose(R23)*w22+q3p*Z;

v44=transpose(R34)*(v33+cross(w33,P34));
w44=transpose(R34)*w33+q4p*Z;

v55=transpose(R45)*(v44+cross(w44,P45));
w55=transpose(R45)*w44+q5p*Z;

v66=transpose(R56)*(v55+cross(w55,P56));
w66=transpose(R56)*w55+q6p*Z;

v77=transpose(R67)*(v66+cross(w66,P67));
w77=transpose(R67)*w66+0*Z;

%JACOBIANO relativo en sistema 77 D(6x6)
J77 =[diff(v77(1),q1p) diff(v77(1),q2p) diff(v77(1),q3p) diff(v77(1),q4p) diff(v77(1),q5p) diff(v77(1),q6p);...
      diff(v77(2),q1p) diff(v77(2),q2p) diff(v77(2),q3p) diff(v77(2),q4p) diff(v77(2),q5p) diff(v77(2),q6p);...
      diff(v77(3),q1p) diff(v77(3),q2p) diff(v77(3),q3p) diff(v77(3),q4p) diff(v77(3),q5p) diff(v77(3),q6p);...
      diff(w77(1),q1p) diff(w77(1),q2p) diff(w77(1),q3p) diff(w77(1),q4p) diff(w77(1),q5p) diff(w77(1),q6p);...
      diff(w77(2),q1p) diff(w77(2),q2p) diff(w77(2),q3p) diff(w77(2),q4p) diff(w77(2),q5p) diff(w77(2),q6p);...
      diff(w77(3),q1p) diff(w77(3),q2p) diff(w77(3),q3p) diff(w77(3),q4p) diff(w77(3),q5p) diff(w77(3),q6p)
      ];

%VELOCIDAD DIRECTA
qp=[q1p;q2p;q3p;q4p;q5p;q6p];
xe77p=J77*qp;
%VELOCIDAD INVERSA
rank(J77);

%Explicar aportación de motores (son las columnas)
DET=simplify(det(J77));

%Cálculo de la aceleración
q=[q1;q2;q3;q4;q5;q6];

J77p=diff_matrix(J77,qp,q);
fileID=fopen('J77p.txt','w');
fprintf(fileID,'%s',J77p);
fclose(fileID);