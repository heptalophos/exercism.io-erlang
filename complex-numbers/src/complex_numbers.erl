-module(complex_numbers).

-export([abs/1, 
		 add/2, 
		 conjugate/1, 
		 divide/2, 
		 equal/2, 
		 exp/1, 
		 imaginary/1, 
		 mul/2, 
		 new/2, 
		 real/1, 
		 sub/2]).

-record(complex, {real = 0, imag = 0}).
-type complex() :: #complex{}.


-spec abs(complex()) -> number().
abs(Z) -> 
	#complex {real = R, imag = I} = Z,
	trunc (math:sqrt (R * R + I * I)).


-spec add(complex(), complex()) -> complex().
add(Z1, Z2) -> 
	#complex {real = R1, imag = I1} = Z1,
	#complex {real = R2, imag = I2} = Z2,
	#complex {real = R1 + R2, imag = I1 + I2}.

-spec conjugate(complex()) -> complex().
conjugate(Z) -> 
	#complex{real = R, imag = I} = Z,
	#complex{real = R, imag = -1 * I}.

-spec divide(complex(), complex()) -> complex().
divide(Z1, Z2) -> 
	#complex{real = R1, imag = I1} = Z1,
	#complex{real = R2, imag = I2} = Z2,
	Den = R2 * R2 + I2 * I2,
	#complex{real = (R1 * R2 + I1 * I2) / Den, 
		   	 imag = (I1 * R2 - I2 * R1) / Den}.

-spec equal(complex(), complex()) -> boolean().
equal(Z1, Z2) -> 
	#complex{real = R1, imag = I1} = Z1,
	#complex{real = R2, imag = I2} = Z2,
	D = 0.005,
	erlang:abs(R1 - R2) < D andalso  erlang:abs(I1 - I2) < D.

-spec exp(complex()) -> complex().
exp(Z) -> 
	#complex{real = R, imag = I} = Z,
	#complex{real = math:exp(R) * math:cos(I), 
		     imag = math:exp(R) * math:sin(I)}.

-spec imaginary(complex()) -> number().
imaginary(Z) -> 
	#complex{real = _, imag = I} = Z,
	I.

-spec mul(complex(), complex()) -> complex().
mul(Z1, Z2) -> 
	#complex{real = R1, imag = I1} = Z1,
	#complex{real = R2, imag = I2} = Z2,
	#complex{real = R1 * R2 - I1 * I2, imag = R2 * I1 + R1 * I2}.

-spec new(number(), number()) -> complex().
new(R, I) -> 
	#complex{real = R, imag = I}.

-spec real(complex()) -> number().
real(Z) -> 
	#complex{real = R, imag = _} = Z,
	R.

-spec sub(complex(), complex()) -> complex().
sub(Z1, Z2) ->
	#complex{real = R1, imag = I1} = Z1,
	#complex{real = R2, imag = I2} = Z2, 
	#complex{real = R1 - R2, imag = I1 - I2}.
