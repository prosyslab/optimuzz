target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @num_processors(ptr %retval) {
entry:
  %omp_env_limit = alloca i64, align 8
  %omp_env_threads = alloca i64, align 8
  %0 = load i64, ptr %omp_env_threads, align 8
  %1 = load i64, ptr %omp_env_limit, align 8
  %cmp7 = icmp ult i64 %0, %1
  %2 = load i64, ptr %omp_env_threads, align 8
  %3 = load i64, ptr %omp_env_limit, align 8
  %cond = select i1 %cmp7, i64 %2, i64 %3
  store i64 %cond, ptr %retval, align 8
  ret i64 0
}
