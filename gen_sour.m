function sourtot=gen_sour(nsim,int) %genera sorgenti con parametri casuali

sour.fepoch=58664; %frequency epoch, 30 giugno 2019
sour.pepoch=58664; %position epoch
sour.v_a=0;         %intrinsic velocities of the source
sour.v_d=0;
sour.name='pulsar';


cosi=2*rand(nsim,1)-1;                                   %random uniform distribution for cos(i) values in [-1;1]
gamma=sqrt((1+6*cosi.^2+cosi.^4)/4);                     %conversion factor from H0 (Rome) to h (standard) amplitudes H0=h*gamma; on average (1/gamma)=1.31
eta=-2*cosi./(1+cosi.^2); 
psi=pi*0.5*rand(nsim,1)-pi*0.25; %uniformly random from -pi/4 to pi/4
f0= 10 +int*rand(nsim, 1);

for n=1:nsim
    a_h(1)=randi([0 23]);
    a_h(2)=randi([0 59]);
    a_h(3)=randi([0 59]);
    a(n)=hour2deg(a_h);
    d_1=randi([-90 89]);
    d_2=randi([0 59]);
    d_3=randi([0 59]);
    d(n)=d_1+d_2/60+d_3/3600;
    p_rsd=randi([-17 -8]);
    p_rsd2=randi([-28 -23]);
    rsd(n)=-5*10^p_rsd;
    rsd2(n)=+5*10^p_rsd2;
    
end



for m=1:nsim
    sour.a=a(m);
    sour.d=d(m);
    sour.f0=f0(m);
    sour.df0=rsd(m);
    sour.ddf0=rsd2(m);
    sour.eta=eta(m);
    sour.psi=psi(m);
    sour.gamma=gamma(m);
    sour.name=['sim_pulsar_',num2str(m)];
    sourtot(m)=sour;      %contains all the injection parameters, saved as table later
end
