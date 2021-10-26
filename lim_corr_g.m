function lim_corr_g(in,sour_inj, a,TFFT,q, file2save)
%The function injects a signal, using a source toy model given in input, 
% then it corrects the data changing the frequency, the first order and the 
% second order spin down of the source toy model, in the range of 
%10 bins to the right and to the left, for each parameter
% Then, for each case, it calculates CR and SNR.
n=n_gd(in);
dx=dx_gd(in);
if TFFT==-1
   tfft=n*dx; 
else
    tfft=TFFT;
end
bin_size=1/tfft;
bin_size_df=bin_size/n/dx;
bin_size_ddf=2*bin_size/(n*dx)^2;
A=5*10^(a);
sin=bsd_softinj_re_mod(in, sour_inj, A);
in_c_g= bsd_dopp_sd(sin,sour_inj);
cont=cont_gd(in_c_g);
t0=cont.t0;
sour_tempt0=new_posfr(sour_inj,t0); 
tab=table();
i=0;
   for c=-10:10
       sour_temp=sour_inj;
        sour_temp.f0= sour_inj.f0 +q*c*bin_size;
        for b=-10:10
            sour_temp.df0= sour_inj.df0 +q*b*bin_size_df;
            for d=-10:10
        sour_temp.ddf0= sour_inj.ddf0 +q*d*bin_size_ddf;
        in_c= bsd_dopp_sd(sin,sour_temp);
        cont=cont_gd(in_c);
        t0=cont.t0;
        sour_tempt0=new_posfr(sour_temp,t0);
        out_b_tot=postfu_wrapper(in_c,TFFT, sour_tempt0, 'ligoh', 30000);
         i=i+1;
         tab.f0(i)=sour_temp.f0;
         tab.df0(i)=sour_temp.df0;
         tab.ddf0(i)=sour_temp.ddf0;
         tab.cr(i)=out_b_tot.cr;
         tab.SNR(i)=out_b_tot.SNR.SNR;
         if i==4000
             save(file2save, 'tab');
         end
            end
        end
   end
   save(file2save, 'tab');
