target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @backupfile_internal() {
entry:
  br label %return

if.else:                                          ; No predecessors!
  %call1512 = call i32 @numbered_backup(ptr null, i64 0)
  switch i32 0, label %return [
    i32 0, label %return
    i32 2, label %return
    i32 1, label %return
    i32 3, label %return
  ]

return:                                           ; preds = %if.else, %if.else, %if.else, %if.else, %if.else, %entry
  ret ptr null
}

define internal i32 @numbered_backup(ptr %new_buffer_size, i64 %0) {
entry:
  %1 = call { i64, i1 } @llvm.sadd.with.overflow.i64(i64 %0, i64 0)
  %2 = extractvalue { i64, i1 } %1, 0
  store i64 %2, ptr %new_buffer_size, align 8
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.sadd.with.overflow.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
