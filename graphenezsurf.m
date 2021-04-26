clc; clear all; 
%% input
% y_in = 1i*-0.0032074894;
g = 3:1:20;
% g = 3:0.2:29;
uc = 0.3:0.01:1;
yinfilename = 'C:\Users\user\Desktop\yin_uc100.txt';
% yinfilename = 'C:\Users\user\Desktop\ying03.txt';
yindata=importdata(yinfilename).data;
f0 = 1e12;%%
er = 4;%%
d = 3e-5;%%substrate thick
er_g = er^0.5;
k0 = 2*pi*f0*10^(-8)/3;
z0 = 120*pi;
k0er_d = k0*er_g*d;
y_diel = er_g/(1i*z0*tan(k0er_d));
z_surf = [];

% 
% %%
% y_i = yindata(:,[2])'+1i*yindata(:,[3])';
% % for i = 1:131
% for i = 1:171
%     y_in = y_i(i);
%     y_sheet = y_in - y_diel
%     z_sheet = 1/y_sheet;
%     % z_sheet = 1./y_sheet;
%     % figure;
%     % plot(g,imag(z_sheet))
% 
% %%
%     syms zsurf;
%     kx10 = (er-1+(zsurf/z0)^2)^0.5;
% %     kx10 = (er-1-(zsurf/z0)^2)^0.5;
%     kx1 = kx10*k0;
%     equ = 1/zsurf == y_sheet-1i*er/(tan(kx1*d)*z0*kx10);
% %     equ = 1/zsurf == -1*imag(y_sheet)+er/(tan(kx1*d)*z0*kx10);
% %     if i<50
% %         zurf_answer = vpasolve(equ,zsurf,10+650i)
% %     else
% %         zurf_answer = vpasolve(equ,zsurf,10+400i)
% %     end
%     zurf_answer = vpasolve(equ,zsurf,10+400i)
% %     zurf_answer = vpasolve(equ,zsurf,10+650i)
%     
%     z_surf = [z_surf,double(zurf_answer)];
% end
% realans = real(z_surf)
% imagans = imag(z_surf)
% figure;
% plot(uc,real(z_surf),'r')
% hold on;
% plot(uc,imag(z_surf),'g')
% % plot(g,real(z_surf),'r')
% % hold on;
% % plot(g,imag(z_surf),'g')



y_i = [];
for i = 2:1:19
    y_i = [y_i,yindata(:,[i])'+1i*yindata(:,[i+18])'];
end

for i =1:1278
    y_in = y_i(i);
    y_sheet = y_in - y_diel
    z_sheet = 1/y_sheet;
    syms zsurf;
    kx10 = (er-1+(zsurf/z0)^2)^0.5;
    kx1 = kx10*k0;
    equ = 1/zsurf == y_sheet-1i*er/(tan(kx1*d)*z0*kx10);
    if i<214
        zurf_answer = vpasolve(equ,zsurf,10+650i)
    else
        zurf_answer = vpasolve(equ,zsurf,10+400i)
    end
    z_surf = [z_surf,double(zurf_answer)];
    fprintf('Running iteration #%d...\n', i);
end

z_surf=reshape(z_surf,71,18);
realans = real(z_surf)
imagans = imag(z_surf)
