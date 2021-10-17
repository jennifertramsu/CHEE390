% Ngan Jennifer Tram Su [260923530]

function yp = incpredict(x, y, p)
% Searching algorithm 
% (1) Incremental search for bounds
% (2) Linear interpolation
% x = array of dependent values
% y = array of independent values
% p = value of interest
% yp = predicted y-value
%% Initialization
i = 0;
xleft = 0; yleft = 0; % In case value of interest is < than the first value in array
xright = x(1); yright = y(1);
%% Beginning of while loop - searching for bounds
while i + 1 < length(x)
    
    if (xleft <= p) && (p <= xright) % Bounds found
        break
    end
    
    i = i + 1;
    xleft = x(i); yleft = y(i);
    xright = x(i + 1); yright = y(i + 1);
end

%% Two-point linear interpolation for desired y value
if (xleft <= p) && (p <= xright) && (i + 1 < length(x)) % Verifying that bounds were found
    yp = ((yright - yleft) / (xright - xleft)) * (p - xleft) + yleft;
else
    yp = NaN;
end

end