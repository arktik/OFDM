function [ MedSignalInF, AmpPilot] = Mapper( Bits, Nsk )
    switch Nsk
        case 4 % QPSK
            Dictionary = [ 1+1j 1-1j -1+1j -1-1j ];
            AmpPilot = 4/3*abs(Dictionary(1));
        case 16 % 16-QAM
            Dictionary = [ 3+3j 3+1j 1+3j 1+1j 3-3j 3-1j 1-3j 1-1j...
                          -3+3j -3+1j -1+3j -1+1j -3-3j -3-1j -1-3j -1-1j];
            AmpPilot = 4/3*abs(Dictionary(1));
        case 64 % 64-QAM
            Dictionary = [ 7+7j 7+5j 5+7j 5+5j 7+1j 7+3j 5+1j 5+3j 1+7j...
                           1+5j 3+7j 3+5j 1+1j 1+3j 3+1j 3+3j...
                           7-7j 7-5j 5-7j 5-5j 7-1j 7-3j 5-1j 5-3j 1-7j...
                           1-5j 3-7j 3-5j 1-1j 1-3j 3-1j 3-3j...
                           -7+7j -7+5j -5+7j -5+5j -7+1j -7+3j -5+1j...
                           -5+3j...
                           -1+7j -1+5j -3+7j -3+5j -1+1j -1+3j -3+1j...
                           -3+3j...
                           -7-7j -7-5j -5-7j -5-5j -7-1j -7-3j -5-1j...
                           -5-3j -1-7j -1-5j -3-7j -3-5j -1-1j -1-3j...
                           -3-1j -3-3j];
                AmpPilot = 4/3*abs(Dictionary(1));
    end
    MedSignalInF = [];
    
    for l=1:size(Bits,1)    
        n = 1;
        for k = 1 : log2(Nsk) : length(Bits(l,:)) - log2(Nsk) + 1
            Numb = bin2dec(int2str(Bits(l,k : k + log2(Nsk) - 1))) + 1;
            MedSignalInF(l,n) = Dictionary(Numb);
            n = n + 1;
        end
    end    
end
