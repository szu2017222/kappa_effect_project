function read_output_exp2(velocity,subjectID)
% filenames
filename_pro = ['Kappa3Tone2_vel',num2str(velocity),'_',num2str(subjectID),'_protocol.txt'];
filename_log = ['Kappa3Tone2_vel',num2str(velocity),'_',num2str(subjectID),'_log.txt'];
% read files
output_protocol = read_protocol(filename_pro);
output_log = read_log(filename_log);
output_data_block = [output_protocol,output_log];
block_num = height(output_data_block);
% experiment parameters
blocks_per_exp = 10;
trials_per_block = 32;
time_cond_num = 8;
time_conds = [-58.24 -43.68 -29.12 -14.56 14.56 29.12 43.68 58.24];
time_cond_strs = ["time_neg16","time_neg12","time_neg8","time_neg4","time_pos4","time_pos8","time_pos12","time_pos16"];
pitch_cond_num = 4;
pitch_conds_temp = [-2 -1 1 2];
pitch_cond_strs_temp = ["pitch_neg2","pitch_neg1","pitch_pos1","pitch_pos2"];
switch velocity
    case 6
        pitch_conds = [-5 -4 4 5];
        pitch_cond_strs = ["pitch_neg5","pitch_neg4","pitch_pos4","pitch_pos5"];
    case 8
        pitch_conds = [-7 -6 6 7];
        pitch_cond_strs = ["pitch_neg7","pitch_neg6","pitch_pos6","pitch_pos7"];
    case 14
        pitch_conds = [-11 -10 10 11];
        pitch_cond_strs = ["pitch_neg11","pitch_neg10","pitch_pos10","pitch_pos11"];
    case 18
        pitch_conds = [-14 -13 13 14];
        pitch_cond_strs = ["pitch_neg14","pitch_neg13","pitch_pos13","pitch_pos14"];
end
shortlong_button = 1;
longshort_button = 2;

%% analyze response
% correct response regardless condition
output_data_block.correct = repmat({[]},block_num,1);
% long-short response regardless if correct
output_data_block.longshort = repmat({[]},block_num,1);
% table template with all conditions
table_template_temp = table('Size',[time_cond_num pitch_cond_num],'VariableTypes',repmat("double",pitch_cond_num,1),'VariableNames',pitch_cond_strs_temp,'RowNames',time_cond_strs);
table_template = table('Size',[time_cond_num pitch_cond_num],'VariableTypes',repmat("double",pitch_cond_num,1),'VariableNames',pitch_cond_strs,'RowNames',time_cond_strs);
output_data_block.conditions = repmat({table_template_temp},block_num,1);
output_data_block.condition_correct = repmat({table_template_temp},block_num,1);
output_data_block.condition_longshort = repmat({table_template_temp},block_num,1);

% output_data_block.longshort_ratio = zeros(block_num,1);

for block_iter = 1:block_num
output_data_block.correct{block_iter,1} = find(output_data_block.response{block_iter,1} == output_data_block.true_response{block_iter,1});
output_data_block.longshort{block_iter,1} = find(output_data_block.response{block_iter,1} == longshort_button);
% output_data_block.longshort_ratio(block_iter) = height(output_data_block.longshort{block_iter,1})/trials_per_block;

