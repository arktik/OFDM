%%
%1)������ �����������,��������� �����,��������� �������� �������
%2)�������� ��������� ����������� � ������������ ���������������
%3)������ LDPC � �������� ������ �������.
%%
%clear all;
%clc;
function ber = main(SNR)
%%
%����������
SignalTs = transmitter();
%%
%������������� ������.
IQ_Ts_Shift_Noise = channel(SignalTs,SNR);
%%
%��������
OutpuBitsRSLOS = receiver;
%%
%���������� ������

load("MainParameters.mat",'SpOfCod','coding_mode','NcInf','Nsk');
load("InputBits.mat")
NumbOfErr = sum(abs(InputBits(SpOfCod^coding_mode*NcInf*log2(Nsk)+1:end-SpOfCod^coding_mode*NcInf*log2(Nsk))- OutpuBitsRSLOS));
ber = NumbOfErr/length(OutpuBitsRSLOS);%BER

