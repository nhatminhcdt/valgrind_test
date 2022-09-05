#ifndef INCLUDE_MEMORY_TEST_H_
#define INCLUDE_MEMORY_TEST_H_

//  Invalid free() / delete / delete[] / realloc() (test)
void invalid_mem_delete_test();
//  Invalid write of size (test)
void invalid_write_test();
//  leaked memory (test)
void leaked_memory_test();
//  Points to uninitialised byte test (test)
void points_to_uninitialised_byte_test();

#endif  // INCLUDE_MEMORY_TEST_H_
