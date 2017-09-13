function [ MedFunc_TSync_FreqSync ] = equalizer( MedFunc_TSync_FreqSync,AmpPilot,Index_Pilot )
    for symb=1:size(MedFunc_TSync_FreqSync,1)
        KofPilot = abs(AmpPilot./MedFunc_TSync_FreqSync(symb,Index_Pilot));
          for k=1:length(Index_Pilot)-1 
            for i=1:10
                KoefAll(symb,Index_Pilot(k)+i-1)= KofPilot(k)+(KofPilot(k+1)-KofPilot(k))*(i-1)/10;
            end
          end
         %KoefAll(symb,:) = interp1(1:41,KofPilot,1:0.1:41,'PCHIP');
    end
    MedFunc_TSync_FreqSync(:,1:length(KoefAll)) = MedFunc_TSync_FreqSync(:,1:length(KoefAll)).*KoefAll;
end