% Ngan Jennifer Tram Su [260923530]

% Main Program -- Outputs the concentration profile for a given biot number
% and predicts the time it takes for the centerline concentration to reach
% a certain value.
% Program also saves a 2D and 3D plot of the concentration profile to the
% working directory.

% Instructions:
% --> run the main program by clicking run and following the instructions
% printed to the command window
% --> will be prompted to enter a Biot number and a target centerline
% concentration value
% To produce the plots for all Biot numbers, run the m-file titled
% 'allplots.m"

clf
clear
clc

Bim = input('Input the Biot number: ');

% Initializing the dimensionless time parameter
Fr = [1e-6, 2];
df = 100;
Fo = Fr(1):(Fr(2)-Fr(1))/df:Fr(2);

name = strcat(num2str(Bim));
theta = spatial(Bim, Fo, name);

% Time it takes for centerline concentration to reach a certain value
fprintf('Predicting the time it takes for centerline concentration to reach a certain value...\n')
v = input('Input the target concentration: ');

t = incpredict(theta(1, :), Fo, v);

if isnan(t)
    fprintf('Centerline concentration never reaches a value of %s.\n', num2str(v))
else
    fprintf('Biot: %s - The time it takes for the centerline concentration to reach %s is around %s.\n', num2str(Bim), num2str(v), num2str(t))
end
