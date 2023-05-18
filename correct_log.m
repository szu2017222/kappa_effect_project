close all; clear; clc

pro_file = struct2cell(dir('*.txt'));
all_filenames = pro_file(1,:)';
loop_num = height(all_filenames);
for iter = 1:loop_num
    data = load(char(all_filenames(iter)));
    if height(unique(abs(data(:,2)))) > 2
        data(:,2) = data(:,2) - (max(data(:,2))-min(abs(data(:,2)))-1)/2;
        fid = fopen(char(all_filenames(iter)),'w+');
        [row,col] = size(data);
        for row_iter = 1:row
            for col_iter = 1:col
                if col_iter == col
                    fprintf(fid,'%g\n',data(row_iter,col_iter));
                else
                    fprintf(fid,'%g,',data(row_iter,col_iter));
                end
            end
        end
        fclose(fid);
    end
end







