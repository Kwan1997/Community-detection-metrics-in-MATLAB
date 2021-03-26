function perfm = ComputePerformance(F, A)
    [n, k] = size(F);
    total_pairs = 0.5 * n * (n - 1);
    intra_edges = 0;

    for com_ind = 1:k
        com = F(:, com_ind);
        in_nodes = find(com == 1);
        subgraph = A(in_nodes, in_nodes);
        intra_edges = intra_edges + (sum(subgraph(:)) / 2);
    end

    completed_graph = ones(n);
    completed_graph = completed_graph - diag(diag(completed_graph));
    complement_graph = completed_graph - A;
    inter_edges = sum(complement_graph(:)) / 2;

    for com_ind = 1:k
        com = F(:, com_ind);
        in_nodes = find(com == 1);
        subgraph = complement_graph(in_nodes, in_nodes);
        inter_edges = inter_edges - (sum(subgraph(:)) / 2);
    end

    perfm = (intra_edges + inter_edges) / total_pairs;
end
