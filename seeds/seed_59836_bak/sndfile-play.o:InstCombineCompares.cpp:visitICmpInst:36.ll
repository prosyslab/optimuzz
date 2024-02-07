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

define internal void @alsa_play(ptr %call3) {
entry:
  %tobool.not = icmp eq ptr %call3, null
  br i1 %tobool.not, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %call4 = call ptr @sf_strerror()
  br label %common.ret
}

declare ptr @sf_strerror()
