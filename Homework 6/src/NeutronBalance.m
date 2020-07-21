function [change, enrichment] = NeutronBalance(flux,change,enrichment,enrichment_1,diffusion_coefficient)

    global sigma_f
    global deltax

    fiss = 0;
    absorb = 0;
    for i=2:length(flux)
        fiss=fiss+flux(i)*sigma_f(i); %200*10^-13 --> J/fission
        absorb=absorb+flux(i)*diffusion_coefficient(i);
    end
    J=-diffusion_coefficient(2)*(flux(1)-flux(2))/deltax;
    J=J*2;
    balance = fiss-absorb-J;


        if balance<0
            enrichment = enrichment+change;
        else
            enrichment = enrichment-change;
        end

    change=abs(enrichment-enrichment_1)/2;



end