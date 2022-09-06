/**
 * @file memory_test.cpp
 * @author Nhat Minh (nhatminh.cdt@gmail.com)
 * @brief Contain functions of how memory could be used
 * @ref https://www.youtube.com/watch?v=bb1bTJtgXrI
 * @version 0.1
 * @date 2022-09-05
 * 
 * @copyright Copyright (c) 2022
 * 
 */

/**
 * @brief include
 * 
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

/**
 * @brief Invalid free() / delete / delete[] / realloc() (test)
 * 
 */
void invalid_mem_delete_test() {
  printf("-- invalid_mem_delete_test --\n");
  const int NUM_HEIGHTS = 3;
  int *heights = new int[NUM_HEIGHTS];
  for (int i = 0; i < NUM_HEIGHTS; i++) {
    heights[i] = i * i;
    printf("%d: %d\n", i, heights[i]);
  }
  delete [] heights;
}
/**
 * @brief Invalid write of size (test)
 * 
 */
void invalid_write_test() {
  printf("-- invalid_write_test --\n");
  const int NUM_WEIGHTS = 5;
  int64_t *weights = new int64_t[(NUM_WEIGHTS * sizeof(weights))];
  for (int i = 0; i < NUM_WEIGHTS; i++) {
    weights[i] = 100 + i;
  }
  weights[0] = 0;
  delete [] weights;
}
/**
 * @brief leaked memory (test)
 * 
 */
void leaked_memory_test() {
  printf("-- leaked_memory_test --\n");
  const int NUM_HEIGHTS = 10;
  int *heights = new int[(NUM_HEIGHTS * sizeof(*heights))];
  if ((heights == NULL)) {
    heights = new int[NUM_HEIGHTS];
  }
  delete [] heights;
}
/**
 * @brief Get the String object
 * 
 * @return char* pointer of message
 */
char *getString() {
  static char message[100] = "Hello world!";
  char *ret = message;
  return ret;
}
/**
 * @brief Points to uninitialised byte test (test)
 * 
 */
void points_to_uninitialised_byte_test() {
  printf("-- points_to_uninitialised_byte_test --\n");
  printf("String: %s\n", getString());
}
