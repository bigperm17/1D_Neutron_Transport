function [flux]=flux_fix(M,s)
    
    global phi0
    global phi_e

    [V, D] = eig(M);
    loc=max(max(abs(D)));

    for i=1:s
        if abs(D(i,i))==loc
            r=i;
        end
    end

    flux=zeros(1,s+2);
    for i=2:s+1
        flux(i)=V(i-1,r);
        flux(1)=phi0;
        flux(s+2)=phi_e;
    end

    P=0;
    for i=1:length(flux)
        P=P+flux(i)*sigma_f(i)*nu*200*10^-13; %200*10^-13 --> J/fission
    end
    mult=Power/P;
    flux=mult*flux;
    
end
