a = [0.0, 0.48, 0.65];
b = [1.0, 0.33, 0.20];
c = [0.33, 0.42, 0.18];
d = [ 0.13, 0.22, 0.48]; 
%% Plot bar graph and color it
% Bar graph figure
hBar = bar(data,0.35);
 
% Get a handle to the children
hBarChildren = get(hBar, 'Children');
 
% Set the colors we want to use
myBarColors = [a;b;c;d];
index = [1 2 3 4];
 
% Set the index as CData to the children
set(hBarChildren, 'CData', index);
 
% And set the custom colormap. Takes care of everything else
colormap(myBarColors);
xlabel ('pepper     lake        house        lena');
