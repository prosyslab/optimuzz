target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @x11_start_xvfb(ptr %dquote, i8 %0) {
entry:
  %tobool59 = trunc i8 %0 to i1
  %lnot = xor i1 %tobool59, true
  %frombool = zext i1 %lnot to i8
  store i8 %frombool, ptr %dquote, align 1
  ret void
}
