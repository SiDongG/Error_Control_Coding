function Corrected_bits=Hamming_correction(Coded_bits,Block_Num,k,n)
Corrected_bits=zeros(1,k,Block_Num);
H=[1 0 0 1 0 1 1;
   0 1 0 1 1 1 0;
   0 0 1 0 1 1 1];
T=[1,0,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1;
    0,0,0,0;
    0,0,0,0;
    0,0,0,0];
for i=1:Block_Num 
    if mod(Coded_bits(:,:,i)*H.',2)==[1,0,1]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,0,0,0,0,0,1],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[1,1,1]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,0,0,0,0,1,0],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[0,1,1]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,0,0,0,1,0,0],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[1,1,0]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,0,0,1,0,0,0],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[0,0,1]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,0,1,0,0,0,0],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[0,1,0]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,1,0,0,0,0,0],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[1,0,0]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[1,0,0,0,0,0,0],2);
    end
    if mod(Coded_bits(:,:,i)*H.',2)==[0,0,0]
        Corrected_bits(:,:,i)=mod(Coded_bits(:,:,i)+[0,0,0,0,0,0,0],2);
    end
end
Truncated_bits=zeros(1,n,Block_Num);
for i=1:Block_Num
    Truncated_bits(:,:,i)=Corrected_bits(:,:,i)*T;
end
Corrected_bits=Truncated_bits;
    
    
    
    