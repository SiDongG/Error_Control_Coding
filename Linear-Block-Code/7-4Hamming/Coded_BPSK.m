%Coded BPSK transmission in AWGN Using Systematic Hamming Code%
%Author Sidong Guo
clear;clc;close all;
k=7;
n=4;
Block_Num=5000;
Bits=randi(0:1,[1,n,Block_Num]);
G=[1 0 0 0 1 1 0;      %Hamming Code generator Matrix 
   0 1 0 0 0 1 1;
   0 0 1 0 1 1 1;
   0 0 0 1 1 0 1];

Coded_bits=zeros([1,k,Block_Num]);      %Bits initialization
for a=1:Block_Num
    Coded_bits(:,:,a)=mod(Bits(:,:,a)*G,2);
end

Symbols=qammod(Bits,2);      %BPSK modulation
Coded_Symbols=qammod(Coded_bits,2);      %BPSK modulation for coded bits

nr=randn(1,n,Block_Num);      %Noise generation
ni=randn(1,n,Block_Num);
Noise=(sqrt(2)/2)*(nr+1i*ni);
nr=randn(1,k,Block_Num);
ni=randn(1,k,Block_Num);
Noise_coded=(sqrt(2)/2)*(nr+1i*ni);

ratio=zeros(1,6);
Coded_ratio=zeros(1,6);
for SNRdb=0:2:10
    Error=0;Coded_error=0;
    SNR=10^(SNRdb/10);
    Symbols2=Symbols+(1/sqrt(SNR))*Noise;
    Coded_Symbols2=Coded_Symbols+(1/sqrt(SNR))*Noise_coded;   
    Bits_r=qamdemod(Symbols2,2);     %BPSK demodulation
    Coded_bits_r=qamdemod(Coded_Symbols2,2);     %BPSK demodulation for coded bits
    Corrected_bits=Hamming_correction(Coded_bits_r,Block_Num,k,n);     %Error correction, calling Hamming_correction function
    for count=1:Block_Num*n      %Compare and calculate bit error rate
        if Bits_r(count)~=Bits(count)
            Error=Error+1;
        end
        if Corrected_bits(count)~=Bits(count)
            Coded_error=Coded_error+1;
        end
    end
    ratio(SNRdb/2+1)=Error/(Block_Num*n);
    Coded_ratio(SNRdb/2+1)=Coded_error/(Block_Num*n);
end

figure()     %Plot results
semilogy(0:2:10,ratio)
hold on
semilogy(0:2:10,Coded_ratio)

legend('BPSK','Coded-BPSK')
    
    
    
    
    
    
    
    