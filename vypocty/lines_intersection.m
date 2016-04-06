function [I] = lines_intersection(P1, u1, P2, u2)
    n1 = [-u1(2), u1(1)];
    n2 = [-u2(2), u2(1)];
    
    c1 = -P1 * n1';
    c2 = -P2 * n2';
    
    isect = cross([n1, c1], [n2, c2]);
    isect = isect ./ isect(3);

    I = isect(1:2);
end