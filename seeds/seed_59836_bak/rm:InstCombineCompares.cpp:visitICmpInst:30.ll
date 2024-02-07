target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._ftsent = type { ptr, ptr, ptr, ptr, i64, ptr, ptr, ptr, i32, i32, i64, ptr, i64, i64, i16, i16, i16, [1 x %struct.stat], [0 x i8] }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.dev_ino, %struct.dev_ino, %struct.dev_ino, [3 x i64] }
%struct.dev_ino = type { i64, i64 }

define ptr @rpl_fts_read() {
entry:
  br label %return

if.end171:                                        ; No predecessors!
  call void @fts_load(ptr null, ptr null)
  br i1 false, label %return, label %return

return:                                           ; preds = %if.end171, %if.end171, %entry
  ret ptr null
}

define internal void @fts_load(ptr %cp, ptr %0) {
entry:
  %1 = load ptr, ptr %cp, align 8
  %fts_name3 = getelementptr %struct._ftsent, ptr %0, i32 0, i32 18
  %cmp = icmp ne ptr %1, %fts_name3
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %2 = load ptr, ptr %cp, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  ret void
}
