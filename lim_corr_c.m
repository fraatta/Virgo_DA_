function lim_corr_f(in,sour_inj, a,TFFT, file2save)
%The function injects a signal, using a source toy model given in input, 
% then it corrects the data changing the frequency of the source toy model, in the range of 
%7 bins to the right and to the left, for each parameter
% Then, for each case, it calculates CR and SNR.
n=n_gd(in);
dx=dx_gd(in);
if TFFT==-1
tfft=n*dx;
else
    tfft=TFFT;
end
bin_size=1/tfft;

A=5*10^(a);
sin=bsd_softinj_re_mod(in, sour_inj, A);
in_c_g= bsd_dopp_sd(sin,sour_inj);
cont=cont_gd(in_c_g);
t0=cont.t0;
sour_tempt0=new_posfr(sour_inj,t0); 
tab=table();
i=0;
for c=1:41
        sour_temp=sour_inj;
        sour_temp.f0= sour_inj.f0 +(c-21)*bin_size/3;
        in_c= bsd_dopp_sd(sin,sour_temp);
        cont=cont_gd(in_c);
        t0=cont.t0;
        sour_tempt0=new_posfr(sour_temp,t0);
        out_b_tot=postfu_wrapper(in_c,TFFT, sour_tempt0, 'ligoh', 30000);
        i=i+1;
        tab.f0(i)=sour_temp.f0;
        tab.cr(i)=out_b_tot.cr;
        tab.SNR(i)=out_b_tot.SNR.SNR;
   end

save(file2save, 'tab');
