target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.SF_INFO = type { i64, i32, i32, i32, i32, i32 }

define i32 @main() {
entry:
  br label %return

if.then6:                                         ; No predecessors!
  call void @alsa_play(ptr null, i32 0, i1 false)
  br label %return

return:                                           ; preds = %if.then6, %entry
  ret i32 0
}

define internal void @alsa_play(ptr %sfinfo, i32 %0, i1 %cmp6) {
entry:
  %cmp8 = icmp sgt i32 %0, 0
  %or.cond = select i1 %cmp6, i1 false, i1 %cmp8
  br i1 %or.cond, label %if.then9, label %common.ret

common.ret:                                       ; preds = %if.then9, %entry
  ret void

if.then9:                                         ; preds = %entry
  %channels10 = getelementptr %struct.SF_INFO, ptr %sfinfo, i32 0, i32 2
  br label %common.ret
}
