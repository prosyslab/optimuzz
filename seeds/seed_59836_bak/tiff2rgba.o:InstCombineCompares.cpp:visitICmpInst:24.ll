target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb33

sw.bb33:                                          ; preds = %sw.bb33, %entry
  br label %sw.bb33

do.body:                                          ; preds = %do.body
  %call53 = call i32 @tiffcvt()
  br label %do.body
}

define internal i32 @tiffcvt() {
entry:
  br label %return

if.then63:                                        ; No predecessors!
  %call64 = call i32 @cvt_by_tile()
  br label %return

return:                                           ; preds = %if.then63, %entry
  ret i32 0
}

define internal i32 @cvt_by_tile() {
entry:
  %tile_width = alloca i32, align 4
  %wrk_linesize = alloca i32, align 4
  %0 = load i32, ptr %tile_width, align 4
  %conv24 = zext i32 %0 to i64
  %mul25 = mul i64 %conv24, 4
  %conv26 = trunc i64 %mul25 to i32
  store i32 %conv26, ptr %wrk_linesize, align 4
  %1 = load i32, ptr %tile_width, align 4
  %conv27 = zext i32 %1 to i64
  %2 = load i32, ptr %wrk_linesize, align 4
  %conv28 = zext i32 %2 to i64
  %div29 = udiv i64 %conv28, 4
  %cmp30 = icmp ne i64 %conv27, %div29
  call void @llvm.assume(i1 %cmp30)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
