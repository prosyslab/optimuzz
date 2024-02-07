target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end33:                                         ; No predecessors!
  %call38 = call ptr @merge_zip()
  unreachable
}

define internal ptr @merge_zip() {
entry:
  br label %return

sw.bb15:                                          ; No predecessors!
  %call161 = call i32 @copy_file(ptr null, i1 false, i32 0)
  br label %return

return:                                           ; preds = %sw.bb15, %entry
  ret ptr null
}

define internal i32 @copy_file(ptr %st, i1 %tobool15, i32 %conv) {
entry:
  %cmp17 = icmp eq i32 %conv, 0
  %or.cond = select i1 %tobool15, i1 %cmp17, i1 false
  br i1 %or.cond, label %if.then19, label %if.end21

if.then19:                                        ; preds = %entry
  %0 = load ptr, ptr %st, align 8
  br label %if.end21

if.end21:                                         ; preds = %if.then19, %entry
  ret i32 0
}
