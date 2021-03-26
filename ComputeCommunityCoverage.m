function covg = ComputeCommunityCoverage(F, A)
    [n, k] = size(F);
    total_edges = sum(A(:)) / 2;
    intra_edges = 0;

    for com_ind = 1:k
        com = F(:, com_ind);
        in_nodes = find(com == 1);
        subgraph = A(in_nodes, in_nodes);
        intra_edges = intra_edges + (sum(subgraph(:)) / 2);
    end

    covg = intra_edges / total_edges;
end
