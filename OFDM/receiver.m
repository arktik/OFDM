function OutpuBitsRSLOS = receiver
load("MainParameters.mat",'Nfft','LevelOfIncreasing','Nc','Nsk','NcInf','Register','coding_mode');
load('TransParams.mat','Index_Pilot','AmpPilot','Index_Inform')
load("TransmittedSignal.mat");
[ AbsAutoCorr, AutoCorr, PositionTs1 ] = FuncCorrelation(TransmittedSignal, Nfft, LevelOfIncreasing );%автокоррел€ционна€ функци€ дл€ нахождени€ начала символа
PhaseFreq =  FindOfPhase(AutoCorr, Nfft, PositionTs1); %нахождение сдвига по частоте по пику автокоррел€ционной функции
IQ_Ts_Unshifted = Shift(TransmittedSignal, PhaseFreq, Nfft);%точна€ подстройка по частоте
IQ_Ts_Unshifted(1:PositionTs1) = [];%перемещение в начало OFDM-символа

MedFunc_TSync_FreqSync = FuncTs( IQ_Ts_Unshifted, Nfft , Index_Pilot, Nc);%FFT+ груба€ подстройка по частоте + восстановение фаз по пилотным несущим
MedFunc_TSync_FreqSync = equalizer(MedFunc_TSync_FreqSync,AmpPilot,Index_Pilot);
UsedF = MedFunc_TSync_FreqSync(:,Index_Inform );%выделение информационных несущих
OutputBits =  DeMapper(UsedF, Nsk);%декодирование по созвездию
OutpuBitsRSLOS=[];
for k= 1 : length(OutputBits)/(NcInf*log2(Nsk))
    OutpuBitsRSLOS(k,:) = RSLOS(OutputBits((k-1)*NcInf*log2(Nsk)+1:k*NcInf*log2(Nsk)) , Register );%–—Ћќ—
    for i = 1:log2(Nsk)*NcInf/10
        NumPoint(k,i) = bi2de(OutpuBitsRSLOS(k,(i-1)*10+1:i*10),'left-msb');
    end
    k=k+1;%каждый символ поочереди прогон€ем через –—Ћќ— с заданным исходным состо€нием
end

OutpuBitsRSLOS = reshape(OutpuBitsRSLOS',1,size(OutpuBitsRSLOS,1)*size(OutpuBitsRSLOS,2));

%OutpuBitsRSLOS = decode(OutpuBitsRSLOS,NumbOfZer);
if coding_mode == 1
    CurrBits = [];
    for GrOfBits = 1:EncBitMess:length(OutpuBitsRSLOS)
        CurrEncBits = InputBits(GrOfBits:GrOfBits+EncBitMess-1)';
        decData = decodelin(CurrEncBits)';

       
        CurrBits = [CurrBits decData];
    end
    OutpuBitsRSLOS = CurrBits;
end

end