function bisection(a, b)
  e = 1E-6;
  x = [a:0.1:b];
  
  plot(x,f(x))
  grid
  hold on
  
  fa = f(a);
  count = 0;
  
  do
    count += 1;
    x = (a + b) / 2;
    fx = f(x);
    plot(x, fx, 'r*')
    hold on
    
    if fa * fx < 0
      b = x;
    else
      a = x;
      fa = fx;
    end
    sleep(0.5)
  until (abs(fx) < e)

  function ret_f = f(xm)
    ret_f = exp(xm) .* sin(xm) - 1;
  end
  count
  fx
  x
end