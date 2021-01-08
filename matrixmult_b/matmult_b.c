/*
Copyright (c) 2015, Los Alamos National Security, LLC
All rights reserved.

Copyright 2015. Los Alamos National Security, LLC. This software was
produced under U.S. Government contract DE-AC52-06NA25396 for Los
Alamos National Laboratory (LANL), which is operated by Los Alamos
National Security, LLC for the U.S. Department of Energy. The
U.S. Government has rights to use, reproduce, and distribute this
software.  NEITHER THE GOVERNMENT NOR LOS ALAMOS NATIONAL SECURITY,
LLC MAKES ANY WARRANTY, EXPRESS OR IMPLIED, OR ASSUMES ANY LIABILITY
FOR THE USE OF THIS SOFTWARE.  If software is modified to produce
derivative works, such modified software should be clearly marked, so
as not to confuse it with the version available from LANL.

Additionally, redistribution and use in source and binary forms, with
or without modification, are permitted provided that the following
conditions are met:

• Redistributions of source code must retain the above copyright
         notice, this list of conditions and the following disclaimer.

• Redistributions in binary form must reproduce the above copyright
         notice, this list of conditions and the following disclaimer
         in the documentation and/or other materials provided with the
         distribution.

• Neither the name of Los Alamos National Security, LLC, Los Alamos
         National Laboratory, LANL, the U.S. Government, nor the names
         of its contributors may be used to endorse or promote
         products derived from this software without specific prior
         written permission.

THIS SOFTWARE IS PROVIDED BY LOS ALAMOS NATIONAL SECURITY, LLC AND
CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL LOS
ALAMOS NATIONAL SECURITY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/

//*****************************************************************************
//
// AUTHOR:  Heather Quinn
// CONTACT INFO:  hquinn@lanl.gov
// LAST EDITED: 12/21/15
//
// main.c
//
// This test is a simple program for calculating matrix multiplies.  Right now
// it takes approximately the same amount of memory as the cache test. 
//
// This software is otimized for the MSP430F2619.
//
// The output is designed to go out the UART at a speed of 9,600 baud and uses a tiny
// print to reduce the printf footprint.  The tiny printf can be downloaded from 
// http://www.43oh.com/forum/viewtopic.php?f=10&t=1732  All of the output is YAML
// parsable.
//
// The input is currently using random numbers that change values every few seconds 
// in a repeatable pattern.
//
//*****************************************************************************

//*****************************************************************************
// Modified by Hao on 02/16/2020

// The code is revised to a simpler matrix multiply benchmark program: 
// Successfully Compiled with the ARM cross compiler: arm-linux-gnueabihf-gcc;
// Binary is ready for run using the gem5 simulator
 
//*****************************************************************************


#include <string.h>
#include <stdlib.h>

#define		side				128
#define   s_block       16


int first_matrix[side][side];
int second_matrix[side][side];
unsigned long golden_matrix[side][side];

unsigned long int ind = 0;
int seed_value = -1;

void printf(char *, ...);

void init_matrices() {
  int i = 0;
  int j = 0;

  //seed the random number generator
  //the method is designed to reset SEUs in the matrices, using the current seed value
  //that way each test starts error free
  if (seed_value == -1) {
    srand(ind);
    seed_value = ind;
  }
  else {
    srand(seed_value);
  }

  //fill the matrices
  for ( i = 0; i < side; i++ ){
    for (j = 0; j < side; j++) {
      first_matrix[i][j] = rand();
      second_matrix[i][j] = rand();
    }
  }
}

void matrix_multiply_block(int f_matrix[][side], int s_matrix[][side], unsigned long r_matrix[][side]) {
  int jj = 0;
  int i = 0;
  int kk = 0;
  unsigned long temp =0; 

  for(int jj=0;jj<side;jj+= s_block){
        for(int kk=0;kk<side;kk+= s_block){
                for(int i=0;i<side;i++){
                        for(int j = jj; j<((jj+s_block)>side?side:(jj+s_block)); j++){
                                temp = 0;
                                for(int k = kk; k<((kk+s_block)>side?side:(kk+s_block)); k++){
                                        temp += f_matrix[i][k]*s_matrix[k][j];
                                }
                                r_matrix[i][j] += temp;
                        }
                }
        }
      }
}

void print_matrix(int size, unsigned long input_matrix[side][side]) {
    int i = 0;
    int j = 0;
    for (i = 0; i < size; i++){
      for (j = 0; j < size; j++){
        printf("%d     ", input_matrix[i][j]);
      }
    }
}


void matrix_multiply_test() {
  
  init_matrices();
  //setup golden values
  matrix_multiply_block(first_matrix, second_matrix, golden_matrix);
  print_matrix(side, golden_matrix);
}

int main()
{
  printf("Side matrix size: %i\r\n", side);
  //start test
  matrix_multiply_test();
  
  return 0;

}

