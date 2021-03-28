function mdl = ComputeModularity(F, A)
    [n, k] = size(F);
    deg = sum(A, 2);
    degsum = sum(deg);
    m = degsum / 2;
    denom = 1 / (degsum^2);
    mdl = 0;

    for ind = 1:k
        comm = find(F(:, ind) == 1);
        subgraph = A(comm, comm);
        L_c = sum(subgraph(:)) / 2;
        sub_deg_sum = sum(deg(comm));
        mdl = mdl + L_c / m - sub_deg_sum^2 * denom;
    end

end
