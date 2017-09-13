clc
clear all
load('TransmittedSignal.csv')
TransmittedSignal = [TransmittedSignal(:,1)-1i*TransmittedSignal(:,2)]';
save('TransmittedSignal.mat','TransmittedSignal')
OutpuBitsRSLOS = receiver;
load("InputBits.mat")
% while bi2de(InputBits(1:10),'left-msb') ~=  bi2de(OutpuBitsRSLOS(1:10),'left-msb')
%     InputBits = [InputBits(2161:end) InputBits(1:2160)];
%         
% end 
 for n=1:length(OutpuBitsRSLOS)/2160
     NumbErrorInSymb(n) = sum(abs(InputBits((n-1)*2160+1:n*2160) -OutpuBitsRSLOS((n-1)*2160+1:n*2160) ));
 end


fullerr = sum(NumbErrorInSymb);
ber = fullerr/length(OutpuBitsRSLOS);%BER

