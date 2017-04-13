function simp_pivoting_gauss(A, b)
  b_original = b;
  A_original = A;
  n = size(A, 1);
  row = [1:n];
  
  for k = 1 : n - 1
    pivo = k
    max = abs(A(row(k), k));
    
    % pega o indice da linha com o maior elemento pivo
    for i = k + 1 : n
      if abs(A(row(i), k)) > max;
        pivo = i;
        max = abs(A(row(i), k));
      end
    end
    
    % troca de linhas
    if pivo != k
      row([k, pivo]) = row([pivo, k]);
    end
    
    for i = k + 1 : n
      m = A(row(i), k) / A(row(k), k);
      for j = k : n
        A(row(i), j) = A(row(i), j) - m * A(row(k), j);
      end
      b(row(i)) = b(row(i)) - m * b(row(k));
    end
  end
  
  A
  b
  pause
  x(n) = b(row(n)) / A(row(n), n);
  for i=n-1 : -1 : 1
    soma = 0;
    for j = i + 1 : n
      soma = soma + A(row(i), j) * x(j);
    end
    x(i) = (b(row(i)) - soma) / A(row(i), i);
  end
  x
  
  R = abs(b_original - (A_original * x'));
   
  R
end