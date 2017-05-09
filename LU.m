function LU(A)
  n = size(A, 1);  
  L = zeros(n);
  U = zeros(n);  
  
  k = 1 ;
  for i = k : n
    L(i, k) = A(i, k);
    for j = k + 1 : n
      U(k, j) = A(k, j) / L(k, k);
    end    
  end
  
  Y(k) = b(k) / L(k, k)  
  U(k, k) = 1;
  
  for k = 2 : n
    for i = k : n
      soma_l = 0;
      for r = 1: k - 1
        soma_l += L(i, r) * U(r, i);
      end
      L(i, k) = A(i, k) - (soma_l);
    end
      
    for j = k + 1 : n
      soma_u = 0;
      soma_y = 0;
      for r = 1: k - 1
        soma_u += L(k, r) * U(r, j);
        soma_y += L(k, r) * Y(r);
      end
      U(k, j) = (A(k, j) - (soma_u)) / L(k, k);
      Y(k) = b(k)-soma / L(k, k);
    end
    U(k, k) = 1;    
  end
  L
  U
  Y
end
