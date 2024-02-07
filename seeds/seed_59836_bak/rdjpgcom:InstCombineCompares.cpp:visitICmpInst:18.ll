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
  %call1 = call i32 @first_marker(i32 0)
  ret i32 0
}

define internal i32 @first_marker(i32 %0) {
entry:
  %cmp = icmp ne i32 %0, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  call void @llvm.assume(i1 %or.cond)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
