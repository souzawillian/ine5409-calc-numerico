function false_position(a, b)
  e = 1E-6;
  axis_x = [a:0.1:b];
  
  plot(axis_x, f(axis_x))
  grid
  hold on
  
  count = 0;
  
  do
    count += 1;
    fa = f(a);
    fb = f(b);
    
    x = a - (fa * (b - a) / (fb - fa));
    
    fx = f(x);
    plot(x, fx, 'r*')
    hold on
    
    if fa * fx < 0
      b = x;
      fb = fx;
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