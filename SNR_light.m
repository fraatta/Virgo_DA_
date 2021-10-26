function [out,sour_tempt0]=SNR_light(sin,sour_inj, in, a, par,TFFT)

cont=cont_gd(in);
t0=cont.t0;

A=5*10^(a);
 
    sour_injt0=new_posfr(sour_inj,t0);
if par==1
  out=postfu_wrapper(in,TFFT, sour_injt0, 'ligoh', 30000);
 
elseif par==2
    sour_inj.ddf0=0;
    in_c= bsd_dopp_sd(sin,sour_inj);
    out=postfu_wrapper(in_c,TFFT, sour_injt0, 'ligoh', 30000);

elseif par==3
    in_c= bsd_dopp_sd(sin,sour_inj);
    out=postfu_wrapper(in_c,TFFT, sour_injt0, 'ligoh', 30000);
    
end
