% This is supposed to compile all of the calculations that will be done for
% the VQLS, mostly involving the matrices that will be used as A in the
% equation Ax = b

% So far, all we've been using to define these systems are the I, Z, and X
% gates, but here I'll define all Pauli gates
I = eye(2);
Z = [1 0; 0 -1]
X = [0 1; 1 0];
Y = [0 -1i; 1i 0];
b = [1/sqrt(8); 1/sqrt(8); 1/sqrt(8); 1/sqrt(8); 1/sqrt(8); 1/sqrt(8); 1/sqrt(8); 1/sqrt(8)]
I8 = kron(kron(I,I),I);

%%
Z1 = kron(kron(I, Z), I) 
Z2 = kron(kron(Z, I), I) 
A = 0.55*I8 + 0.225*Z1 + 0.225*Z2

%%
% A matrix, of little-endian representation (LER)
Z1 = kron(kron(I,Z),I);
Z2 = kron(kron(I,I),Z)
k = 11
A = 0.55*I8 + 0.225*Z1 + (0.55 - 0.225 - (1/k))*Z2
cond(A)
A^-1 * b

%%
% 2nd A matrix, of LER
k = 30;
alpha = .5 * (1 + (1/k))
beta = .5 * (1 - (1/k))
A = alpha*I8 + beta*Z2
cond(A)


%%
% A matrix for pennylane implementation, big-endian representation (BER)
X0Z1 = kron(kron(X,Z),I);
X0 = kron(kron(X, I), I);
Z0 = kron(kron(Z, I), I);
A = I8 + 0.618181*X0Z1 + .2*X0;
cond(A)
A^-1 * b;

%%
y = zeros(199, 199);
for k=1:1:197
    for j=1:1:197
        A = I8 + ((j-100)*0.01)*X0Z1 + ((k-100)*0.01)*Z0;
        y(j,k) = cond(A);
    end
end
h = gca
surf(y)
%set(h, 'xscale', 'log')
%set(h, 'yscale', 'log')
set(h, 'zscale', 'log')

%%
zeta = 0.1;
eta = 0.841910281;

X0 = kron(kron(X, I), I);
X0 == adjoint(X0);
X1 = kron(kron(I,X), I);
X1 == adjoint(X1);
X2 = kron(kron(I, I), X);
X2 == adjoint(X2);
Z01 = kron(kron(Z, Z), I);
Z01 == adjoint(Z01);
Z12 = kron(kron(I, Z), Z);
Z12 == adjoint(Z12);
A = (1/zeta) * (X0 + X1 + X2 + 0.1*(Z01 + Z12) + eta * I8)
cond(A)

%%
III = kron(I,I)
X0 = kron(I,X)
XX = kron(X,X)
YY = kron(Y,Y)

L = 2*I2 - X0 - 0.5*XX - 0.5*YY
A = [2 -1 0 0 0 0 0 0;
     -1 2 -1 0 0 0 0 0;
     0 -1 2 -1 0 0 0 0;
     0 0 -1 2 -1 0 0 0;
     0 0 0 -1 2 -1 0 0;
     0 0 0 0 -1 2 -1 0;
     0 0 0 0 0 -1 2 -1]
cond(A)

%%
%%%%%%%%%%%%%
%%% N = 4 %%%
%%%%%%%%%%%%%
eta = 1.
Y0 = kron(kron(kron(Y, I), I), I);
Y1 = kron(kron(kron(I, Y), I), I);
Y2 = kron(kron(kron(I, I), Y), I);
Y3 = kron(kron(kron(I, I), I), Y);

X01 = kron(kron(kron(X, X), I), I);
X12 = kron(kron(kron(I, X), X), I);
X23 = kron(kron(kron(I, I), X), X);
I4 = kron(kron(kron(I, I), I), I);

syms eta
eta = 1;
A = 10*Y0 + 10*Y1 + 10*Y2 + 10*Y3 + X01 + X12 + X23 + (eta/0.1) * I4;
cond(A);
inc = 0.00001
eta_all = zeros(20);
for k=10:10:200
    k
    err = abs(cond(A) - k);
    it = 0;
    while err > 0.001
        eta = eta + inc;
        A = 10*Y0 + 10*Y1 + 10*Y2 + 10*Y3 + X01 + X12 + X23 + (eta/0.1) * I4;
        if abs(cond(A) - k) < err
            err = abs(cond(A) - k);
        else
            eta = eta - (inc*2);
            A = 10*Y0 + 10*Y1 + 10*Y2 + 10*Y3 + X01 + X12 + X23 + (eta/0.1) * I4;
            err = abs(cond(A) - k);
        end
        if it > 100000
            inc = inc/10;
            it = 0
        end
        it = it + 1;
    end
    eta_all(k/10) = eta;
    cond(A)
end

%%
eta_all(:,1)