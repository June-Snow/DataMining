function ret = iDetectConfigChange(newIni, oldIni)

%% ret: 1 meaning changes detected
%        0 meaning all stay same
STAYSAME = 0;
NOTSAME = 1;

%%
newFld = fieldnames(newIni);
oldFld = fieldnames(oldIni);
if (length(oldFld) == length(newFld)) ...
      &&  (olCmp(newFld, oldFld) == 0)
    field = oldFld;
else
    ret = NOTSAME;
    return;
end

for i = 1 : length(newFld)
    if isstruct(newIni.(field{i})) && isstruct(oldIni.(field{i}))
        if(iDetectConfigChange(newIni.(field{i}), oldIni.(field{i})))
            ret = NOTSAME;
            return 
        end
    else
        if olCmp(newIni.(field{i}),  oldIni.(field{i}))
             ret = NOTSAME;
             return 
        end
    end
end

ret = STAYSAME;

end
