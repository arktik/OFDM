%%
%1)понять супперкадры,обучающие кадры,положение пилотных несущих
%2)доделать нормлаьно экволайзинг и многолучевое распространение
%3)Понять LDPC и принятие мягких регений.
%%
%clear all;
%clc;
function ber = main(SNR)
%%
%Передатчик
SignalTs = transmitter();
%%
%Моделирование канала.
IQ_Ts_Shift_Noise = channel(SignalTs,SNR);
%%
%Приемник
OutpuBitsRSLOS = receiver;
%%
%Вычисление ошибки

load("MainParameters.mat",'SpOfCod','coding_mode','NcInf','Nsk');
load("InputBits.mat")
NumbOfErr = sum(abs(InputBits(SpOfCod^coding_mode*NcInf*log2(Nsk)+1:end-SpOfCod^coding_mode*NcInf*log2(Nsk))- OutpuBitsRSLOS));
ber = NumbOfErr/length(OutpuBitsRSLOS);%BER

