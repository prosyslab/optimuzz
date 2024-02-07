target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @execute(i8 %call6, ptr %var_name) {
entry:
  %conv7 = zext i8 %call6 to i64
  %and = and i64 %conv7, 128
  %cmp8 = icmp ne i64 %and, 0
  %spec.store.select = select i1 %cmp8, i64 0, i64 %conv7
  store i64 %spec.store.select, ptr %var_name, align 8
  ret void
}
