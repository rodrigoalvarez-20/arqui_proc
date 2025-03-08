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
	
	// Se llama al sumador de 1 bit
	add1b i0(
		.inv_i(inv_i), 
		.c_i(c_i), 
		.a_i(a_i[0]), 
		.b_i(b_i[0]), 
		.s_o(s_o[0]), 
		.x_o(x_o[0]));
	// Calculo de factores g[i] = a[i] * b[i]; p[i] = a[i] + b[i]
	and i1(g0, a_i[0], x_o[0]);
	or  i2(p0, a_i[0], x_o[0]);
	
	wire c_1, p0c0, p1g0, p2g1, p3g2;
	
	and i3(p0c0, p0, c_i);
	or i4(c_1, g0, p0c0);
	
	add1b i5(
		.inv_i(inv_i), 
		.c_i(c_1), 
		.a_i(a_i[1]), 
		.b_i(b_i[1]), 
		.s_o(s_o[1]), 
		.x_o(x_o[1]));
	
	and i6(g1, a_i[1], x_o[1]);
	or  i7(p1, a_i[1], x_o[1]);
	
	wire c_2, g1p1g0, g2p2g1, g3p3g2, p1p0c0, p2p1g0, p3p2g1;
	
	and i8(p1g0, p1, g0);
	and i9(p1p0c0, p1, p0c0);
	or i10 (g1p1g0, g1, p1g0);
	or i11 (c_2, g1p1g0, p1p0c0);
	
	add1b i12(
		.inv_i(inv_i), 
		.c_i(c_2), 
		.a_i(a_i[2]), 
		.b_i(b_i[2]), 
		.s_o(s_o[2]), 
		.x_o(x_o[2]));
		
	wire c_3, gp2g1p21g0, gp3g2p32g1, p210c0, p321g0;

	and i13(g2, a_i[2], x_o[2]);
	or i14(p2, a_i[2], x_o[2]);
	
	and i15(p2g1, p2, g1);
	and i16(p2p1g0, p2, p1g0);
	or i17(g2p2g1, g2, p2g1);
	and i18(p210c0, p2, p1p0c0);
	
	add1b i19(
		.inv_i(inv_i), 
		.c_i(c_3), 
		.a_i(a_i[3]), 
		.b_i(b_i[3]), 
		.s_o(s_o[3]), 
		.x_o(x_o[3]));
	
	and i20(g3, a_i[3], x_o[3]);
	or i21(p3, a_i[3], x_o[3]);
	
	and i22(p3g2, p3, g2);
	or i23(g3p3g2, g3, p3g2);
	and i24(p3p2g1, p3, p2g1);
	and i25(p321g0, p3, p2p1g0);
	or i26(gp2g1p21g0, g2p2g1, p2p1g0);
	or i27(gp3g2p32g1, g3p3g2, p3p2g1);
	or i28(c_3, gp2g1p21g0, p210c0);
	
	// Calculo final de G y P
	
	and i29(P, p3, p210c0);
	or i30(G, gp3g2p32g1, p321g0);
	or i31(c_o, G, P);
	
	
	
endmodule