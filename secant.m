function secant(x0, x1)
  e = 1E-6;
  count = 0;
  
  do
    fx0 = f(x0);
    fx1 = f(x1);
    x2 = x1 - (((x1 - x0) * fx1) / (fx1 - fx0));
    x0 = x1;
    x1 = x2;
    count++;
  until abs(f(x2)) < e
  x2
  count

  function y = f(x)
    y = exp(x) .* sin(x) - 1;
  end
end