function jacobi(A, b)
  n = size(A, 1);
  X = zeros(n, 1)';
  tol = 10E-5;
  e = 1;
  count = 0;

  while (e > tol)
    count += 1;
    for i = 1 : n
      soma = 0;
      for j = 1 : n
        if (i != j)
          soma += A(i, j) * X(j);
        end
      end
      NX(i) = (b(i) - soma) / A(i, i);
    end
    e = max(abs(NX - X));
    X = NX;
  end  
  X'
  count
end
