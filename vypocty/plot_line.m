function plot_line(A, u, D, figureHandle, specifier)   
    n = [-u(2), u(1)];
    c = -(A * n');            
    y = (-n(1) / n(2)) * D - (c / n(2));

    figure(figureHandle);
    plot(D, y, specifier)
end