clear all;
close all;
%% PARAMETERS
m1=15;
m2=5;
m3=30;
k1=68; %N/m
k2=68;
k3=68;
c1=8; %N.s/m
c2=8;
c3=8;
a=5;
w=20;%input frequency used to convert syms wb to double
Y=a/w^2;
syms wb

%% SYSTEM PAREMETERS
M=[m1, 0, 0;
   0, m2, 0;
   0, 0, m3];

K=[k1, -k1, 0;
   -k1, k1+k2, -k2;
   0, -k2, k2+k3];

C=[c1, -c1, 0;
   -c1, c1+c2, -c2;
   0, -c2, c2+c3];

%% DRIVEN FORCE
%cos part of the driven force
F1=[0, 0, c3*Y*wb].';

%sin part of the driven force
F2=[0, 0, k3*Y].';

%% SOLVE FOR THE SOLUTION
%for the cos part
j=sqrt(-1);
A_h=-wb^2*M+K;
A=-wb^2*M+j*wb*C+K;
H=inv(A);
%% CALCULATING NATURAL FREQUENCIES
detA=det(A_h);
w_n=solve(detA,wb,'MaxDegree', 6);
w_n=double(w_n);
w_n1=abs(w_n(1));
w_n2=abs(w_n(2));
w_n3=abs(w_n(3));

%%magnitude for cos input
% H_f1=H*F1;  %calculate the response magnitude
% H1_f1=H_f1(1); %extracting the magnitude of X1
% H2_f1=H_f1(2);
% H3_f1=H_f1(3);
% H1_f1=subs(H1_f1,wb,w); %substitue symble wb by a double (notice it is still in a syms form)
% H1_f1=double(H1_f1); %convert to double
% H2_f1=subs(H2_f1,wb,w);
% H2_f1=double(H2_f1);
% H3_f1=subs(H3_f1,wb,w);
% H3_f1=double(H3_f1);
% 
% 
% %magnitude for sin input force
% H_f2=H*F2;  %calculate the response magnitude
% H1_f2=H_f2(1);  %extracting the magnitude of X1
% H1_f2=subs(H1_f2,wb,w); %substitue symble wb by a double (notice it is still in a syms form)
% H1_f2=double(H1_f2); %convert to double
% H2_f2=H_f2(2);
% H3_f2=H_f2(3);
% H2_f2=subs(H2_f2,wb,w);
% H2_f2=double(H2_f2);
% H3_f2=subs(H3_f2,wb,w);
% H3_f2=double(H3_f2);
% 
% 
% %Combine response from cos and sin input force
% 
% t=(0: 0.01: 10).';
% X1f1_t=abs(H1_f1)*cos(w.*t+angle(H1_f1)); %response due to cos force input componet
% X1f2_t=abs(H1_f2)*sin(w.*t+angle(H1_f2)); % response due to sin force input component
% X1_t=X1f1_t+X1f2_t; %superposition
% 
% X2f1_t=abs(H2_f1)*cos(w.*t+angle(H2_f1)); %response due to cos force input componet
% X2f2_t=abs(H2_f2)*sin(w.*t+angle(H2_f2)); % response due to sin force input component
% X2_t=X2f1_t+X2f2_t; %superposition

% figure(1)
% plot(t,X2f1_t,'LineWidth',1.1)
% 
% figure(2)
% plot(t,X2f2_t,'LineWidth',1.1)
% 
% figure(3)
% plot(t,X2_t,'LineWidth',1.1)


%% BODE PLOT FOR EACH RESPONSES
X_1=[];
X_2=[];
X_3=[];
for w=0:0.05:15
    H_f1=H*F1;  %calculate the response magnitude
    H1_f1=H_f1(1); %extracting the magnitude of X1
    H2_f1=H_f1(2);
    H3_f1=H_f1(3);
    H1_f1=subs(H1_f1,wb,w); %substitue symble wb by a double (notice it is still in a syms form)
    H1_f1=double(H1_f1); %convert to double
    H1_f1_amp=abs(H1_f1); %calculating the absolute value of H1_f1
    H1_f1_ang=angle(H1_f1);%calculating the phase of H1_f1
    H2_f1=subs(H2_f1,wb,w);
    H2_f1=double(H2_f1);
    H2_f1_amp=abs(H2_f1); %calculating the absolute value of H2_f1
    H2_f1_ang=angle(H2_f1);%calculating the phase of H2_f1
    H3_f1=subs(H3_f1,wb,w);
    H3_f1=double(H3_f1);
    H3_f1_amp=abs(H3_f1); %calculating the absolute value of H3_f1
    H3_f1_ang=angle(H3_f1);%calculating the phase of H3_f1
    
    %magnitude for sin input force
    H_f2=H*F2;  %calculate the response magnitude
    H1_f2=H_f2(1);  %extracting the magnitude of X1
    H2_f2=H_f2(2);
    H3_f2=H_f2(3);
    H1_f2=subs(H1_f2,wb,w); %substitue symble wb by a double (notice it is still in a syms form)
    H1_f2=double(H1_f2); %convert to double
    H1_f2_amp=abs(H1_f2); %calculating the absolute value of H1_f2
    H1_f2_ang=angle(H1_f2);%calculating the phase of H1_f2
    H2_f2=subs(H2_f2,wb,w);
    H2_f2=double(H2_f2);
    H2_f2_amp=abs(H2_f2); %calculating the absolute value of H2_f2
    H2_f2_ang=angle(H2_f2);%calculating the phase of H2_f2
    H3_f2=subs(H3_f2,wb,w);
    H3_f2=double(H3_f2);
    H3_f2_amp=abs(H3_f2); %calculating the absolute value of H3_f2
    H3_f2_ang=angle(H3_f2);%calculating the phase of H3_f2
    
    %%Calculating the responding amplitudes
    X_1=[X_1,amp(H1_f1_amp,H1_f2_amp,H1_f1_ang,H1_f2_ang)];
    X_2=[X_2,amp(H2_f1_amp,H2_f2_amp,H2_f1_ang,H2_f2_ang)];
    X_3=[X_3,amp(H3_f1_amp,H3_f2_amp,H3_f1_ang,H3_f2_ang)];
end
w=[0:0.05:15]; %%recalculate the driven frequency
X_1=20.*log(X_1);
X_2=20.*log(X_2);
X_3=20.*log(X_3); 
figure(1)
plot(w,X_1,'LineWidth',1.1)
hold on
plot(w,X_2,'LineWidth',1.1)
hold on
plot(w,X_3,'LineWidth',1.1)
title('Frequency Response','FontSize',30)
xlabel('w (rad/s)','FontSize',20)
ylabel('Amplitude (m)','FontSize',20)
set(gca,'FontSize',10)
grid on
set(gca,'GridAlpha',0.3)
legend('mass 1','mass 2','mass 3','Location','northeast')

%% CALCULATING AMPLITUDE FOR THE FREQUENCY RESPONSE
function [AMP] = amp(A,B,a,b)
    AMP=sqrt((B*cos(b)-A*sin(a))^2+(A*cos(a)+B*sin(b))^2);
end
