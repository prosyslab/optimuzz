target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

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
  %call301 = call i32 @update_gnu_property(ptr null, ptr null, i64 0)
  br label %return

return:                                           ; preds = %if.then29, %entry
  ret i32 0
}

define internal i32 @update_gnu_property(ptr %p, ptr %0, i64 %1) {
entry:
  %2 = load ptr, ptr %p, align 8
  %add.ptr177 = getelementptr i8, ptr %0, i64 %1
  %cmp178 = icmp ult ptr %2, %add.ptr177
  br i1 %cmp178, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret i32 0

while.body:                                       ; preds = %entry
  %3 = load ptr, ptr %p, align 8
  br label %common.ret
}
