target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse() {
entry:
  call void @debug_print_current_time()
  ret i32 0
}

define internal void @debug_print_current_time() {
entry:
  %call821 = call ptr @time_zone_str(ptr null, i32 0)
  ret void
}

define internal ptr @time_zone_str(ptr %time_zone.addr, i32 %0) {
entry:
  %call = call i32 @abs(i32 %0)
  store i32 %call, ptr %time_zone.addr, align 4
  ret ptr null
}

declare i32 @abs(i32)
