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
  %call161 = call i32 @copy_file(ptr null, i16 0)
  br label %return

return:                                           ; preds = %sw.bb15, %entry
  ret ptr null
}

define internal i32 @copy_file(ptr %st, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp17 = icmp eq i32 %conv, 0
  br i1 %cmp17, label %if.then19, label %if.end21

if.then19:                                        ; preds = %entry
  %1 = load ptr, ptr %st, align 8
  br label %if.end21

if.end21:                                         ; preds = %if.then19, %entry
  ret i32 0
}
