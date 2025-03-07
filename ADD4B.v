/*
Proyecto: Sumador-Restador 4 Bits
Archivo: ADD4B.v
Autor: Rodrigo A.
Ref: Libro Lagaro I, Cap. 1
*/

module add4b (
	input inv_i,		// Inversion del b0
	input c_i,			// Acarreo de entrada
	input [3:0]a_i,	// Entrada A, 4 bits
	input [3:0]b_i,	// Entrada B, 4 bits
	output [3:0]s_o,	// Salida (suma), 4 bits
	output c_o,			// Acarreo de salida
	output P,			// Propagacion para 2do nivel (bandera) --> Calculo rapido de acarreo
	output G				// Generacion para 2do nivel (bandera)
);
	
	wire g0, g1, g2, g3;
	wire p0, p1, p2, p3;
	wire x_o[3:0];
	
	add1b i0

endmodule