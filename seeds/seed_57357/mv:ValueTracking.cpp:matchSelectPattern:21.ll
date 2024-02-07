target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @backupfile_internal(ptr %backup_suffix_size_guess) {
entry:
  %0 = load i64, ptr %backup_suffix_size_guess, align 8
  %cmp = icmp slt i64 %0, 9
  %spec.store.select = select i1 %cmp, i64 9, i64 %0
  store i64 %spec.store.select, ptr %backup_suffix_size_guess, align 8
  ret ptr null
}