for pitch_iter = pitch_conds
for time_iter = time_conds
switch pitch_iter
case pitch_conds(1)
output_data_block.conditions{block_iter,1}.pitch_neg2(time_cond_strs(time_conds==time_iter)) = find(output_data_block.timeoffset{block_iter,1} == time_iter & output_data_block.pitchoffset{block_iter,1} == pitch_iter);
output_data_block.condition_correct{block_iter,1}.pitch_neg2(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_neg2(time_cond_strs(time_conds==time_iter)),output_data_block.correct{block_iter,1});
output_data_block.condition_longshort{block_iter,1}.pitch_neg2(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_neg2(time_cond_strs(time_conds==time_iter)),output_data_block.longshort{block_iter,1});
case pitch_conds(2)
output_data_block.conditions{block_iter,1}.pitch_neg1(time_cond_strs(time_conds==time_iter)) = find(output_data_block.timeoffset{block_iter,1} == time_iter & output_data_block.pitchoffset{block_iter,1} == pitch_iter);
output_data_block.condition_correct{block_iter,1}.pitch_neg1(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_neg1(time_cond_strs(time_conds==time_iter)),output_data_block.correct{block_iter,1});
output_data_block.condition_longshort{block_iter,1}.pitch_neg1(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_neg1(time_cond_strs(time_conds==time_iter)),output_data_block.longshort{block_iter,1});
case pitch_conds(3)
output_data_block.conditions{block_iter,1}.pitch_pos1(time_cond_strs(time_conds==time_iter)) = find(output_data_block.timeoffset{block_iter,1} == time_iter & output_data_block.pitchoffset{block_iter,1} == pitch_iter);
output_data_block.condition_correct{block_iter,1}.pitch_pos1(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_pos1(time_cond_strs(time_conds==time_iter)),output_data_block.correct{block_iter,1});
output_data_block.condition_longshort{block_iter,1}.pitch_pos1(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_pos1(time_cond_strs(time_conds==time_iter)),output_data_block.longshort{block_iter,1});
case pitch_conds(4)
output_data_block.conditions{block_iter,1}.pitch_pos2(time_cond_strs(time_conds==time_iter)) = find(output_data_block.timeoffset{block_iter,1} == time_iter & output_data_block.pitchoffset{block_iter,1} == pitch_iter);
output_data_block.condition_correct{block_iter,1}.pitch_pos2(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_pos2(time_cond_strs(time_conds==time_iter)),output_data_block.correct{block_iter,1});
output_data_block.condition_longshort{block_iter,1}.pitch_pos2(time_cond_strs(time_conds==time_iter)) = ismember(output_data_block.conditions{block_iter,1}.pitch_pos2(time_cond_strs(time_conds==time_iter)),output_data_block.longshort{block_iter,1});
end
end
end
output_data_block.conditions{block_iter,1} = renamevars(output_data_block.conditions{block_iter,1},pitch_cond_strs_temp,pitch_cond_strs);
output_data_block.condition_correct{block_iter,1} = renamevars(output_data_block.condition_correct{block_iter,1},pitch_cond_strs_temp,pitch_cond_strs);
output_data_block.condition_longshort{block_iter,1} = renamevars(output_data_block.condition_longshort{block_iter,1},pitch_cond_strs_temp,pitch_cond_strs);

end

%% combine blocks in one experiment
exp_labels = unique(output_data_block.exp_label);
exp_num = height(exp_labels);
output_data_exp = table(exp_labels);
output_data_exp = renamevars(output_data_exp,'exp_labels','exp_label');
output_data_exp.exp_stage = zeros(exp_num,1);
output_data_exp.subject_id = zeros(exp_num,1);
output_data_exp.velocity = zeros(exp_num,1);
output_data_exp.condition_accuracy = repmat({table_template},exp_num,1);
output_data_exp.condition_longshort_ratio = repmat({table_template},exp_num,1);
for exp_iter = 1:exp_num
    temp_idx = strcmp(output_data_block.exp_label,exp_labels(exp_iter));
    if sum(temp_idx)>blocks_per_exp
        error('error,block_num > 10')
    end
    output_data_block_temp = output_data_block(temp_idx,:);
    exp_accuracy = zeros(time_cond_num, pitch_cond_num);
    exp_longshort_ratio = zeros(time_cond_num, pitch_cond_num);
    for block_iter = 1:blocks_per_exp
    % accuracy
    exp_accuracy = exp_accuracy + table2array(output_data_block_temp.condition_correct{block_iter,1});
    % long-short ratio
    exp_longshort_ratio = exp_longshort_ratio + table2array(output_data_block_temp.condition_longshort{block_iter,1});
    end
    output_data_exp.exp_stage(exp_iter) = output_data_block_temp.exp_stage(1);
    output_data_exp.subject_id(exp_iter) = output_data_block_temp.subject_id(1);
    output_data_exp.velocity(exp_iter) = output_data_block_temp.velocity(1);
    output_data_exp.condition_accuracy{exp_iter,1} = array2table(exp_accuracy/blocks_per_exp,'VariableNames',pitch_cond_strs,'RowNames',time_cond_strs);
    output_data_exp.condition_longshort_ratio{exp_iter,1} = array2table(exp_longshort_ratio/blocks_per_exp,'VariableNames',pitch_cond_strs,'RowNames',time_cond_strs);
    output_data_exp.time_cond = {time_conds};
    output_data_exp.time_cond_str = {time_cond_strs};
    output_data_exp.pitch_cond = {pitch_conds};
    output_data_exp.pitch_cond_str = {pitch_cond_strs};
