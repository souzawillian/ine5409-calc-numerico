function gauss_tridiagonal
  A = [1 -1 0 0 0;
       1 1 -1 0 0;
       0 1 -1 1 0;
       0 0 -1 1 1;
       0 0 0 -1 2];
  b = [0 1 2 -1 -2];
  r = diag(A);
  t = diag(A, -1);
  d = diag(A, 1);
  n = size(A, 1);

  % result = [5 5 9 6 2]
  
  for i = 2 : n   
    m = t(i - 1) / r(i - 1);
    t(i - 1) = t(i - 1) - (m * r(i - 1));
    r(i) = r(i) - (m * d(i - 1));
    b(i) = b(i) - (m * b(i - 1));
  end
  
  x(n) = b(n) / r(n);
  for i = n - 1 : -1 : 1
    x(i) = (b(i) - (d(i) * x(i + 1))) / r(i);
  end
  x  
end