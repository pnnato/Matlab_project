
%for (i=0; i<100; i++)
[m, n] = size(tomato.leaf{1});   
T = tomato.leaf{1};
if m > 1
    A = array2table(T(1));
end
