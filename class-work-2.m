vel = [55 70 85 100 120 140]
cons = [14.08 13.56 13.28 12.27 11.30 10.4]

% matriz do polinomio interpolador
function P = vandermonde_matrix(X)
  n = length(X);
  for i = 1 : n
    for j = 1 : n
      P(i, j) = X(i) ^ (j-1);
    end
  end
end


function X = gauss_partial_pivoting(A, b)
  n = size(A, 1);
  row = [1:n];
  
  for k = 1 : n - 1
    pivo = k;
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

  % retro substituição
  X(n) = b(row(n)) / A(row(n), n);
  for i=n-1 : -1 : 1
    soma = 0;
    for j = i + 1 : n
      soma = soma + A(row(i), j) * X(j);
    end
    X(i) = (b(row(i)) - soma) / A(row(i), i);
  end
end

function P = resolve_polinomio(A, X)
  n = length(X);
  for k = 1 : n
    P(k) = 0;
    for i = 1 : length(A)
      P(k) += A(i) * (X(k) ^ (i-1));
    end
  end
end

grid
hold on
% 1) Determinar os coeficientes do polinômio interpolador obtidos numericamente (através da resolução do sistema linear) e construir o gráfico da interpolação;
VM = vandermonde_matrix(vel);
A = gauss_partial_pivoting(VM, cons)
y = resolve_polinomio(A, vel);
plot(vel, y, '*b');
% Verificar o consumo aproximado para o caso de serem desenvolvidas as velocidades de: 105 Km/h
x_km = 105
y_km = resolve_polinomio(A, x_km);
plot(x_km, y_km, '*r');

% valores de velocidade interpolados
it_x = vel(1):vel(length(vel));
p_it_x = resolve_polinomio(A, it_x);
plot(it_x, p_it_x, 'b');

% 2) Utilizar o algoritmo de Lagrange;
function y = lagrange(X, Y, x0)
  n = length(X);
  L = ones(1, n);
  y = 0;
  for i = 1 : n
    for j = 1 : n
      if j != i
        L(i) *= (x0 - X(j)) / (X(i) - X(j));
      end
    end
    y += Y(i) * L(i);
  end
end

function y = lagrange_interpoled(X, Y, Xs)
  n = length(Xs);
  for i = 1 : n
    y(i) = lagrange(X, Y, Xs(i));
  end
end

y_lag = lagrange(vel, cons, x_km);
plot(x_km, y_lag, '*m');
lag_it_x = lagrange_interpoled(vel, cons, it_x);
plot(it_x, lag_it_x, 'm')

% 3) Utilizar o algoritmo das Diferenças Divididas de Newton;
function y = divided_differences(X, Y, x0)
  n = length(X);
  A = Y'; % ordem 1 = y

  % ordem 2 até n
  for j = 2 : n
    for i = j : n
      A(i,j) = (A(i, j-1) - A(i-1, j-1)) / (X(i) - X(i-j+1));
    end
  end

  % Polinomio interpolador
  tmp = 1;
  y = A(1,1);
  for i = 2 : n
    tmp *= x0 - X(i-1);
    y += A(i,i) * tmp;
  end  
end

function y = dd_interpoled(X, Y, Xs)
  n = length(Xs);
  for i = 1 : n
    y(i) = divided_differences(X, Y, Xs(i));
  end
end

y_dd = divided_differences(vel, cons, x_km);
plot(x_km, y_dd, '*r');
dd_it_x = dd_interpoled(vel, cons, it_x);
plot(it_x, dd_it_x, 'r')

% 4) Utilizar interpolação Spline Cúbida do matlab (função spline ou interp1)
y_sp = spline(vel, cons, x_km);
plot(x_km, y_sp, '*c');
sp_it_x = spline(vel, cons, it_x)
plot(it_x, sp_it_x, 'c');

% 5) Comparar os resultados dos itens 1, 2, 3 e 4 graficamente;
% Gráficos apresentados;
% 6) Avaliar o valor do polinômio interpolador para um ponto específico dentro do intervalo para os quatro métodos;
% avaliado para o ponto x_km = 105