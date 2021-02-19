#include <stdio.h>


float bintofloat(unsigned int x) {
	union {
		unsigned int  x;
		float  f;
	} temp;
	temp.x = x;
	return temp.f;
}

unsigned int floattobin(float f) {
	union {
		unsigned int  x;
		float  f;
	} temp;
	temp.f = f;
	return temp.x;
}

int main() {
	/*input set for Goldentest.v*/
	
	unsigned int A[] = { 0b00000000000000000000000000000000, 0b01000011011100000000000000000000, 0b01000011011100000000000000000000,
						0b11000011011100000000000000000000, 0b01000011011100000000000000000000, 0b01000000000000001000000000000000,
						0b01000000000000001000000000000000, 0b01111111000000010000000000000000, 0b01111111000000010000000000000000,
						0b01111111000000010000000000000000, 0b00000000000000010000000000000000,	0b01111111100000000000000000000000,
						0b00000000000000000000000000000000, 0b00000000000000000000000000000000,	0b01000011000000010000000000000000,
						0b01000010111111100000000000000000, 0b11000010100000000000000000000000, 0b01000010111111100000000000000000,
						0b11000010111111100000000000000000, 0b01000001100000000000000000000000, 0b11000011000000010000000000000000,
						0b11000011000000010000000000000000, 0b11000001011000000000000000000000, 0b11000001111110000000000000000000,
						0b01000011000000010000000000000000, 0b01000011000000010000000000000000, 0b01000001011000000000000000000000,
						0b01000001111110000000000000000000, 0b01000010111111100000000000000000, 0b11000010100000000000000000000000,
						0b01000010111111100000000000000000, 0b11000010111111100000000000000000, 0b01000001100000000000000000000000,
						0b11000011000000010000000000000000, 0b11000011000000010000000000000000, 0b11000001011000000000000000000000,
						0b11000001111110000000000000000000, 0b01000010010011000000000000000000, 0b01000010111100000000000000000000,
						0b00111111100000000000000000000000, 0b11000010010011000000000000000000, 0b01000010111100000000000000000000,
						0b00111111100000000000000000000000, 0b11000010010011000000000000000000, 0b11000010111100000000000000000000,
						0b10111111100000000000000000000000, 0b01000001100010000000000000000000, 0b01000011011100110000000000000000,
						0b01000010001011000000000000000000, 0b01000000000000000000000000000000, 0b11000001100010000000000000000000,
						0b11000011011100110000000000000000, 0b11000010001011000000000000000000, 0b11000000000000000000000000000000,
						0b01000001100010000000000000000000, 0b01000011011100110000000000000000, 0b01000010001011000000000000000000,
						0b01000000000000000000000000000000, 0b11000001100010000000000000000000, 0b11000011011100110000000000000000,
						0b11000010001011000000000000000000, 0b11000000000000000000000000000000 };
	
	
	unsigned int B[] = { 0b00000000000000000000000000000000, 0b01000010111100000000000000000000, 0b01000010111100000000000000000000,
						 0b11000010111100000000000000000000, 0b11000010111100000000000000000000, 0b01000000100000001000000000000000,
						 0b01000000100000001000000000000000, 0b01111111000000010000000000000000, 0b11100000011100000000000000000000,
						 0b01111111000000010000000000000000, 0b11111111000000010000000000000000, 0b11111111100000000000000000000000,
						 0b01111111100000000000000000000000, 0b00000000000000000000000000000000, 0b01000010111100000000000000000000,
						 0b11000000010000000000000000000000, 0b01000010111111100000000000000000, 0b11000010000000000000000000000000,
						 0b01000001111100000000000000000000, 0b11000001110110000000000000000000, 0b11000010111100000000000000000000,
						 0b11000011000100000000000000000000, 0b11000010111111100000000000000000, 0b11000000000000000000000000000000,
						 0b01000010111100000000000000000000, 0b01000011000100000000000000000000, 0b01000010111111100000000000000000,
						 0b01000000000000000000000000000000, 0b11000000010000000000000000000000, 0b01000010111111100000000000000000,
						 0b11000010000000000000000000000000, 0b01000001111100000000000000000000, 0b11000001110110000000000000000000,
						 0b11000010111100000000000000000000, 0b11000011000100000000000000000000, 0b11000010111111100000000000000000,
						 0b11000000000000000000000000000000, 0b01000001110110000000000000000000, 0b01000000010000000000000000000000,
						 0b01000001101100000000000000000000, 0b01000001110110000000000000000000, 0b11000000010000000000000000000000,
						 0b11000001101100000000000000000000, 0b11000001110110000000000000000000, 0b11000000010000000000000000000000,
						 0b11000001101100000000000000000000, 0b01000000010000000000000000000000, 0b01000010010011000000000000000000,
						 0b01000010111000000000000000000000, 0b01000011001001100000000000000000, 0b01000000010000000000000000000000,
						 0b01000010010011000000000000000000, 0b01000010111000000000000000000000, 0b01000011001001100000000000000000,
						 0b11000000010000000000000000000000, 0b11000010010011000000000000000000, 0b11000010111000000000000000000000,
						 0b11000011001001100000000000000000, 0b11000000010000000000000000000000, 0b11000010010011000000000000000000,
						 0b11000010111000000000000000000000, 0b11000011001001100000000000000000 };

	unsigned int Sel[] = { 0b00, 0b00, 0b01, 0b10, 0b11, 0b00, 0b00,0b00, 0b10,
						   0b01, 0b11, 0b00, 0b10, 0b11, 0b00, 0b00, 0b00, 0b00,
						   0b00, 0b00, 0b00, 0b00, 0b00, 0b00, 0b01, 0b01, 0b01,
						   0b01, 0b01, 0b01, 0b01, 0b01, 0b01, 0b01, 0b01, 0b01,
						   0b01, 0b10, 0b10, 0b10, 0b10, 0b10, 0b10, 0b10, 0b10,
						   0b10, 0b11, 0b11, 0b11, 0b11, 0b11, 0b11, 0b11, 0b11,
						   0b11, 0b11, 0b11, 0b11, 0b11, 0b11, 0b11, 0b11 };
	unsigned int round[62] = { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 
								0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1,
								 1, 1, 1, 1, 1, 1, 1, 1};

	
	/*input set for tb_FPU.v*/
	/*
	unsigned int A[] = { 0b00001001001101010100101000000000,0b00001001001101010100101000000000,0b00001001001101010100101000000000,
0b01111111100000000000000000000000,0b01111111100000000000000000000000,0b01111111011100000000000000000000,
0b00000000100001110000000000000000,0b00001001001101010100101000000000, 0b00101001001100000000000000000000,
0b00001001001100000000000000000000, 0b00001001001100000000000000000000, 0b01111111100000000000000000000000,
0b01111111100000000000000000000000, 0b01111111000000000000000000000000, 0b00000110001000000000000000000000,
0b00000110001000000000000000000000, 0b01111111100000000000000000000000, 0b01111111100000000000000000000000,
0b00000000000000000000000000000000, 0b00000110001000000000000000000000, 0b00000000101000000000000000000000};
	unsigned int B[] = { 0b00000111001110001001001000000000,0b00000111001110001001001000000000,0b10000111001110001001001000000000,
0b00000111001110001001001000000000,0b11111111100000000000000000000000,0b01111111011100000000000000000000,
0b10000000100000010110000000000000,0b10000111001110001001001000000000,0b00100111001110000000000000000000,
0b00000111001110000000000000000000,0b00000000000000000000000000000000,0b00000111001110000000000000000000,
0b00000000000000000000000000000000,0b01000000000000000000000000000000,0b01000011001000000000000000000000,
0b00000000000000000000000000000000,0b00000000000000000000000000000000,0b01111111100000000000000000000000,
0b00000000000000000000000000000000,0b01111111100000000000000000000000,0b01000000000000000000000000000000
	};
	unsigned int Sel[] = { 0b00,	0b00,	0b00,	0b00,	0b00,	0b00,	0b00,	0b01,	0b10,	0b10,
	0b10,	0b10,	0b10,	0b10,	0b11,	0b11,	0b11,	0b11,	0b11,	0b11,	0b11	};
	unsigned int round[21] = { 0 };
	round[1] = 1;
	*/

	for (int i = 0; i < sizeof(A)/4; i++) {
		float result;
		printf("%d��° ����: %f ", i, bintofloat(A[i]));
		switch (Sel[i]) {
		case 0:
			result = bintofloat(A[i]) + bintofloat(B[i]);
			printf("+ ");
			break;
		case 1:
			result = bintofloat(A[i]) - bintofloat(B[i]);
			printf("- ");
			break;
		case 2:
			result = bintofloat(A[i]) * bintofloat(B[i]);
			printf("x ");
			break;
		case 3:
			result = bintofloat(A[i]) / bintofloat(B[i]);
			printf("/ ");
			break;
		default:
			printf("something wrong\n");
		}
		unsigned int temp = floattobin(result);
		if ((((temp >> 14) & 3) == 3) && (round[i] == 0))
			temp = (temp + (1 << 14));
		
		temp = temp & 0xffff8000;
		result = bintofloat(temp);
		printf("%f = %f -->16�����δ� 0x%x\n", bintofloat(B[i]), result, floattobin(result));
	}
	return 0;
}