%%OFDM MODULATION
clc
clear all
%%
%�����
mode = 2; %1 - ������������� ������ �������� � ��������� �����������
          %2 - ������������� ������ � AWGN ������� � �������� [SNRMin : SNRMax]
          
coding_mode  = 0;%����� ����������������� �����������
                 %0 - ��� �����������
                 %1 - 
rng(0)       
%%
D = 7000; %���������� �� ��������� (�)
Gt=1;%����.����.�����.
G=10;%����.����.���������
Fmain = 2.4*10^9;%������� �������
DeltaFmain=2*10^7;%������ ������
T=300;%�����������
Ptrans=1;%�������� �����������
k = 1.38 * 10^(-23);%���������� ���������
c=3*10^8;%�������� �����
noise_figure=2.5;%��� ���������
Pres = c^2*Ptrans/(4*pi*Fmain*D)^2;
Pnoize = k*T*DeltaFmain;%��������� ��� �������

w = 50.1;%���� �� ������� ����� ���������� � ������������ � ����� dF - ������ ����� �������� ���������

%%
%��������� ������� OFDM
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];%������� ��� �����. ��� ������� OFDM ������� ����������.
Nsk =  64;% N-QAM  -  ����������� ��������� ��� ����������� 
Nfft = 1024;%���������� �������� ��� FFT
Nc = 401;% ���������� ���������� ������
NcPil = 41;%���������� �������� �������
NcInf = Nc-NcPil;%���������� �������������� �������
BitMess = 11;
EncBitMess = 15;
SpOfCod = BitMess/EncBitMess; %�������� ����������������� �����������
LevelOfIncreasing = 3;
NumbOfSymbol = 100; % ���������� OFDM ��������.
Tsim = 1/(DeltaFmain/Nc)*9/8;

%%
switch mode
    case 1
        save("MainParameters.mat")
        SNR=10*log10(Pres/Pnoize)-noise_figure+G;%�������� OC� �� ������ �� ���������
        ber = main(SNR)
    case 2 
        save("MainParameters.mat")
        SNR = [0:27];
        for CurrSNR = 1:length(SNR)
            ber(CurrSNR) = main(SNR(CurrSNR));    
        end
        plot(ber)
end
