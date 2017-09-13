function InputBits = genMess(NumbOfSymbol ,Nsk,NcInf)
NumbOfBitsInOneMess = log2(Nsk)*NcInf;
InputBits = [];
for k = 1:NumbOfSymbol
     TextMess1 = [];
%     
%     
     for l = 1:NumbOfBitsInOneMess/10

         TextMess = de2bi(k,10,'left-msb');
         %TextMess = [1 1 1 1 1 1 1 1 1 1]; 
         TextMess1 = [TextMess1 TextMess];
%         
     end
%     
     InputBits = [InputBits TextMess1];
end






end