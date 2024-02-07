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
  %add94 = add i32 %0, 1
  %conv95 = zext i32 %add94 to i64
  store i64 %conv95, ptr %count_visited_dir, align 8
  %1 = load i64, ptr %count_visited_dir, align 8
  %cmp98 = icmp eq i64 %1, 0
  br i1 %cmp98, label %common.ret, label %if.else104

common.ret:                                       ; preds = %if.else104, %entry
  ret void

if.else104:                                       ; preds = %entry
  %2 = load i64, ptr %count_visited_dir, align 8
  br label %common.ret
}
