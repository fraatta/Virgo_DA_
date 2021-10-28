function test_sd(sour_inj,in,a, TFFT,file2save)
% The function injects a signal in the BSD, using a toy model given in input. 
% Then, it calculates SNR and CR in three different cases: not correcting the signal
% correcting stopping the taylor expansion at the first order spin down and 
%correcting stopping it at the second order spin down, using the function
%SNR_light
% Then, for each case, it calculates CR and SNR.

A=5*10^a;
sin=bsd_softinj_re_mod(in, sour_inj, A);
tab=table();
i=0;
for b=1:6
     sour_inj.ddf0=5*10^(-22-b);
   for par=1:3
    out=SNR_light(sin,sour_inj,in, a, par,TFFT);
    i=i+1;
    tab.par(i)=par;     
    tab.a_ddf0(i)=-22-b;
    tab.cr(i)=out.cr;
    tab.SNR(i)=out.SNR.SNR;
         
   end
end
save(file2save, 'tab')


