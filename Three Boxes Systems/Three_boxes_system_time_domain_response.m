close all; clear all;

m1=30;
m2=5;
m3=15;
k1=68;
k2=68;
k3=68;
c1=8;
c2=8;
c3=8;
a=5;
w=20;%input frequency used to convert syms wb to double
Y=a/w^2;
 %input frequency used to convert syms wb to double
syms wb

M=[m1, 0, 0;
   0, m2, 0;
   0, 0, m3];

K=[k1, -k1, 0;
   -k1, k1+k2, -k2;
   0, -k2, k2+k3];

C=[c1, -c1, 0;
   -c1, c1+c2, -c2;
   0, -c2, c2+c3];

%cos part of the driven force
F1=[0, 0, c3*Y*wb].';

%sin part of the driven force
F2=[0, 0, k3*Y].';

%for the cos part
j=sqrt(-1);
A_h=wb^2*M+K;
A=-wb^2*M+j*wb*C+K;
H=inv(A);
H_F1=H*F1;  %calculate the response magnitude
H_F2=H*F2;  %calculate the response magnitude


%% TIME DOMAIN
figure(1)
t=(0: 0.01: 3).';
for ii=1:3
    H_f1_sym = H_F1(ii); %extracting the magnitude of X1
    H_f1_real = subs(H_f1_sym,wb,w); %substitute symble wb by a double (notice it is still in a syms form)
    H_f1_double(ii) =double(H_f1_real); %convert to double
    H_f2_sym =H_F2(ii); %extracting the magnitude of X1
    H_f2_real =subs(H_f2_sym,wb,w); %substitue symble wb by a double (notice it is still in a syms form)
    H_f2_double(ii) =double(H_f2_real); %convert to double
    X_f1_t(ii, :) = abs(H_f1_double(ii))*cos(w.*t+angle(H_f1_double(ii)));
    X_f2_t(ii, :) = abs(H_f2_double(ii))*sin(w.*t+angle(H_f2_double(ii)));
    X_t(ii, :) = X_f1_t(ii, :) + X_f2_t(ii, :);
    plot(t, X_t(ii, :),'LineWidth',1.1)
    hold on;
end
legend('m1', 'm2', 'm3')
saveas(gcf, 'v1', 'png')

title('Response In Time Domain','FontSize',30)
xlabel('Time (s)','FontSize',20)
ylabel('Amplitude(m/s)','FontSize',20)
set(gca,'FontSize',10)
grid on
set(gca,'GridAlpha',0.3)
legend('mass 1','mass 2','mass 3','Location','northeast')

