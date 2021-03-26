function permanence = ComputePermanence(F, A)
    permanence = 0;
    [n, k] = size(F);

    for node = 1:n
        com_ind = find(F(node, :) == 1);
        com = F(:, com_ind);
        internal_conn = A(node, :) * com;
        max_external_conn = 0;

        for ex_ind = 1:k

            if ex_ind == com_ind
                continue
            end

            external_conn = A(node, :) * F(:, ex_ind);

            if external_conn >= max_external_conn
                max_external_conn = external_conn;
            end

        end

        deg = sum(A(node, :));
        in_nodes = find(com == 1);
        subgraph = A(in_nodes, in_nodes);

        if sum(com) < 3 || sum(subgraph(:)) < 6
            internal_cc = 0
        else
            in_neighbours = A(:, node) .* com;
            in_neighb_ind = find(in_neighbours == 1);
            subgraph2 = A(in_neighb_ind, in_neighb_ind);
            numer = sum(subgraph2(:)) ./ 2;
            denom = 0.5 .* internal_conn .* (internal_conn - 1);

            if denom == 0
                internal_cc = 0;
            else
                internal_cc = numer ./ denom;
            end

        end

        if max_external_conn == 0
            max_external_conn = 1;
        end

        permanence = permanence + (internal_conn) ./ (max_external_conn .* deg) - (1 - internal_cc);

    end

    permanence = permanence ./ n;

end
