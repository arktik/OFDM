function [ Index_Inform , Index_Pilot ] = FormIndex( Nc )
    %формирование маски пилотных и информационных несущих
    Index_Pilot = 1 : 10 : Nc  ;
    Index_Inform = [];
    for k = 1 : Nc
        if (k ~= Index_Pilot(:))
            Index_Inform = [Index_Inform k ];
        end
    end
end