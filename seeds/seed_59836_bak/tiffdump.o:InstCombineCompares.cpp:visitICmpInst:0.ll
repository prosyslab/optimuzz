target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb8

sw.bb8:                                           ; preds = %sw.bb8, %entry
  br label %sw.bb8

if.then22:                                        ; No predecessors!
  call void @dump(ptr null, i32 0)
  ret i32 0
}

define internal void @dump(ptr %hdr, i32 %conv8) {
entry:
  %cmp9 = icmp ne i32 0, %conv8
  br i1 %cmp9, label %if.then11, label %if.end14

if.then11:                                        ; preds = %entry
  %0 = load i16, ptr %hdr, align 8
  br label %if.end14

if.end14:                                         ; preds = %if.then11, %entry
  ret void
}
