target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @ensure_header(ptr %output.addr) {
entry:
  %cmp = icmp ne ptr %output.addr, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %output.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define void @diff_output_file() {
entry:
  call void @ensure_header(ptr null)
  ret void
}