end

%% save data
% data in block
if exist('output_data_block.mat','file')
    output_data_block_old = load('output_data_block.mat');
    output_data_block = [output_data_block_old.output_data_block;output_data_block];
end
% output_data_block = sortrows(output_data_block,{'subject_id','velocity','time'});
save('output_data_block','output_data_block')
% data in experiment
if exist('output_data_exp.mat','file')
    output_data_exp_old = load('output_data_exp.mat');
    output_data_exp = [output_data_exp_old.output_data_exp;output_data_exp];
end
% output_data_exp = sortrows(output_data_exp,{'subject_id','velocity'});
save('output_data_exp','output_data_exp')
% data averaged across subjects
if exist('output_data_average.mat','file')
    load('output_data_average.mat');
    temp_idx = find(output_data_average.exp_stage==output_data_exp.exp_stage(end) & output_data_average.velocity==output_data_exp.velocity(end));
    if isempty(temp_idx)
        init_cond = output_data_exp(end,["exp_stage","velocity","condition_accuracy","condition_longshort_ratio","time_cond","time_cond_str","pitch_cond","pitch_cond_str"]);
        init_cond.sample_size = 1;
        init_cond.subject_id = num2cell(output_data_exp.subject_id(end));
        init_cond = movevars(init_cond,{'sample_size','subject_id'},'After','velocity');
        output_data_average = [output_data_average;init_cond];
    else
        output_data_average.subject_id(temp_idx) = {[cell2mat(output_data_average.subject_id(temp_idx));output_data_exp.subject_id(end)]};
        output_data_average.condition_accuracy{temp_idx,1} = array2table((table2array(output_data_average.condition_accuracy{temp_idx,1})*output_data_average.sample_size(temp_idx) + table2array(output_data_exp.condition_accuracy{end,1}))/(output_data_average.sample_size(temp_idx)+1),'VariableNames',pitch_cond_strs,'RowNames',time_cond_strs);
        output_data_average.condition_longshort_ratio{temp_idx,1} = array2table((table2array(output_data_average.condition_longshort_ratio{temp_idx,1})*output_data_average.sample_size(temp_idx) + table2array(output_data_exp.condition_longshort_ratio{end,1}))/(output_data_average.sample_size(temp_idx)+1),'VariableNames',pitch_cond_strs,'RowNames',time_cond_strs);
        output_data_average.sample_size(temp_idx) = output_data_average.sample_size(temp_idx) + 1;
    end
else
    output_data_average = output_data_exp(:,["exp_stage","velocity","condition_accuracy","condition_longshort_ratio","time_cond","time_cond_str","pitch_cond","pitch_cond_str"]);
    output_data_average.sample_size = 1;
    output_data_average.subject_id = {output_data_exp.subject_id};
    output_data_average = movevars(output_data_average,{'sample_size','subject_id'},'After','velocity');
    
end
save('output_data_average','output_data_average')
end

function output_protocol = read_protocol(filename)
%% read file
pro_data = importfile(filename);
% calculate total blocks
rows_per_block_pro = 10;
block_num = height(pro_data)/rows_per_block_pro; % 10 rows each trial

