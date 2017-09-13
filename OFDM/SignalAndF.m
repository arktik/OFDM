function [ SignalInF, Signal ] = SignalAndF( MedSignalInF, Nfft, Nc )
    for k = 1: length(MedSignalInF)/Nc
        for l = 2 : Nc
            SignalInF(k,l) = MedSignalInF((l-1) + (k-1)*Nc);
        end
        SignalBySymbol(k,:) = ifft(SignalInF(k,:),Nfft);
    end
    Signal = SignalBySymbol(1,:);
    if length(MedSignalInF)/Nc > 1
        for k = 2: length(MedSignalInF)/Nc
            Signal = [ Signal SignalBySymbol(k,:) ];
        end
    end
end

