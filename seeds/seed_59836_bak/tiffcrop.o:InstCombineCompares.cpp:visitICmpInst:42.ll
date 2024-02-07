target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @process_command_opts(ptr %dump.addr) {
entry:
  %call243 = call i64 @strlen(ptr %dump.addr)
  %tobool244 = icmp ne i64 %call243, 0
  br i1 %tobool244, label %if.then249, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %0 = load ptr, ptr %dump.addr, align 8
  br label %if.then249

if.then249:                                       ; preds = %lor.lhs.false, %entry
  ret void
}

declare i64 @strlen(ptr)
