clc; clear all; 
f = 1*10^12;
%KT = 414.1947*10^-23;
% uc = 1;%%eV
uc = 0.1:0.01:1;
t = 1*10^12;
% t = 0;%%s^-1
T = 300;%%K
w = 2*pi*f;
%%
K = 0.86183e-4;%%eV
KT = K*T;
uckt = uc./KT;
h = 6.62607015*10^-34;
% h = 6.582*10^-16;
qe = 1.602176634*10^-19;
ca = uckt+2.*log(exp(-uckt)+1);%%%%%sigma*
b = h*h*(w - 1i*t);
sa = -1i*4*pi*qe*qe*qe*KT/b.*ca;%%sigma intra
% 
% sam = h*h.*(w + 1i*t);%%uc>>kt,from graphene spp
% saa = 4i*pi*qe*qe*qe*uc./sam;
sr1 = -1i*0.5*qe*qe/h;
cr = 0.5*h/pi/qe.*(w - 1i*t);
cr1 = -cr+2*uc;
cr2 = cr+2*uc;
sr = sr1.*log(cr1./cr2);%%sigma inter


z = 1./(sa+sr);%%z = (8.493951189+53.38303689j)/uc
resa = real(sa+sr);%%re = 0.002907uc+5.491e-07
imsa = imag(sa+sr);%%im = -0.01827uc-2.492e-06
figure
plot(uc,resa,'r')
hold on;
plot(uc,imsa,'b')


ff = 1*10^12;
ucc = 1;%%eV
ww = 2*pi*ff;
uckt1 = ucc/KT;
caa = uckt1+2*log(exp(-uckt1)+1);%%%%%sigma*
bb = h*h*(ww - 1i*t);
saa = -1i*4*pi*qe*qe*qe*KT/bb*caa;%%sigma intra

sr1 = -1i*0.5*qe*qe/h;
cr = 0.5*h/pi/qe.*(ww - 1i*t);
cr1 = -cr+2*ucc;
cr2 = cr+2*ucc;
srr = sr1.*log(cr1./cr2);%%sigma inter

zz = 1/(saa+srr)


%% zs = zs1+zs2
% % a = 30e-6;
% % g = 4e-6:1e-7:15e-6;
% % er = 4;
% % e0 = 8.854187817e-12;
% % er_eq = (er+1)/2;
% % zs1 = (0.6.*(a./(a-g)).^3+0.4)*zz;
% % zs2 = -1i*pi./(2*ww*e0*er_eq*a*log(sin(pi*g*0.5/a)));
% % zs = zs1+zs2;
% % imagz = imag(zs)
% % plot(g,real(zs),'r')
% % hold on;
% % plot(g,imag(zs),'b')



% zz =8.4951 +53.3766i
% 8.4953 +53.3768i