target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb3

sw.bb3:                                           ; preds = %sw.bb3, %entry
  br label %sw.bb3

do.body:                                          ; preds = %do.body
  %call53 = call i32 @tiffcvt()
  br label %do.body
}

define internal i32 @tiffcvt() {
entry:
  br label %return

if.then63:                                        ; No predecessors!
  %call641 = call i32 @cvt_by_tile(i32 0)
  br label %return

return:                                           ; preds = %if.then63, %entry
  ret i32 0
}

define internal i32 @cvt_by_tile(i32 %0) {
entry:
  %conv10 = zext i32 %0 to i64
  %cmp = icmp ne i64 %conv10, 0
  call void @llvm.assume(i1 %cmp)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
