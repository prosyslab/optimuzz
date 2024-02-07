target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end251:                                        ; No predecessors!
  %call2551 = call i64 @io_blksize(ptr null)
  unreachable
}

define internal i64 @io_blksize(ptr %sb) {
entry:
  %0 = load i64, ptr %sb, align 8
  %1 = load i64, ptr %sb, align 8
  %sub21 = sub i64 %1, 1
  %and22 = and i64 %0, %sub21
  %tobool = icmp ne i64 %and22, 0
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i64 0

if.then:                                          ; preds = %entry
  %2 = load i64, ptr %sb, align 8
  br label %common.ret
}
