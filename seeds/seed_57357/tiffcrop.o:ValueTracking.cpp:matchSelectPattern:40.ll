target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @process_command_opts(i32 %call324, ptr %crop_data.addr) {
entry:
  %cmp325 = icmp eq i32 %call324, 0
  br i1 %cmp325, label %if.then327, label %if.end329

if.then327:                                       ; preds = %entry
  %0 = load ptr, ptr %crop_data.addr, align 8
  br label %if.end329

if.end329:                                        ; preds = %if.then327, %entry
  ret void
}
