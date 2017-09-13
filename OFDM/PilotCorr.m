function NumStart=PilotCorr(MedF,Index_Pilot)

for k = 1:623
    CoefCorr(k) = sum(abs(MedF(Index_Pilot+k)));
end

NumStart = find(CoefCorr == max(CoefCorr));
end