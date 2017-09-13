function [ Position ] = FindTs( AbsAutoCorr, LevelOfIncreasing )
    [MaxAmp, MaxIndex] = max(AbsAutoCorr());
    CutLevel = MaxAmp*(10^(-(LevelOfIncreasing/20)));
    l = 1; m = 1;
    while ((l ~= 0) || (m ~= 0))
        if ((l ~=0) && ((AbsAutoCorr(MaxIndex + l) < CutLevel)))
            RightCut = MaxIndex + l;
            l = 0;
        elseif (l ~=0)
            l = l + 1;
        end
        if ((m ~=0) && (AbsAutoCorr(MaxIndex - m) < CutLevel))
            LeftCut = MaxIndex - m;
            m = 0;
        elseif (m ~=0)
            m = m + 1;
        end
    end
    Position = fix((LeftCut + RightCut)/2);
end

