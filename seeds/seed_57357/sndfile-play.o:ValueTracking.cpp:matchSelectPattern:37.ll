target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.SF_INFO = type { i64, i32, i32, i32, i32, i32 }

define i32 @main() {
entry:
  call void @alsa_play(ptr null, i32 0)
  ret i32 0
}

define internal void @alsa_play(ptr %sfinfo, i32 %0) {
entry:
  %cmp6 = icmp slt i32 %0, 0
  %or.cond = select i1 %cmp6, i1 false, i1 true
  br i1 %or.cond, label %if.then9, label %if.end12

if.then9:                                         ; preds = %entry
  %channels10 = getelementptr inbounds %struct.SF_INFO, ptr %sfinfo, i32 0, i32 2
  br label %if.end12

if.end12:                                         ; preds = %if.then9, %entry
  ret void
}
