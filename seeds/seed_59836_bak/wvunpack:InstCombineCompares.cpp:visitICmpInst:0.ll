target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

if.then696:                                       ; No predecessors!
  %call740 = call i32 @unpack_file()
  ret i32 0
}

define internal i32 @unpack_file() {
entry:
  br label %return

cond.true309:                                     ; No predecessors!
  %call4221 = call i32 @unpack_dsd_audio(ptr null, i64 0)
  br label %return

return:                                           ; preds = %cond.true309, %entry
  ret i32 0
}

define internal i32 @unpack_dsd_audio(ptr %total_unpacked_samples, i64 %0) {
entry:
  %cmp36 = icmp sgt i64 0, %0
  br i1 %cmp36, label %if.then38, label %if.end41

if.then38:                                        ; preds = %entry
  %1 = load i64, ptr %total_unpacked_samples, align 8
  br label %if.end41

if.end41:                                         ; preds = %if.then38, %entry
  ret i32 0
}
