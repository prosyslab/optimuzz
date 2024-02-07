target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %return

if.then6:                                         ; No predecessors!
  call void @alsa_play(ptr null)
  br label %return

return:                                           ; preds = %if.then6, %entry
  ret i32 0
}

define internal void @alsa_play(ptr %sndfile) {
entry:
  %subformat = alloca i32, align 4
  %0 = load i32, ptr %subformat, align 4
  %cmp18 = icmp eq i32 %0, 6
  %1 = load i32, ptr %subformat, align 4
  %cmp20 = icmp eq i32 %1, 7
  %or.cond = select i1 %cmp18, i1 true, i1 %cmp20
  br i1 %or.cond, label %if.then21, label %common.ret

common.ret:                                       ; preds = %if.then21, %entry
  ret void

if.then21:                                        ; preds = %entry
  %2 = load ptr, ptr %sndfile, align 8
  br label %common.ret
}
