function [ MedSignalInF, Signal ] = Inform_And_Pilot( InformF, Index_Inform,Index_Pilot,AmpPilot )
Signal = [];
load("MainParameters.mat",'Nc','NumbOfSymbol','Nfft','','','','');
for k=1:NumbOfSymbol
    numpil=1;%счетчики пилотных и информационных несущих
    numinf=1;
    for l=1:Nc
         if l==Index_Pilot(numpil)
             if rem(numpil,2) == 1
                SignalInF(k,l)= AmpPilot;
             else
                SignalInF(k,l)= -AmpPilot;
             end
             numpil=numpil+1;
         else
            SignalInF(k,l)= InformF(k,numinf);
            numinf=numinf+1;
         end
     end
end
        MedSignalInF = [zeros(NumbOfSymbol,1) SignalInF zeros(NumbOfSymbol,Nfft - Nc - 1)];
        
      
        for k = 1 :NumbOfSymbol
             
             CurrSig = ifft(MedSignalInF(k,:));
             CurrSig = [CurrSig(Nfft-Nfft/8+1:Nfft) CurrSig] ;
             if ~isempty(Signal)
                 p = length(Signal);
                 for n = 1:Nfft/8/4
                     CurrSig(n) = Signal(p)* cos(pi/2*n/(Nfft/8/4))^2+CurrSig(n)*cos(pi/2*(1-n/(Nfft/8/4)))^2;
                 end
             end
             Signal = [Signal CurrSig];
             
        end
        save('signal.mat','Signal');
         SignalFortrans = [real(Signal') imag(Signal') real(Signal') imag(Signal')];
          
          fid = fopen('SignalFortrans.txt','wt'); 
          for NumOfSamp = 1:length(Signal) 
              fprintf(fid,'%f,%f,%f,%f\n',[real(Signal(NumOfSamp)) imag(Signal(NumOfSamp)) real(Signal(NumOfSamp)) imag(Signal(NumOfSamp))]);
          end
          fclose(fid);
end


