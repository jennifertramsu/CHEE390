%%
%%%%% CHAPTER 1 - Starting with Matlab

%% Command Window
% Comment with %
% Suppress outputs with ;
% Clear command window with clc

%% Display Formats
% Default is short (4 dp)
% Change with format command
% --> format long (15 dp)
% --> format short e (e indicates scientific notation)
% --> format bank (2 dp)
% --> format compact (no empty lines)
% --> format loose (adds empty lines)

%% Commands to Manage Variables
% clear - removes all variables from memory
% clear x y z - removes x y z specifically
% who - displays list of variables currently in memory
% whos - displays list of variables and their metadata

%%
%%%%% CHAPTER 2 - Creating Arrays

% Manually
% Row vectors are separated by spaces or commas
% Column vectors are separated by semi-colons or by pressing enter

% Code
% row_vector = [m:q:n] = m:q:n
% --> where m = first, q = spacing (default 1, if omitted), n = last
% row_vector = linspace(first, last, #elements)
% --> #elements default is 100

% 2D arrays
% row vectors, separated by ;
disp("Creating a 2D matrix")
matrix = [1 2 3; 4 5 6; 7 8 9]

% Commands
% --> zeros(m, n) - zero matrix
% --> ones (m, n) - ones matrix
% --> eye(n) - identity matrix
% --> m = row, n = column

% Transpose
% --> apply ' after the variable
% --> switches rows and columns in matrices