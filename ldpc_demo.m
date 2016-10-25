clear all;
clc;

%rate = (cols-rows)/cols;
rows=500;
cols=1000;

%����H����
H=genH(rows,cols);

nerr = 0;    %ͳ�ƴ��������
fnum = 50;   %�����ظ�ѭ������
for i=1:fnum
    s=round(rand(1, cols-rows));

    %ʹ��H�������LDPC����
    [u,P,rearranged_cols]=ldpc_encode(s,H);

    SNR=3;
    amp=1;
    tx_waveform=bpsk(u,amp);
    rx_waveform=awgn(tx_waveform,SNR);
    scale(1:length(u))=1;  %No fading.

    %LDPC����
    rx_waveform=reorder_bits(rx_waveform,rearranged_cols);%������
    [uhat vhat]=ldpc_decode(rx_waveform,SNR,amp,scale,H,rearranged_cols);

    errmax=find(s~=uhat);
    fprintf('\n%d frames transmitted, ber = %8.4e .\n', i, length(errmax)/length(s));
    nerr = nerr + length(errmax);
    fprintf('errmax = %d, nerr = %d\n', length(errmax),nerr);
    fprintf('Average ber = %8.4e .\n', nerr/i/length(s));
end