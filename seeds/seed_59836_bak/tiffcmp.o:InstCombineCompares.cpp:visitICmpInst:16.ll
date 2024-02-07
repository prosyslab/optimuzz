target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb

sw.bb:                                            ; preds = %sw.bb, %entry
  br label %sw.bb

if.end16:                                         ; No predecessors!
  br label %while.cond17

while.cond17:                                     ; preds = %while.cond17, %if.end16
  %call181 = call i32 @tiffcmp(ptr null, i16 0)
  br label %while.cond17
}

define internal i32 @tiffcmp(ptr %samplesperpixel, i16 %0) {
entry:
  %conv35 = zext i16 %0 to i32
  %cmp36 = icmp sgt i32 %conv35, 0
  br i1 %cmp36, label %if.then38, label %common.ret

common.ret:                                       ; preds = %if.then38, %entry
  ret i32 0

if.then38:                                        ; preds = %entry
  %1 = load ptr, ptr %samplesperpixel, align 8
  br label %common.ret
}
