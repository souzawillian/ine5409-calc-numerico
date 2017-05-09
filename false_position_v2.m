function false_position_v2(a, b)
  e = 1E-6;
  axis_x = [a:0.1:b];
  
  plot(axis_x, f(axis_x))
  grid
  hold on
  
  count = 0;
  fa = f(a);
  fb = f(b);
  
  do
    count += 1;    
    x = a - (fa * (b - a) / (fb - fa));
    
    fx = f(x);
    r = fa + ((fb - fa) / (b - a)) * (axis_x - a);
    plot(axis_x, r, 'r')
    hold on
   
    if fa * fx < 0
      b = x;
      pa = fb / (fb + fx)
      fb = fx;
      fa *= pa;
    else
      a = x;
      pb = fa / (fa + fx)
      fa = fx;
      fb *= pb;      
    end
    sleep(1)
  until (abs(fx) < e)
  
  function ret_f = f(xm)
    ret_f = exp(xm) .* sin(xm) - 1;
  end  
  count
  fx
  x
end