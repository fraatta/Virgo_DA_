function search_cand(in,sour,ant,tfft, c1, c2, b1, b2,file2save)
% The function corrects the BSD with values of frequency 
% and a first order spin down that range around the values of 
% the candidate source. It is possible to fix the variation range.
% Then, for each case, it calculates CR and SNR.
n=n_gd(in);
dx=dx_gd(in);
bin_size=1/tfft;
bin_size_df=bin_size/(n*dx);
cont=cont_gd(in_c_g);
t0=cont.t0;
sour_tempt0=new_posfr(sour,t0); 
tab=table();
i=0;
   for c=c1:c2
       sour_temp=sour;
        sour_temp.f0= sour.f0 +(c/2)*bin_size;
        for b=b1:b2
            sour_temp.df0= sour.df0 +b*bin_size_df;
        in_c= bsd_dopp_sd(in,sour_temp);
        cont=cont_gd(in_c);
        t0=cont.t0;
        sour_tempt0=new_posfr(sour_temp,t0);
        out_b_tot=postfu_wrapper(in_c,tfft, sour_tempt0, ant, 30000);
         i=i+1;
         tab.f0(i)=sour_temp.f0;
         tab.df0(i)=sour_temp.df0;
         tab.cr(i)=out_b_tot.cr;
         tab.SNR(i)=out_b_tot.SNR.SNR;
         if i==4000
             save(file2save, 'tab');
         end
        end
   end
   save(file2save, 'tab');
