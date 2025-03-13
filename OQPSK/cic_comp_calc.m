R=4; %%decimation factor
M=1; %%diff delay
N=5; %%number of stages
B=25; %%coeff bit width
Fs = 30720000; %%sampling freq before decimatiuon
%%Fc = 0.1e6;
Fc = 0.53*Fs/(R*2);

L = 401;%%order
Fo = R*Fc/Fs; %%normalized cutoff freq

p = 2e3;
s = 0.25/p;
fp = [0:s:Fo];
fs = (Fo + s):s:0.5;
f = [fp fs]*2;
Mp = ones(1,length(fp));
Mp(2:end) = abs(M*R*sin(pi*fp(2:end)/R)./sin(pi*M*fp(2:end))).^N;
Mf = [Mp zeros(1,length(fs))];
f(end) = 1;
h = fir2(L,f,Mf);
h = h/max(h);
hz = round(h*power(2,B-1)-1);
disp(hz);

kd = 1.0; 
ko = 1.0; 
wp = 2.0*3.14*50.0; 
zeta = 0.5; 
Fs = 30.72E6; 
T = 1.0/Fs; 
f0 = 256000.0; %частота сигнала 
phi = -1.5;
df = 4.0; 
fg = f0-df; 

g1 = 2.0*(1.0 - exp(-wp*zeta*T)*cos(wp*sqrt(1.0-zeta*zeta)*T));
g2 = exp(-2.0*wp*zeta*T)-1.0+g1;

ki = 1*g2/(ko*kd);
kp = 1*g1/(ko*kd);

disp(ki);
disp(kp);

disp(g1);
disp(g2);

fid = fopen('cic_test11.txt','wb');
%%count = fwrite(fid,hz,'char');
fprintf(fid,'%i,',hz);
fclose('all');

rf = 0.5;

sps = 25;  
span = 12; 

h1 = rcosdesign(rf,span,sps,"normal");
h3 = rcosdesign(rf, span, sps, "sqrt");

%disp(h3);

fid = fopen('cic_test111.txt','wb');
fprintf(fid,'%i,',h3);
fclose('all');
%impz(h3)