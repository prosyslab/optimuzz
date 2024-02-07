target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @archive_string_vsprintf() {
entry:
  unreachable

sw.epilog195:                                     ; No predecessors!
  switch i32 0, label %for.inc [
    i32 1, label %sw.bb197
    i32 0, label %for.inc
  ]

sw.bb197:                                         ; preds = %sw.epilog195
  call void @append_uint(i64 0, ptr null)
  br label %for.inc

for.inc:                                          ; preds = %for.inc, %sw.bb197, %sw.epilog195, %sw.epilog195
  br label %for.inc
}

define internal void @append_uint(i64 %d, ptr %base.addr) {
entry:
  %cmp = icmp uge i64 0, %d
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %base.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
