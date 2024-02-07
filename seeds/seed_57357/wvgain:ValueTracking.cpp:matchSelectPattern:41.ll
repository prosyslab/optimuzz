target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i1 %.b289.i) {
entry:
  %spec.select.i = select i1 %.b289.i, i32 530, i32 0
  %call.i = call ptr @WavpackOpenFileInput(i32 %spec.select.i)
  ret i32 0
}

declare ptr @WavpackOpenFileInput(i32)
