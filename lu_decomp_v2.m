function lu_decomp_v2(A, b)
  A\b # result of linear system
  
  n = size(A, 1);  
      
  for k = 1 : n
    for i = k : n
      soma_l = 0;
      for r = 1: k - 1
        soma_l += L(i, r) * U(r, k);
      end
      L(i, k) = A(i, k) - (soma_l);
    end
    
    U(k, k) = 1;
    for j = k + 1 : n
      soma_u = 0;
      for r = 1: k - 1
        soma_u += L(k, r) * U(r, j);
      end
      U(k, j) = (A(k, j) - (soma_u)) / L(k, k);
    end    
  end
  L
  U
  
  Y(1) = b(1) / L(1, 1);
  for i = 2 : n
    soma_y = 0;
    for j = 1 : i - 1
      soma_y += L(i, j) * Y(j);
    end
    Y(i) = (b(i) - soma_y) / L(i, i);
  end
  Y
  
  X(n) = Y(n);
  for i = n - 1 : -1 : 1
    soma_x = 0;
    for j = i + 1 : n
      soma_x += U(i, j) * X(j);
    end
    X(i) = Y(i) - soma_x;
  end
  X
end
