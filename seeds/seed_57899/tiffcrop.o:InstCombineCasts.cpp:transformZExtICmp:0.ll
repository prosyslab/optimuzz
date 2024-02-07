target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @process_command_opts(ptr %crop_data.addr, i32 %conv625) {
entry:
  %tobool627.not = icmp ne i32 %conv625, 0
  %conv628 = zext i1 %tobool627.not to i8
  store i8 %conv628, ptr %crop_data.addr, align 1
  ret void
}
