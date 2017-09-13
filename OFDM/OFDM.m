%%OFDM MODULATION
clc
clear all
%%
%Режим
mode = 2; %1 - моделирование канала передачи с заданными параметрами
          %2 - моделирование канала с AWGN лежащим в пределах [SNRMin : SNRMax]
          
coding_mode  = 0;%режим помехоустойчивого кодирования
                 %0 - без кодирования
                 %1 - 
rng(0)       
%%
D = 7000; %расстояние до приемника (м)
Gt=1;%коэф.усил.перед.
G=10;%коэф.усил.приемника
Fmain = 2.4*10^9;%несущая частота
DeltaFmain=2*10^7;%полоса частот
T=300;%температура
Ptrans=1;%мощность передатчика
k = 1.38 * 10^(-23);%постоянная больцмана
c=3*10^8;%скорость света
noise_figure=2.5;%шум источника
Pres = c^2*Ptrans/(4*pi*Fmain*D)^2;
Pnoize = k*T*DeltaFmain;%полосовой шум системы

w = 50.1;%сдвг по частоте между приемником и передатчиком в долях dF - разнос между несущими частотами

%%
%параметры системы OFDM
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];%регистр для РСЛОС. для каждого OFDM символа одинаковый.
Nsk =  64;% N-QAM  -  обозначение созвездия для кодирования 
Nfft = 1024;%количество отсчетов для FFT
Nc = 401;% количество поднесущих частот
NcPil = 41;%количество пилотных несущих
NcInf = Nc-NcPil;%количество информационных несущих
BitMess = 11;
EncBitMess = 15;
SpOfCod = BitMess/EncBitMess; %скорость помехозащищенного кодирования
LevelOfIncreasing = 3;
NumbOfSymbol = 100; % количество OFDM символов.
Tsim = 1/(DeltaFmain/Nc)*9/8;

%%
switch mode
    case 1
        save("MainParameters.mat")
        SNR=10*log10(Pres/Pnoize)-noise_figure+G;%значение OCШ на выходе из приемника
        ber = main(SNR)
    case 2 
        save("MainParameters.mat")
        SNR = [0:27];
        for CurrSNR = 1:length(SNR)
            ber(CurrSNR) = main(SNR(CurrSNR));    
        end
        plot(ber)
end
