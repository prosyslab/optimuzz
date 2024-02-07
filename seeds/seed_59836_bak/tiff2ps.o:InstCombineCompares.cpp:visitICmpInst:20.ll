target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @PS_Lvl2page() {
entry:
  call void @PS_Lvl2colorspace(ptr null, i32 0)
  ret i32 0
}

define internal void @PS_Lvl2colorspace(ptr %i, i32 %0) {
entry:
  br label %for.cond51

for.cond51:                                       ; preds = %for.cond51, %entry
  %rem = srem i32 %0, 8
  %tobool67 = icmp ne i32 %rem, 0
  %cond = select i1 %tobool67, ptr %i, ptr null
  %call68 = load volatile i32, ptr %cond, align 4
  br label %for.cond51
}
