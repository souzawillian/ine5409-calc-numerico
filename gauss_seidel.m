function gauss_seidel(A, b, w)
  n = size(A, 1);
  X = zeros(n, 1);
  tol = 1E-5;
  e = 1;
  count = 0;
  
  %sumVector = sum(abs(A'))
  %for i = 1 : n
  %  lineSum = sumVector(i) - A(i, i);
  %  dominante = A(i, i) < lineSum
  %end
  
  %if (dominante > 0)
  %  print("Convergenvia nao garantida!!")
  %end
  
  
  while (e > tol)
    count += 1;
    BX = X;
    for i = 1 : n
      soma = 0;
      for j = 1 : n
        if (i != j)
          soma += A(i, j) * X(j);
        end
      end
      X(i) = (b(i) - soma) / A(i, i);
      X(i) = (1 - w) * BX(i) + w * X(i);
    end
    e = max(abs(X - BX));
  end  
  X
  count
end