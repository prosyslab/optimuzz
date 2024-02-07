target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end99:                                         ; No predecessors!
  br label %while.cond100

while.cond100:                                    ; preds = %while.cond100, %if.end99
  %call104 = call i32 @process_file()
  br label %while.cond100
}

define internal i32 @process_file() {
entry:
  br label %return

if.then29:                                        ; No predecessors!
  %call301 = call i32 @update_gnu_property(ptr null, i64 0)
  br label %return

return:                                           ; preds = %if.then29, %entry
  ret i32 0
}

define internal i32 @update_gnu_property(ptr %size, i64 %0) {
entry:
  %cmp180 = icmp ugt i64 1, %0
  br i1 %cmp180, label %if.then182, label %common.ret

common.ret:                                       ; preds = %if.then182, %entry
  ret i32 0

if.then182:                                       ; preds = %entry
  store i32 0, ptr %size, align 4
  br label %common.ret
}
