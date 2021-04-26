fmax = 1e15;
f = 0*10^9:10^9:fmax;
%KT = 414.1947*10^-23;
uc = 1;%%eV
t = 1*10^12;
% t = 0;%%s^-1
% t = 0.43*10^-6;
T = 300;%%K
w = 2*pi*f;
%%
K = 0.86183e-4;%%eV
KT = K*T;
uckt = uc/KT;
h = 6.62607015*10^-34;
% h = 6.582*10^-16;
qe = 1.602176634*10^-19;
ca = uckt+2*log(exp(-uckt)+1);%%%%%sigma*
b = h*h*(w - 1i*t);
sa = -1i*4*pi*qe*qe*qe*KT./b*ca;%%sigma intra


sam = h*h.*(w + 1i*t);%%uc>>kt,from graphene spp
saa = 4i*pi*qe*qe*qe*uc./sam;

%%
%%sigma inter// correct
sr1 = -1i*0.5*qe*qe/h;
cr = 0.5*h/pi/qe.*(w - 1i*t);
cr1 = -cr+2*uc;
cr2 = cr+2*uc;
sr = sr1.*log(cr1./cr2);%%sigma inter


%%uc>>kt,from graphene spp
hfm = h*f-2*uc*qe;
hfp = h*f+2*uc*qe;
hf = log(abs(hfm./hfp));
srrr = 0.5*pi*qe*qe/h*heaviside(hfm);
srr = 0.5i*qe*qe/h.*hf+srrr;

%%
%%z
d = ca*4*pi*qe*qe*qe*KT/(h*h);
dd = 1/d;
e = (1i*w + t)*dd;
fenmu = d/(3.4*10^-9);
re = real(e(1));
z = 1./(sa+sr);
im = 2*pi*dd;
im = im*12e10;
tan = t/(2*pi);%%tan delta
figure
% plot(f,real(sa+sr),'r')
% semilogx(f,real(sa+sr),'r')
% hold on;
% semilogx(f,imag(sa+sr),'b')

%%
%%e_equal => jwe0(1-sigma/(w*eo*delta))
e0 = 8.854187817e-12;
delta = 1e-9;%%thick of graphene
e_equal = 1 + (imag(sa)./(w*e0*delta));
semilogx(f,e_equal)



% plot(h*f./qe./uc,real(saa+srr),h*f./qe./uc,imag(saa+srr))
% axis([0 10^15 -3e-4 3e-4]);
% plot(h*f./qe./uc,real(z),h*f./qe./uc,imag(z))
% hold on;
% plot(f,imag(sa),f,imag(sr))
% plot(f,heaviside(hfm))
% 5.8857e22/(1e24+39.4784*Freq^2)
% er = re(eg)/e0
% re(eg) = -imag(a)/w¦¤
% 9.2932e19/(1e24+39.4784*Freq^2)+1.479e31i/(1e24*Freq+39.4784*Freq^3)
% 16.9903   5.3377e-11*Freq
% 9.2932e19/(1e24+39.4784*Freq^2)  1.5915e11/Freq






















% % f = 2.5*10^11:10^9:2*10^12;
% % %KT = 414.1947*10^-23;
% % KT = 0.025852;
% % uckt = 0.5/KT;
% % h = 6.62607015*10^-34;
% % % h = 6.582*10^-16;
% % w = 2*pi*f;
% % % t = 0.43*10^-6;
% % t = 10^12;
% % qe = 1.602176634*10^-19;
% % c = uckt+2*log(exp(-uckt)+1);%%%%%
% % b = h*h*(1i*w + t);
% % a = 4*pi*qe*qe*qe*KT./b*c;
% % d = c*4*pi*qe*qe*qe*KT/(h*h);
% % dd = 1/d;
% % e = (1i*w + t)*dd;
% % fenmu = d/(3.4*10^-9);
% % re = real(e);
% % tan = t/(2*pi);
% % figure
% % plot(f,real(a),f,imag(a))
% % % plot(f,)
% % % 5.8857e22/(1e24+39.4784*Freq^2)