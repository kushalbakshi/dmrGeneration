%% Demo to make a 1-min dynamic moving ripple at 96 kHz sampling rate

% Create dynamic moving ripple using script (variables in script should be
% changed according to requirements)

% This creates 3 files:
%   1. A .bin file which is the single-vector sound file
%   2. A .spr file which gives you the envelopes of all carrier frequencies
%   3. A parameter .mat file which gives you the parameters of the dynamic
%   moving ripple

make_dynamic_moving_ripple; % Parameters should be changed in this script

%% Create trigger file (3 triggers per second)
files = dir('*.bin');
for n = 1:length(files)
filename = char(files(n).name);
trigoutfile = [filename(1:length(filename)-8),'-trig.sw'];
binstimfile = [filename];
fs = 200000; % sampling rate
buffertime = 0; % number of seconds buffer time before start of stimulus and after end of stimulus
nbits = 16; % number of integer bits

make_ripple_trigger(trigoutfile, binstimfile, fs, nbits, fs*buffertime, fs*buffertime);

%% Convert .bin float file to an .sw int16 file with matching buffer time as trigger

swstimfile = [filename(1:length(filename)-8),'.sw'];
float2sw(binstimfile, swstimfile, fs*buffertime, fs*buffertime);

%% Put stim and trigger files together in a .wav file

sw2wav(swstimfile, fs, nbits, trigoutfile);
end
%% To see the envelopes for all carrier frequencies:

% load('dmr-500flo-60000fhi-4SM-40TM-40db-200000khz-48DF-15min_param.mat', 'NF', 'NT')
% stim_mat = read_entire_spr_file('dmr-500flo-60000fhi-4SM-40TM-40db-200000khz-48DF-15min.spr', NF, NT);
% 
% figure;
% imagesc(stim_mat);
% 
