function [ Bits ] = RSLOS( InputBits, Register )
    for k=1:length(InputBits) 
        Bits(:,k)=xor(InputBits(:,k),xor(Register(14),Register(15))); 
        FirstBit=xor(Register(14),Register(15)); 
        for l = length(Register)-1 : -1 :1 
            Register(l+1)=Register(l); 
        end 
        Register(1)=FirstBit; 
    end
end

