target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %return

if.then6:                                         ; No predecessors!
  call void @alsa_play()
  br label %return

return:                                           ; preds = %if.then6, %entry
  ret i32 0
}

define internal void @alsa_play() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

for.cond28:                                       ; preds = %for.end, %for.cond28
  br label %for.cond28

for.end:                                          ; No predecessors!
  %call391 = call i32 @alsa_write_float(ptr null, i32 0)
  br label %for.cond28
}

define internal i32 @alsa_write_float(ptr %retval1, i32 %0) {
entry:
  %cmp4 = icmp sge i32 %0, 0
  br i1 %cmp4, label %if.then6, label %common.ret

common.ret:                                       ; preds = %if.then6, %entry
  ret i32 0

if.then6:                                         ; preds = %entry
  %1 = load i32, ptr %retval1, align 4
  br label %common.ret
}
