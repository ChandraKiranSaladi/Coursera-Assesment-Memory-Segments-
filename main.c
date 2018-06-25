/******************************************************************************
 * Copyright (C) 2017 by Alex Fosdick - University of Colorado
 *
 * Redistribution, modification or use of this software in source or binary
 * forms is permitted as long as the files maintain this copyright. Users are 
 * permitted to modify this and use it to learn about the field of embedded
 * software. Alex Fosdick and the University of Colorado are not liable for any
 * misuse of this material. 
 *
 *****************************************************************************/
/**
 * @file main.c
 * @brief This file is to be used for the c1m3 assessment.
 *
 * This file provides various memory allocations. The learner will need
 * to analyze the code's memory footprint for this assessment.
 *
 * @author Alex Fosdick
 * @date April 2, 2017
 *
 */
#include <stdint.h>
#include <stdlib.h>
#include "misc.h"

static int g1;  // .bss , 4 bytes
const int g2 = 45; // code--> .const 4 bytes
char g3 = 12; // .data 1 byte at run time, before stores at .cinit or .pinit
char g4 = 0;  // .bss
extern char g5[N];  // N = 10U , 5 bytes. .bss

int main()
{
  register int l1; // Where is it stored? In .bss or in CPu registers?
  int * l2;  // stack, 2 bytes. 
  volatile int l3 = 12; // volatile is used when we map with the hardware. Volatile tells the compiler not to 
			// optimize anything that has to do with the volatile variable.
  
  l2 = (int *) malloc( N * g2 * sizeof(char) );  // 10U * 45 * 4 = 1800

  if ( ! l2 )
  {
    return -1;
  }

  for( l1 = 0; l1 < g2; l3++)
  {
    g1 = func(l2);
  }

  return 0;
}