%% extract info
% time
time = cellstr(table2array(pro_data(3:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure')));
% subject id and experiment stage
id_str = cellstr(char(table2array(pro_data(4:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure'))));
%%%%%%%%%%%%%%% need to make sure the format of the subject label
subject_id = [];
exp_stage = [];
for block_iter = 1:block_num
    temp_strs = strsplit(char(id_str(block_iter,:)),'_');
    subject_id(end+1) = str2num(char(temp_strs(3)));
    exp_stage(end+1) = str2num(cell2mat(strsplit(char(temp_strs(1)),'Kappa3Tone')));
end
% velocity
velocity = str2num(char(table2array(pro_data(5:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure'))));
% experiment label
exp_label = cellstr([repmat('Exp',block_num,1),num2str(exp_stage'),repmat('_Sub',block_num,1),num2str(subject_id'),repmat('_Vel',block_num,1),num2str(velocity)]);
% signalpos
signalpos = num2cell(str2num(char(table2array(pro_data(6:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure'))))',1);
% response
response = num2cell(str2num(char(table2array(pro_data(7:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure'))))',1);
% measure points
measure_points = num2cell(str2num(char(table2array(pro_data(8:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure'))))',1);
% procedure
procedure = num2cell(str2num(char(table2array(pro_data(9:rows_per_block_pro:height(pro_data),'StandardProtocolFileGeneratedByMatlabAfcProcedure'))))',1);

%% make table to store data
output_protocol = table(exp_label,exp_stage',subject_id',velocity,time,signalpos',response',measure_points',procedure');
output_protocol = renamevars(output_protocol,[2:3 6:9],["exp_stage","subject_id","signalpos","response","measure_points","procedure"]);
end

function output_log = read_log(filename)
%% load log file
log_data = importdata(filename);

%% separate blocks
rows_per_block_log = 32;
block_num = length(unique(log_data(:,6)));
timeoffset = [];
pitchoffset = [];
midfreqtone = [];
durAX = [];
durXB = [];
for block_iter = 1:block_num
    % time shift of target tone from midpoint (in ms)
    timeoffset = [timeoffset,log_data(rows_per_block_log*(block_iter-1)+1:rows_per_block_log*block_iter,1)];
    % pitch shift of target tone from midpoint (in semitone)
    pitchoffset = [pitchoffset,log_data(rows_per_block_log*(block_iter-1)+1:rows_per_block_log*block_iter,2)];
    % frequency of the target tone (in Hz)
    midfreqtone = [midfreqtone,log_data(rows_per_block_log*(block_iter-1)+1:rows_per_block_log*block_iter,3)];
    % interonset interval between first and mid tone (in ms)
    durAX = [durAX,log_data(rows_per_block_log*(block_iter-1)+1:rows_per_block_log*block_iter,4)];
    % interonset interval between mid and last tone (in ms)
    durXB = [durXB,log_data(rows_per_block_log*(block_iter-1)+1:rows_per_block_log*block_iter,5)];
end
% correct response
correctresp = timeoffset;
correctresp(correctresp>0) = 2;
correctresp(correctresp<0) = 1;
%% make table
output_log = table(num2cell(timeoffset,1)',num2cell(pitchoffset,1)',num2cell(midfreqtone,1)',num2cell(durAX,1)',num2cell(durXB,1)',num2cell(correctresp,1)');
output_log = renamevars(output_log,1:6,["timeoffset","pitchoffset","midfreqtone","durAX","durXB","true_response"]);
end

function Kappa3Tone1vel6protocol = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  KAPPA3TONE1VEL6PROTOCOL = IMPORTFILE(FILENAME) reads data from text
%  file FILENAME for the default selection.  Returns the data as a table.
%
%  KAPPA3TONE1VEL6PROTOCOL = IMPORTFILE(FILE, DATALINES) reads data for
%  the specified row interval(s) of text file FILENAME. Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  Kappa3Tone1vel6protocol = importfile("/Users/yinzhiqing/Documents/mehta lab/with carrie/example files/20230321/Kappa3Tone1_vel6_protocol.txt", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 03-Apr-2023 15:41:16

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 1);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = "StandardProtocolFileGeneratedByMatlabAfcProcedure";
opts.VariableTypes = "categorical";

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "StandardProtocolFileGeneratedByMatlabAfcProcedure", "EmptyFieldRule", "auto");

% Import the data
Kappa3Tone1vel6protocol = readtable(filename, opts);

end