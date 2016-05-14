d = 0:0.01:3;

a = 3;
b = 0.03;

mind = 0.1;
maxd = 2.0;
maxw = a * maxd + b;



w = a.*d + b;

w(d < mind) = 0.0;
w(d > maxd) = maxw;

plot(d, w);
