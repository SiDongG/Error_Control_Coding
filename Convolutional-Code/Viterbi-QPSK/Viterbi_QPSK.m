
%Convolutional Coded QPSK using Viterbi Decoder (4-state trellis)
%Author: Sidong Guo 
%Date Feb 18th 
clear;clc;close all;
tb=2;
n=4;
Block_Num=5000;
Bits=randi(0:1,[1,n,Block_Num]);
Trellis=poly2trellis(3,[7,5]);
Coded_bits=zeros(1,n/0.5,Block_Num);

for i=1:Block_Num
    Coded_bits(:,:,i)=convenc(Bits(:,:,i),Trellis);
end
Premod_bits=zeros(1,n,Block_Num);
Premod_bits2=zeros(1,n/2,Block_Num);
for i=1:Block_Num
    b=1;
    while b<length(Coded_bits(:,:,i))
        Premod_bits(:,(b+1)/2,i)=bin2dec(num2str(Coded_bits(:,b:b+1,i)));
        b=b+2;
    end
end
for i=1:Block_Num
    b=1;
    while b<length(Bits(:,:,i))
        Premod_bits2(:,(b+1)/2,i)=bin2dec(num2str(Bits(:,b:b+1,i)));
        b=b+2;
    end
end
Coded_Symbols=qammod(Premod_bits,4)*sqrt(0.5);
Symbols=qammod(Premod_bits2,4)*sqrt(0.5);

nr=randn(1,n,Block_Num);
ni=randn(1,n,Block_Num);
Noise_coded=(sqrt(2)/2)*(nr+1i*ni);
nr=randn(1,n/2,Block_Num);
ni=randn(1,n/2,Block_Num);
Noise=(sqrt(2)/2)*(nr+1i*ni);

ratio=zeros(1,6);
Coded_ratio=zeros(1,6);
Precorrect_bits=zeros(1,2*n,Block_Num);
Decoded=zeros(1,n,Block_Num);
Corrected_bits=zeros(1,n,Block_Num);
for SNRdb=0:2:10
    disp(SNRdb);
    Coded_error=0;
    SNR=10^(SNRdb/10);
    Symbols2=Symbols+(1/sqrt(SNR))*Noise;
    Coded_Symbols2=Coded_Symbols+(1/sqrt(SNR))*Noise_coded;
    Decoded_Symbol=qamdemod(Symbols2,4);
    Decoded_Symbol2=qamdemod(Coded_Symbols2,4);
    for i=1:Block_Num
        for b=1:length(Decoded_Symbol(:,:,i))
            c=dec2bin(Decoded_Symbol(:,b,i),2);
            Decoded(:,(2*b-1):(2*b),i)=[str2double(c(1)),str2double(c(2))];
        end
    end
    for i=1:Block_Num
        for b=1:length(Decoded_Symbol2(:,:,i))
            a=dec2bin(Decoded_Symbol2(:,b,i),2);
            Precorrect_bits(:,(2*b-1):(2*b),i)=[str2double(a(1)),str2double(a(2))];
        end
    end
    for i=1:Block_Num
        Corrected_bits(:,:,i)=vitdec(Precorrect_bits(:,:,i),Trellis,tb,'trunc','hard');
    end
    ratio(SNRdb/2+1)=sum(sum(Decoded~=Bits))/(Block_Num*n);
    Coded_ratio(SNRdb/2+1)=sum(sum(Corrected_bits~=Bits))/(Block_Num*n);
end

figure()  
semilogy(0:2:10,ratio)
hold on 
semilogy(0:2:10,Coded_ratio)
xlabel('SNRdB')
ylabel('BER')
legend('QPSK','Coded-QPSK')
