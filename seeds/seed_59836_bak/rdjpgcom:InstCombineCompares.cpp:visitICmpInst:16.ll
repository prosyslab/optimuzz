target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end38:                                         ; No predecessors!
  %call41 = call i32 @scan_JPEG_header()
  unreachable
}

define internal i32 @scan_JPEG_header() {
entry:
  unreachable

sw.default:                                       ; No predecessors!
  call void @skip_variable(i32 0)
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.epilog, %sw.default
  br label %sw.epilog
}

define internal void @skip_variable(i32 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp2 = icmp ugt i32 %0, 0
  br i1 %cmp2, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret void
}
