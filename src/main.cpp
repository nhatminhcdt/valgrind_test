/**
 * @file main.cpp
 * @author Nhat Minh (nhatminh.cdt@gmail.com)
 * @brief Valgrind memory test
 * @version 0.1
 * @date 2022-08-31
 * 
 * @copyright Copyright (c) 2022
 * 
 */

/**
 * @brief include
 * 
 */
#include "../include/memory_test.h"
#include "../include/pointer_test.h"

/**
 * @brief Main function
 * 
 * @param argc 
 * @param args 
 * @return int 
 */
int main(int argc, char* args[]) {
  invalid_mem_delete_test();
  invalid_write_test();
  leaked_memory_test();
  points_to_uninitialised_byte_test();
  pointer_memory_leaked_test();
  return 0;
}
