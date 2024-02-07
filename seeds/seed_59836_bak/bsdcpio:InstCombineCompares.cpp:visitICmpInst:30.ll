target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @__archive_pathmatch() {
entry:
  br label %return

while.end43:                                      ; No predecessors!
  %call = call i32 @pm()
  br label %return

return:                                           ; preds = %while.end43, %entry
  ret i32 0
}

define internal i32 @pm() {
entry:
  %call841 = call i32 @pm_list(ptr null, ptr null)
  ret i32 0
}

define internal i32 @pm_list(ptr %p, ptr %0) {
entry:
  %1 = load ptr, ptr %p, align 8
  %add.ptr = getelementptr i8, ptr %0, i64 -1
  %cmp14 = icmp eq ptr %1, %add.ptr
  br i1 %cmp14, label %if.then16, label %common.ret

common.ret:                                       ; preds = %if.then16, %entry
  ret i32 0

if.then16:                                        ; preds = %entry
  %2 = load ptr, ptr %p, align 8
  br label %common.ret
}
