% % % % a=((0.1444444/0.114)^2-1)^0.5;
% % % % aa = a*120*pi
% % % a=((0.188888888/0.12242)^2-1)^0.5;
% % % aa = a*120*pi
% % % %((14444444444/re(Mode(1)))^2-1)^(0.5)*377
% % % x = 200:50:2000;
% % x = 4:1:18;
% % % % y1 = [2185003567783.199951171875000,2155750641689.550048828125000,2133263645200.219970703125000,2113737833899.550048828125000,2096685909829.939941406250000,2078524615107.840087890625000,2071650802813.120117187500000,2063961269679.540039062500000,2057281716613.969970703125000,2051718034433.429931640625000,2047796358816.639892578125000,2042755579377.120117187500000,2039113421544.199951171875000,2037009706762.610107421875000,2033169747016.979980468750000,2030676895130.969970703125000,2028447818891.689941406250000,2026462709577.159912109375000,2024681845215.500000000000000,2023053065983.669921875000000,2021567519671.219970703125000,2020213007774.040039062500000,2019790771671.189941406250000,2018207971669.969970703125000,2016740824175.409912109375000,2015146508480.530029296875000,2014824357096.580078125000000,2014479798161.040039062500000,2013161369439.070068359375000,2012412346657.540039062500000,2011711862390.739990234375000,2011051595146.620117187500000,2010411144355.939941406250000,2009823299903.959960937500000,2009268351620.379882812500000,2008743642183.199951171875000,2008246752687.090087890625000];
% % y1 = [1009567182406.1999511,1058199077592.660034,1080001432786.82995,1094335798705.339965,1111509910582.64990,1128536189894.09008,1144190499915.09008,1160701948811.9899,1173556131665.4099,1184061087160.290039,1193805883412.5100097,1202988523495.760009,1211333571241.870117,1216535337256.59008,1224854190939.120117];
% % % modefilename = 'C:\Users\user\Desktop\mode.txt';
% % % modedata=importdata(yinfilename).data;
% % 
% % z1 =((1666666666666./y1).^2.-1).^(0.5).*120*pi;
% % figure
% % plot(x,z1)
% % k0 = 20000*sin(60*pi/180)/3;
% % kt = 1e6/45;
% % % 
% % % % % a+b*x^-1+c*x^-2+d*x^-3
% % xs = -20000:.1:20000;
% % y=164.5+1701*xs.^(-1)+2307*xs.^(-2)-1.908e+04*xs.^(-3);
% % % y = a+b*x^-1+c*x^-2+d*x^-3+e*x^-4+f*x^-5+g*x^-6+h*x^-7
% % figure;
% % plot(xs,y)
% % axis([0 30 250 500]);

clc; clear all; 
f0=1e12;
% ele=8.854e-12;
% mu=4*pi*1e-7; 
k0 = 2*pi*f0*10^(-8)/3;
iter=1;
zz = 660;
mm = 150;
uc_surf1 = [];
uc_surf2 = [];

m = mm/zz;
theta = pi/6;
z0 = 120*pi;
gh = (1+(zz/z0)^2)^0.5;
a = 2*pi/(k0*(gh-sin(theta)));
kt1 = gh*k0;
kt21 = 0.25*m^2*k0*(zz/z0)^2/gh;
kt22 = 1/(1-1i*(1-gh+2*pi/(k0*a))^0.5/(zz/z0))+1/(1-1i*(1-gh-2*pi/(k0*a))^0.5/(zz/z0));
kt = kt1 - kt21*kt22;
kt = real(kt);

for k=1:51
    for j=1:51
        x = -0.000780+0.00003*k;
        y = -0.000780+0.00003*j;
        r=(x^2+y^2)^0.5;
%         if x>0
%             z = zz+mm*cos(k0*sin(theta)*x-kt1*r);
%         else
%             z = zz-mm*cos(k0*sin(theta)*x-kt1*r);
%        end
       z1 = zz+mm*cos(k0*sin(theta)*x-kt1*r);
       syms xs1;
       equ1 = z1==400.5+122*xs1^-1-19.17*xs1^-2+4.948*xs1^-3;
       answer1 = vpasolve(equ1,xs1);
       uc_surf1 = [uc_surf1,double(answer1(1))];
       
       z2 = zz+mm*cos(k0*sin(pi/4)*x-kt1*r);
       syms xs2;
       equ1 = z2==400.5+122*xs2^-1-19.17*xs2^-2+4.948*xs2^-3;
       answer2 = vpasolve(equ1,xs2);
       uc_surf2 = [uc_surf2,double(answer2(1))];
       

    fprintf('Running iteration #%d...\n', iter);
    iter=iter+1;
    end
end


x = -0.00075:0.00003:0.00075;
y = -0.00075:0.00003:0.00075;
[X,Y]=meshgrid(x,y);


uc_surf = uc_surf1-uc_surf2;
reuc_surf=reshape(uc_surf,51,51);
pcolor(X,Y,reuc_surf);