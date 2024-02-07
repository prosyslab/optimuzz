target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @fd_read_body(ptr %flags.addr, i32 %0) {
entry:
  %and2 = and i32 %0, 4
  %tobool3 = icmp ne i32 %and2, 0
  %frombool4 = zext i1 %tobool3 to i8
  store i8 %frombool4, ptr %flags.addr, align 1
  ret i32 0
}
