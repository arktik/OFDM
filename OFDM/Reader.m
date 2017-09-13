function [ InputBits, AddZeroes ] = Reader ( FileNameInput, Nsk,...
    Index_Inform )
    InputFile = fopen(FileNameInput, 'r', 'b');
    FileInt = fread(InputFile, 'uint8');
    ByteFile = de2bi(FileInt,8).';
    fclose(InputFile);
    [Size1, Size2] = size(ByteFile);
    Size = Size1*Size2;
    InputBits = reshape(ByteFile, [1, Size]);
    
   
    
    k = mod(Size, length(Index_Inform)*log2(Nsk));
    if  k ~= 0
        AddZeroes = length(Index_Inform)*log2(Nsk) - k;
        InputBits = [InputBits zeros(1,AddZeroes)];
    else
        AddZeroes = 0;
    end
end

