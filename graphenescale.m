clc; clear all; 
tmpScriptFile = 'D:\amatlab\uctest10.vbs';
temdesignname='HFSSDesign1';
hfssExePath = 'C:\Program Files\AnsysEM\AnsysEM21.1\Win64\ansysedt.exe"';
hfssProjectFile='D:\ansysproj\uctest17.aedt';
fid = fopen(tmpScriptFile, 'wt');

hfssNewProject(fid);
hfssInsertDesign(fid, 'HFSSDesign1');

hfssSaveProject(fid, hfssProjectFile, true)
% hfssOpenProject(fid, hfssProjectFile);
% hfssSetDesign(fid, 'HFSSDesign1');
f0=1e12;
% ele=8.854e-12;
% mu=4*pi*1e-7; 
k0 = 2*pi*f0*10^(-8)/3;
iter=1;
faceid=4;
zz = 427;
mm = 50;
assignim = 1;
rho = 0.00103;
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
% for k=1:101
    for j=1:51
        %%x=-88+3*k;
        %%y=-88+3*j;
%         x = -0.001530+0.00003*k;
        x = -0.000780+0.00003*k;
        y = -0.000780+0.00003*j;
%         x = -0.078+0.003*k;
%         an=atan(y/x);
        r=(x^2+y^2)^0.5;
       %%z=263+74*real(exp(-i*k0*sin(an)*exp(i*k0*r)));
       if x>0
           z = zz+mm*cos(k0*sin(theta)*x-kt1*r);
%            z = 360+(75+25*abs(x)/0.001530)*cos(k0*sin(theta)*x-kt1*r);
%            z = zz+mm*cos(k0*sin(theta)*rho*sin(x/rho)+k0*cos(theta)*rho*cos(x/rho)-kt*r);
       else
           z = zz-mm*cos(k0*sin(theta)*x-kt1*r);
%            z = zz+mm*cos(k0*sin(theta)*x-kt1*r+pi*16.5/18);
%            z = 360-(75+25*abs(x)/0.001530)*cos(k0*sin(theta)*x-kt1*r);
%            z = zz-mm*cos(k0*sin(theta)*rho*sin(x/rho)+k0*cos(theta)*rho*cos(x/rho)-kt*r);
       end
       syms xs;
% %        equ = z==164.5+1701*xs^(-1)+2307*xs^(-2)-1.908e+04*xs^(-3);
%        equ = z==258.3 -2264*xs^-1+6.52e+04*xs^-2-5.021e+05*xs^-3+1.919e+06*xs^-4-3.937e+06*xs^-5+4.142e+06*xs^-6-1.753e+06*xs^-7;
%        equ = z==354 -7774*xs^-1+1.7e+05*xs^-2-1.24e+06*xs^-3+3.583e+06*xs^-4+2.064e+05*xs^-5-2.05e+07*xs^-6+2.829e+07*xs^-7;
%        equ = z==481.1-1.455e+04*xs^-1+2.572e+05*xs^-2-7.832e+05*xs^-3-8.923e+06*xs^-4+7.725e+07*xs^-5-2.217e+08*xs^-6+2.232e+08*xs^-7;
%        equ = z==400.5+122*xs^-1-19.17*xs^-2+4.948*xs^-3; %g=3
%        equ = z==445+50.73*xs^-1+16.27*xs^-2-0.5614*xs^-3; %g=3
%        equ = z==327.9+24.77*xs^-1-1.31*xs^-2+2.655*xs^-3; %g=8
       equ = z==359.9+31.19*xs^-1+3.083*xs^-2+2.493*xs^-3; %g=6
%        equ = z==304.3+16.89*xs^-1-1.668*xs^-2+1.792*xs^-3; %g=10
       answer = vpasolve(equ,xs);
%        g = answer(3)
%        if g>30
%            g = answer(2)
%        end
       g = 6;
       uc = answer(1)
%       xs = -3831500+24730*z-53.18*z^2+0.03811*z^3
%        g = -205.2+2.538e+05*z^-1-1.058e+08*z^-2+1.553e+10*z^-3

      un=sprintf('patch%d',iter);
%     hfssRectangle(fid, un, 'Z', [-1530+15*k-7.5+0.25, -390+15*j-7.5+0.25, 30], 14.5,  14.5, 'um');
    hfssRectangle(fid, un, 'Z', [-780+30*k-15+0.5*g, -780+30*j-15+0.5*g, 30], 30-g,  30-g, 'um');
    if assignim>0
        faceid = faceid +12;
        hfssAssignImpedance(fid,un,faceid,8.4953/uc,53.3768/uc);
    end

% %     GetFaceByPosition
    fprintf('Running iteration #%d...\n', iter);
    iter=iter+1;
    end
end

if assignim>0
    hfssBox(fid, 'sub', [-765, -765, 0], [1530, 1530, 30], 'um', [0, 0, 0], 13, 'Z');
    hfssAssignMaterial(fid, 'sub', 'silicon_dioxide'); 
    hfssRectangle(fid, 'gnd', 'Z', [-765, -765, 0], 1530,  1530, 'um');
    hfssCylinder(fid, 'dpole', 'Z', [0, 0, 0], 5, 74, 'um');
    hfssAssignMaterial(fid, 'dpole', 'pec'); 
    hfssCircle(fid, 'excit', 'Z', [0, 0, 0], 13, 'um');
    hfssSubtract(fid, {'gnd'}, {'excit'},'true');
    hfssAssignPE(fid, 'gnd', {'gnd'}, false);
    hfssBox(fid, 'rad', [-865, -865, -100], [1730, 1730, 230], 'um');
    hfssAssignRadiation(fid, 'rad1', 'rad');
    hfssAssignLumpedPort(fid, 'LumpedPort', 'excit', [0, 13, 0],[0, 5, 0], 'um', 50, 0);
    hfssInsertSolution(fid, 'Setup1THz', 1000);
    hfssInsertFarFieldSphereSetup(fid, 'Radiation', [0,360,1],[0,360,1]);
%     hfssCreateReport(fid, 'gp1', 5, 3, 'Setup1THz', [],...
%                  'Infinite Sphere1', [], {'Theta', 'Phi', 'Freq'},...
%                  {'Theta', 'dB(GainTotal)'});
end


fclose(fid);
hfssExecuteScript(hfssExePath, tmpScriptFile);





