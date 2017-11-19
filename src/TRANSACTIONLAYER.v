`include "CONECTORENTRADA.v"
`include "FIFO.v"
`include "CONECTORFLAGS.v"
`include "CONECTORINTERMEDIOFIFOS.v"
`include "RoundRobin.v"
`include "FSM.v"

module TRANSACTIONLAYER (CLOCK, RESET ,PUSHDATOENTRADA, IDINPUT, DATO_IN, TL, TH, SEL, TABLE, WEIGHT, POPffg, SET_INIT, IDLE, PAUSE_STB, CONTINUE_STB, ERROR_FULL);

	input CLOCK, RESET, PUSHDATOENTRADA, POPffg/*Viene del probador*/, SET_INIT/*Viene del probador*/;
	input [1:0] IDINPUT, SEL, WEIGHT;
	input [3:0] DATO_IN;
	input [31:0] TABLE;
	output IDLE;
	output [3:0] PAUSE_STB, CONTINUE_STB, ERROR_FULL;
	
	
	wire PUSHff0, PUSHff1, PUSHff2, PUSHff3;
	wire POPff0, POPff1, POPff2, POPff3;
	wire ALMOST_EMPTYff0, ALMOST_FULLff0, EMPTYff0, FULLff0;
	wire ALMOST_EMPTYff1, ALMOST_FULLff1, EMPTYff1, FULLff1
	wire ALMOST_EMPTYff2, ALMOST_FULLff2, EMPTYff2, FULLff2;
	wire ALMOST_EMPTYff3, ALMOST_FULLff3, EMPTYff3, FULLff3;
	wire ALMOST_EMPTYffg, ALMOST_FULLffg, EMPTYffg, FULLffg;
	wire [3:0] ALMOST_EMPTY_OUT, ALMOST_FULL_OUT, EMPTY_OUT, FULL_OUT
	wire [3:0] DATO_OUTff0, DATO_OUTff1, DATO_OUTff2, DATO_OUTff3, CFDATOFIFOP;
	wire POPDATOCF/*viene de lau*/, IDINTERMEDIATE/*viene de sofi*/, PUSHDATOFIFOPRINCIPAL;
	wire TL, TH, INIT;
	
	
	CONECTORENTRADA entrada( PUSHDATOENTRADA, IDINPUT, PUSHff0, PUSHff1, PUSHff2, PUSHff3);
	
	FIFO #(8) fifo0(CLOCK, RESET, PUSHff0, POPff0,DATO_IN, DATO_OUTff0, ALMOST_EMPTYff0, ALMOST_FULLff0, EMPTYff0, FULLff0, TL, TH);
	FIFO #(8) fifo1(CLOCK, RESET, PUSHff1, POPff1,DATO_IN, DATO_OUTff1, ALMOST_EMPTYff1, ALMOST_FULLff1, EMPTYff1, FULLff1, TL, TH);
	FIFO #(8) fifo2(CLOCK, RESET, PUSHff2, POPff2,DATO_IN, DATO_OUTff2, ALMOST_EMPTYff2, ALMOST_FULLff2, EMPTYff2, FULLff2, TL, TH);
	FIFO #(8) fifo3(CLOCK, RESET, PUSHff3, POPff3,DATO_IN, DATO_OUTff3, ALMOST_EMPTYff3, ALMOST_FULLff3, EMPTYff3, FULLff3, TL, TH);
	
	CONECTORFLAGS ccflags(ALMOST_EMPTYff0, ALMOST_FULLff0, EMPTYff0, FULLff0, 
		ALMOST_EMPTYff1, ALMOST_FULLff1, EMPTYff1, FULLff1,
		ALMOST_EMPTYff2, ALMOST_FULLff2, EMPTYff2, FULLff2,
		ALMOST_EMPTYff3, ALMOST_FULLff3, EMPTYff3, FULLff3,
		ALMOST_EMPTY_OUT, ALMOST_FULL_OUT, EMPTY_OUT, FULL_OUT);
	
	CONECTORINTERMEDIOFIFOS conectorintermediofifos( POPDATOCF, IDINTERMEDIATE, POPff0, POPff1, POPff2, POPff3, DATO_OUTff0, DATO_OUTff1, DATO_OUTff2, DATO_OUTff3, CFDATOFIFOP, PUSHDATOFIFOPRINCIPAL);

	FIFO #(16) fifogrande(CLOCK, RESET, PUSHDATOFIFOPRINCIPAL, POPffg, CFDATOFIFOP, DATO_OUTffg, ALMOST_EMPTYffg, ALMOST_FULLffg, EMPTYffg, FULLffg, TL, TH);
	
	RoundRobin( SEL, CLOCK, TABLE, WEIGHT, RESET, IDINTERMEDIATE);
	
	FSM(CLOCK, RESET, SET_INIT, EMPTY_OUT, FULL_OUT, ALMOST_FULL_OUT, ALMOST_EMPTY_OUT, INIT/*SELECTOR DE LA INTERFAS*/, IDLE/*ENTRA AL PROBADOR*/, PAUSE_STB/*ALPROBADOR*/, CONTINUE_STB/*ALPROBADOR*/, ERROR_FULL/*ALPROBADOR*/);