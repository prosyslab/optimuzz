target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @__errno_location()

define ptr @rpl_fts_open(i32 %0) {
entry:
  %and = and i32 %0, -4096
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %call = call ptr @__errno_location()
  br label %common.ret
}
