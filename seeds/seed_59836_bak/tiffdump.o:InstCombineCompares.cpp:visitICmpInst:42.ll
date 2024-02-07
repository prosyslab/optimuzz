target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb8

sw.bb8:                                           ; preds = %sw.bb8, %entry
  br label %sw.bb8

if.then22:                                        ; No predecessors!
  call void @dump(ptr null, i16 0)
  ret i32 0
}

declare i32 @printf(ptr, ...)

define internal void @dump(ptr %hdr, i16 %0) {
entry:
  %conv39 = zext i16 %0 to i32
  %cmp40 = icmp eq i32 %conv39, 0
  %cond = select i1 %cmp40, ptr %hdr, ptr null
  %call42 = call i32 (ptr, ...) @printf(ptr null, i32 0, ptr %cond, i32 0, ptr null)
  ret void
}
