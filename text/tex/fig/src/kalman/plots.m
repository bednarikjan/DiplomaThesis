x = 1:1000;

muM     = 150.0;
sigmaM  = 60.0;
muP     = 750.0;
sigmaP  = 90.0;

gM = (1.0 / (sigmaM * sqrt(2.0 * pi))) * exp(-0.5 * ((x - muM) / sigmaM).^2);
gP = (1.0 / (sigmaP * sqrt(2.0 * pi))) * exp(-0.5 * ((x - muP) / sigmaP).^2);

figure(1);
plot(x, gM, 'r', 'LineWidth', 3);
hold on;
plot(x, gP, 'g', 'LineWidth', 3);

axis([1, 1000, 0, 1.2 * max(max(gM), max(gP))]);
set(gca, 'XTickLabel','');
set(gca, 'YTickLabel','');
% xlabel('x [px]');
% ylabel('p(X = x)');

hold off;