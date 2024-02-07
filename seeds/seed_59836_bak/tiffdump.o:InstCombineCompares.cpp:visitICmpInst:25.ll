target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb8

sw.bb8:                                           ; preds = %sw.bb8, %entry
  br label %sw.bb8

if.then22:                                        ; No predecessors!
  call void @dump(ptr null, i32 0)
  ret i32 0
}

define internal void @dump(ptr %count_visited_dir, i32 %0) {
entry:
  %conv95 = zext i32 %0 to i64
  %mul96 = mul i64 %conv95, 8
  store i64 %mul96, ptr %count_visited_dir, align 8
  %1 = load i64, ptr %count_visited_dir, align 8
  %cmp98 = icmp eq i64 %1, 0
  br i1 %cmp98, label %if.then100, label %common.ret

common.ret:                                       ; preds = %if.then100, %entry
  ret void

if.then100:                                       ; preds = %entry
  %2 = load ptr, ptr %count_visited_dir, align 8
  br label %common.ret
}
