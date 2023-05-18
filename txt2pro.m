close all; clear; clc
pro_file = struct2cell(dir('*.txt'));
all_filenames = pro_file(1,:)';
loop_num = height(all_filenames);
for iter = 1:loop_num
    name = char(all_filenames(iter));
    movefile(name,[name(1:end-3),'pro'])
end