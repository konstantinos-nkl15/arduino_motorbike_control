function data = dcgain_sweep(m, e, Vmax, Vset_list)
% Σάρωση μόνιμης κατάστασης.
% Επιστρέφει πίνακα [Vset, Vμετρημένη, ω] ανά γραμμή.

    settle = 1.0;    % αναμονή για σβήσιμο του μεταβατικού (~10 T)
    Tavg   = 1.5;    % παράθυρο μέσου όρου

    n    = numel(Vset_list);
    data = zeros(n, 3);

    start(m);
    for k = 1 : n
        m.Speed = Vset_list(k) / Vmax;
        pause(settle);

        [p0, t0] = readCount(e);
        pause(Tavg);
        [p1, t1] = readCount(e);

        w = (p1 - p0) * (2*pi/1200) / seconds(t1 - t0);

        fprintf('\nVset = %.2f V   ->   omega = %6.2f rad/s\n', Vset_list(k), w);
        Vm = input('   Ενδειξη πολυμετρου (V): ');

        data(k,:) = [Vset_list(k), Vm, w];
    end
    m.Speed = 0;
    stop(m);
end