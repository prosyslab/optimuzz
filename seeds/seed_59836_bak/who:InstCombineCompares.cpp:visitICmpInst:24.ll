target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb6

sw.bb6:                                           ; preds = %sw.bb6, %entry
  br label %sw.bb6

if.then:                                          ; No predecessors!
  switch i32 0, label %sw.default30 [
    i32 2, label %sw.bb27
    i32 -1, label %sw.bb27
    i32 0, label %sw.bb27
    i32 1, label %sw.epilog35
  ]

sw.bb27:                                          ; preds = %if.then, %if.then, %if.then
  call void @who()
  br label %sw.epilog35

sw.default30:                                     ; preds = %if.then
  unreachable

sw.epilog35:                                      ; preds = %sw.bb27, %if.then
  ret i32 0
}

define internal void @who() {
entry:
  unreachable

if.else:                                          ; No predecessors!
  call void @scan_entries()
  ret void
}

define internal void @scan_entries() {
entry:
  call void @print_user()
  ret void
}

define internal void @print_user() {
entry:
  %call271 = call ptr @idle_string(ptr null, i64 0)
  ret void
}

define internal ptr @idle_string(ptr %idle_string.now, i64 %0) {
entry:
  %1 = trunc i64 %0 to i32
  %2 = sext i32 %1 to i64
  %3 = icmp ne i64 %0, %2
  br i1 %3, label %common.ret, label %land.lhs.true4

common.ret:                                       ; preds = %land.lhs.true4, %entry
  ret ptr null

land.lhs.true4:                                   ; preds = %entry
  %4 = load i32, ptr %idle_string.now, align 4
  br label %common.ret
}
