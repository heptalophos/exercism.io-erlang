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

-export_type([complex/0]).


-spec abs(complex()) -> number().
abs(Z) -> 
	{R, I} = Z,
	trunc(math:sqrt(R * R + I * I)).


-spec add(complex(), complex()) -> complex().
add(Z1, Z2) -> 
	{R1, I1} = Z1,
	{R2, I2} = Z2,
	Z = {R1 + R2, I1 + I2},
	Z.

-spec conjugate(complex()) -> complex().
conjugate(Z) -> 
	{R, I} = Z,
	Conj = {R, -I},
	Conj.

-spec divide(complex(), complex()) -> complex().
divide(Z1, Z2) -> undefined.

-spec equal(complex(), complex()) -> boolean().
equal(Z1, Z2) -> undefined.

-spec complex() -> ().
exp(_Z) -> undefined.

-spec abs() -> ().
imaginary(_Z) -> undefined.

-spec abs() -> ().
mul(_Z1, _Z2) -> undefined.

-spec abs() -> ().
new(_R, _I) -> undefined.

-spec abs() -> ().
real(_Z) -> undefined.

-spec abs() -> ().
sub(_Z1, _Z2) -> undefined.
