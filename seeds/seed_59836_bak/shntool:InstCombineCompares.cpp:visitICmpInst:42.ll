target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.3 = private constant [1 x i8] zeroinitializer

declare i32 @strcmp(ptr, ptr)

define i32 @clobber_check() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  switch i32 0, label %return [
    i32 0, label %sw.bb
    i32 1, label %return
    i32 2, label %return
  ]

sw.bb:                                            ; preds = %if.end
  %call11 = call i32 @clobber_ask(ptr null)
  br label %return

return:                                           ; preds = %sw.bb, %if.end, %if.end, %if.end, %entry
  ret i32 0
}

define internal i32 @clobber_ask(ptr %response) {
entry:
  br label %while.cond16

while.cond16:                                     ; preds = %while.cond16, %entry
  %call18 = call i32 @strcmp(ptr %response, ptr @.str.3)
  %tobool19 = icmp ne i32 %call18, 0
  br i1 %tobool19, label %while.cond16, label %while.end

while.end:                                        ; preds = %while.cond16
  ret i32 0
}
