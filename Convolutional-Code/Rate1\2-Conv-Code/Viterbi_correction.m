% Viterbi decoder with 4 state trellis 
% Matlab can't perform drop path very well, so Viterbi algorithm is not
% manifested, instead hard coded the pathmetric 
function Corrected_bits=Viterbi_correction(Coded_bits,Block_Num,n)
PMT=zeros(1,16);%Path metric table
State=0;
Corrected_bits=zeros(1,n,Block_Num);
for i=1:Block_Num
    if State==0
        PMT(1:8)=Coded_bits(1,1,i)+Coded_bits(1,2,i);
        PMT(9:16)=2-Coded_bits(1,1,i)-Coded_bits(1,2,i);
        State=1;
    end
    if State==1
        PMT(1:4)=PMT(1:4)+Coded_bits(1,3,i)+Coded_bits(1,4,i);
        PMT(5:8)=PMT(5:8)+2-Coded_bits(1,3,i)-Coded_bits(1,4,i);
        PMT(9:12)=PMT(9:12)+1-Coded_bits(1,3,i)+Coded_bits(1,4,i);
        PMT(13:16)=PMT(13:16)+1-Coded_bits(1,4,i)+Coded_bits(1,3,i);
        State=2;
    end
    if State==2
        PMT(1:2)=PMT(1:2)+Coded_bits(1,5,i)+Coded_bits(1,6,i);
        PMT(3:4)=PMT(3:4)+2-Coded_bits(1,5,i)-Coded_bits(1,6,i);
        PMT(5:6)=PMT(5:6)+1-Coded_bits(1,5,i)+Coded_bits(1,6,i);
        PMT(7:8)=PMT(7:8)+Coded_bits(1,5,i)+1-Coded_bits(1,6,i);
        PMT(9:10)=PMT(9:10)+2-Coded_bits(1,5,i)-Coded_bits(1,6,i);
        PMT(11:12)=PMT(11:12)+Coded_bits(1,5,i)+Coded_bits(1,6,i);
        PMT(13:14)=PMT(13:14)+Coded_bits(1,5,i)+1-Coded_bits(1,6,i);
        PMT(15:16)=PMT(15:16)+1-Coded_bits(1,5,i)+Coded_bits(1,6,i);
        State=3;
    end
    if State==3
        PMT(1)=PMT(1)+Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(2)=PMT(2)+2-Coded_bits(1,7,i)-Coded_bits(1,8,i);
        PMT(3)=PMT(3)+1-Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(4)=PMT(4)+Coded_bits(1,7,i)+1-Coded_bits(1,8,i);
        PMT(5)=PMT(5)+2-Coded_bits(1,7,i)-Coded_bits(1,8,i);
        PMT(6)=PMT(6)+Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(7)=PMT(7)+Coded_bits(1,7,i)+1-Coded_bits(1,8,i);
        PMT(8)=PMT(8)+1-Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(9)=PMT(9)+Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(10)=PMT(10)+2-Coded_bits(1,7,i)-Coded_bits(1,8,i);
        PMT(11)=PMT(11)+1-Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(12)=PMT(12)+Coded_bits(1,7,i)+1-Coded_bits(1,8,i);
        PMT(13)=PMT(13)+2-Coded_bits(1,7,i)-Coded_bits(1,8,i);
        PMT(14)=PMT(14)+Coded_bits(1,7,i)+Coded_bits(1,8,i);
        PMT(15)=PMT(15)+Coded_bits(1,7,i)+1-Coded_bits(1,8,i);
        PMT(16)=PMT(16)+1-Coded_bits(1,7,i)+Coded_bits(1,8,i);
        State=0;
    end
    Position=find(PMT==min(PMT));
    Code=dec2bin(Position(1)-1,4);
    Corrected_bits(1,1,i)=str2double(Code(1));
    Corrected_bits(1,2,i)=str2double(Code(2));
    Corrected_bits(1,3,i)=str2double(Code(3));
    Corrected_bits(1,4,i)=str2double(Code(4));
end
end