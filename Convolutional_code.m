function Coded_bits=Convolutional_code(Bits,Block_Num)
Coded_bits=zeros([1,8,Block_Num]);
%State0=00, State1=10, State2=01, State3=11
for i=1:Block_Num
    State=0;
    for b=1:length(Bits(:,:,i))
        if State==0
            if Bits(:,b,i)==0
                Coded_bits(:,2*b-1,i)=0;
                Coded_bits(:,2*b,i)=0;
                State=0;
            end
            if Bits(:,b,i)==1
                Coded_bits(:,2*b-1,i)=1;
                Coded_bits(:,2*b,i)=1;
                State=1;
            end
        elseif State==1
            if Bits(:,b,i)==0
                Coded_bits(:,2*b-1,i)=1;
                Coded_bits(:,2*b,i)=0;
                State=2;
            end
            if Bits(:,b,i)==1
                Coded_bits(:,2*b-1,i)=0;
                Coded_bits(:,2*b,i)=1;
                State=3;
            end
        elseif State==2
            if Bits(:,b,i)==0
                Coded_bits(:,2*b-1,i)=1;
                Coded_bits(:,2*b,i)=1;
                State=0;
            end
            if Bits(:,b,i)==1
                Coded_bits(:,2*b-1,i)=0;
                Coded_bits(:,2*b,i)=0;
                State=1;
            end
        elseif State==3
            if Bits(:,b,i)==0
                Coded_bits(:,2*b-1,i)=0;
                Coded_bits(:,2*b,i)=1;
                State=2;
            end
            if Bits(:,b,i)==1
                Coded_bits(:,2*b-1,i)=1;
                Coded_bits(:,2*b,i)=0;
                State=3;
            end
        end
    end    
end