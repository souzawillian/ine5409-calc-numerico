function newton(x_obelix)
  e = 1E-6;
  count = 0;
  
  do
    x_obelix = x_obelix - (f(x_obelix) / fd(x_obelix));
    fx_obelix = f(x_obelix)
    count++;
  until abs(fx_obelix) < e
  x_obelix
  count

  function y = f(x)
    y = exp(x) .* sin(x) - 1;
  end
  function y = fd(x)
    y = exp(x) .* sin(x) + exp(x) .* cos(x);
  end
end