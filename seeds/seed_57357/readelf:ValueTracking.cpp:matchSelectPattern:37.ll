target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @ctf_bufopen_internal() {
entry:
  %call5001 = call i32 @init_symtab(ptr null, i32 0)
  ret ptr null
}

define internal i32 @init_symtab(ptr %hp.addr, i32 %0) {
entry:
  %cmp9 = icmp uge i32 0, %0
  %or.cond = select i1 %cmp9, i1 false, i1 true
  br i1 %or.cond, label %if.end17, label %if.then12

if.then12:                                        ; preds = %entry
  %1 = load ptr, ptr %hp.addr, align 8
  br label %if.end17

if.end17:                                         ; preds = %if.then12, %entry
  ret i32 0
}
