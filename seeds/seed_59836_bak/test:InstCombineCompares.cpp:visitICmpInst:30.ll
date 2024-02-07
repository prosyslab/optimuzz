target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.char_directives = type { i64, ptr, i64, i64, [7 x %struct.char_directive] }
%struct.char_directive = type { ptr, ptr, i32, ptr, ptr, i64, ptr, ptr, i64, i8, i64 }

define ptr @vasnprintf(ptr %d) {
entry:
  %0 = load ptr, ptr %d, align 8
  %direct_alloc_dir2104 = getelementptr %struct.char_directives, ptr %d, i32 0, i32 4
  %cmp2106 = icmp ne ptr %0, %direct_alloc_dir2104
  br i1 %cmp2106, label %if.then2108, label %if.end2110

if.then2108:                                      ; preds = %entry
  %dir2109 = getelementptr %struct.char_directives, ptr %d, i32 0, i32 1
  br label %if.end2110

if.end2110:                                       ; preds = %if.then2108, %entry
  ret ptr null
}
