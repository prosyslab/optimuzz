#include <cstdint>
#include <cstdio>

static FILE *f;

extern "C" void ___optmuzz_coverage(uint64_t block_id) {
  if (!f) {
    f = fopen("cov.cov", "a");
  }
  fprintf(f, "%p\n", (void *)block_id);
  return;
}