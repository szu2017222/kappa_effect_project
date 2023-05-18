close all; clear; clc

%% find all .pro files
pro_file = struct2cell(dir('*.pro'));
all_filenames = pro_file(1,:)';
[sub_id,vel,exp_stage,cell_element] = cellfun(@split_filename,all_filenames,'UniformOutput',false);
sub_id = cell2mat(sub_id);
vel = cell2mat(vel);
exp_stage = cell2mat(exp_stage);
loop_num = height(sub_id);

%% loop through experiments
for loop_iter = 1:loop_num
    switch exp_stage(loop_iter)
        case 1
            read_output_exp1(vel(loop_iter),sub_id(loop_iter));
        case 2
            read_output_exp2(vel(loop_iter),sub_id(loop_iter));
    end
end



%% functions
function [sub_id,vel,exp_stage,cell_element] = split_filename(cell_element)
namestr = strsplit(cell_element,'_');
exp_stage = str2num(cell2mat(strsplit(string(namestr(1)),'Kappa3Tone')));
vel = str2num(cell2mat(strsplit(string(namestr(2)),'vel')));
sub_id = str2num(cell2mat(namestr(3)));
if isempty(vel)
    sub_id=[];vel=[];exp_stage=[];
    return
end
if exist('output_data_exp.mat')
    load('output_data_exp.mat')
    exp_stage_temp = find(output_data_exp.exp_stage==exp_stage);
    if isempty(exp_stage_temp)
        pro2txt(cell_element);
        return
    else
        id_idx_temp = find(output_data_exp.subject_id(exp_stage_temp)==sub_id);
        if isempty(id_idx_temp)
            pro2txt(cell_element);
            return
        else
            vel_idx_temp = find(output_data_exp.velocity(exp_stage_temp(id_idx_temp))==vel,1);
            if isempty(vel_idx_temp)
                pro2txt(cell_element);
                return
            end
        end
    end
    sub_id=[];vel=[];exp_stage=[];
else
    pro2txt(cell_element);
end
end

function pro2txt(namePRO)
nameTXT = [namePRO(1:end-3), 'txt'];
copyfile(namePRO,nameTXT)
end

