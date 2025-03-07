/*
Proyecto: Sumador-Restador 1 Bit
Archivo: ADD1B.v
Autor: Rodrigo A.
Ref: Libro Lagaro I, Cap. 1
*/

module add1b (
	input		inv_i, 	// Inversion de b0
	input		c_i,		// Carry in
	input		a_i,		// Entrada de bit de operando 1 (a)
	input		b_i,		// Entrada de bit de operando 2 (b)
	output	s_o,		// Salida de suma
	output	x_o		// b o ~b	
);

	// Multiplexor de b ~b con selector de inversion
	wire nb,ni,x1,x2,x;		// Conexiones

	not i1(nb_i, b_i);			// Inversion de b_i
	not i2(ninv_i, inv_i);		// Inversion de inv_i --> Seleccion del mux
	and i3(x1, ninv_i, b_i);	// inv_i == 0 ?? x0 = b_i
	and i4(x2, inv_i, nb_i);	// inv_i == 1 ?? x0 = nb_i
	or i5(x_o, x1, x2);			// x0 es la salida del mux
	
	// Implementacion del sumador --> Ecuaciones descritas
	xor i6(r_o, a_i, x_o);		// x_0 = b_i | nb_i
	xor i7(s_o, r_o, c_i);		// s = suma

endmodule