target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @nstrftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, i32 0)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %tp.addr, i32 %0) {
entry:
  %cmp322 = icmp slt i32 %0, 0
  %conv323 = zext i1 %cmp322 to i32
  %and = and i32 1, %conv323
  %tobool324 = icmp ne i32 %and, 0
  %frombool325 = zext i1 %tobool324 to i8
  store i8 %frombool325, ptr %tp.addr, align 1
  ret i64 0
}
