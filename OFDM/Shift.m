function [ IQ_Ts_Shift ] = Shift( SignalTs, w, Nfft )
        I = real(SignalTs);
        Q = imag(SignalTs);    
    for k = 1:length(SignalTs)
        NewI(k) = I(k)*cos(2*pi*w*(k-1)/Nfft) -...
                Q(k)*sin(2*pi*w*(k-1)/Nfft);
        NewQ(k) = Q(k)*cos(2*pi*w*(k-1)/Nfft) +...
                I(k)*sin(2*pi*w*(k-1)/Nfft);
    end
    IQ_Ts_Shift = complex(NewI, NewQ);
end