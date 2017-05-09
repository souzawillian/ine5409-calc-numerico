function lu_decomp_v3(A, b)
  # Calculate using only 'A' matrix
  A\b # result of linear system

  n = size(A, 1);

  # primeira coluna já esta dada
  # primeira linha da matriz
  for j = 1 : n
    A(1, j) = A(1, j) / A(1, 1);
  end

  for k = 2 : n
    for i = k : n
      soma_l = 0;
      for r = 1: k - 1  # k == 1 não precisa
        soma_l += A(i, r) * A(r, k);
      end
      A(i, k) = A(i, k) - (soma_l);
    end

    for j = k + 1 : n
      soma_u = 0;
      for r = 1: k - 1
        soma_u += A(k, r) * A(r, j);
      end
      A(k, j) = (A(k, j) - (soma_u)) / A(k, k);
    end    
  end
  A

  Y(1) = b(1) / A(1, 1);
  for i = 2 : n
    soma_y = 0;
    for j = 1 : i - 1
      soma_y += A(i, j) * Y(j);
    end
    Y(i) = (b(i) - soma_y) / A(i, i);
  end
  Y

  X(n) = Y(n);
  for i = n - 1 : -1 : 1
    soma_x = 0;
    for j = i + 1 : n
      soma_x += A(i, j) * X(j);
    end
    X(i) = Y(i) - soma_x;
  end
  X
end
