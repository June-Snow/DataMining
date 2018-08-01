function olStruct2ini(filename,Structure)

%%
% Open file, or create new file, for writing
% discard existing contents, if any.
fid = fopen(filename,'w'); 

Sections = fieldnames(Structure);                     % returns the Sections % 获得域名元胞数组

for i=1:length(Sections)
   Section = char(Sections(i));                       % convert to character
   
   fprintf(fid,'\n[%s]\n',Section);                       % output [Section]
   
   member_struct = Structure.(Section);               % returns members of Section
   if ~isempty(member_struct)                         % check if Section is empty
      member_names = fieldnames(member_struct);
      for j=1:length(member_names)
         member_name = char(member_names(j));
         member_value = Structure.(Section).(member_name);
         
         fprintf(fid,'%s=%s\n',member_name,member_value); % output member name and value
         
      end % for-END (Members)
   end % if-END
end % for-END (Sections)

fclose(fid); % close file