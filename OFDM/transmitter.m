%%модулятор
function Signal  = transmitter()
load("MainParameters.mat",'Nc','NumbOfSymbol','Nsk','NcInf','Register','coding_mode','SpOfCod');
NumbOfZer = [];
[ Index_Inform , Index_Pilot ] = FormIndex ( Nc ); %формирование индексов для пилотных и информационных несущих
%InputBits = randi( [0,1], 1, SpOfCod^coding_mode * NumbOfSymbol*NcInf*log2(Nsk) );%генерирование сообщения.
InputBits = genMess(NumbOfSymbol ,Nsk,NcInf);
if coding_mode == 1
    CurrBits = [];
    save('InputBits.mat','InputBits')
    for GrOfBits = 1:BitMess:length(InputBits)
        CurrGrOfBits =  encode(InputBits(GrOfBits:GrOfBits+BitMess-1)',EncBitMess,BitMess,'hamming/binary')';
        CurrBits = [CurrBits CurrGrOfBits];
    end
    InputBits = CurrBits;
else
    save('InputBits.mat','InputBits')
end

for k= 1 : NumbOfSymbol
    Bits(k,:) = RSLOS( InputBits((k-1)*NcInf*log2(Nsk)+1:k*NcInf*log2(Nsk)), Register );%РСЛОС
    %каждый символ поочереди прогоняем через РСЛОС с заданным исходным состоянием
end

[InformF, AmpPilot]= Mapper(Bits, Nsk);%Формирование IQ для OFDM символа в частот области baseband 
[MedSignalInF, Signal] = Inform_And_Pilot(InformF, Index_Inform, Index_Pilot,AmpPilot);%построение сигнала во временной области. 

save("TransParams.mat",'NumbOfZer','Index_Inform','Index_Pilot','AmpPilot')
%%
%квадратурная модуляция
%x= 0:length(SignalTs)-1;
%xi=0:1/((Fmain+DeltaFmain)*2/DeltaFmain):length(SignalTs)-1;
%y=sin(Fmain*x);
%yiReal = interp1(x, real(SignalTs), xi);
%yiImag = interp1(x, imag(SignalTs), xi);
%GeterodinReal = sin((Fmain+DeltaFmain)*2)

end