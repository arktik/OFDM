function IQ_Ts_Shift_Noise = channel(SignalTs,SNR)
    load("MainParameters.mat")
    IQ_Ts_Shift = Shift( SignalTs, w, Nfft );%��������������� ����������� � ��������� �� �������
    IQ_Ts_Shift_Noise = awgn(IQ_Ts_Shift, SNR, 'measured' );%�������� ���
    IQ_Ts_Shift_Noise = IQ_Ts_Shift_Noise + 0.2* [zeros(1,13) IQ_Ts_Shift_Noise(1:end -13)] + 0.01* [zeros(1,30) IQ_Ts_Shift_Noise(1:end -30)];
    TransmittedSignal = IQ_Ts_Shift_Noise(300:end);%������������ ������ ������.
    save('TransmittedSignal.mat','TransmittedSignal')
end