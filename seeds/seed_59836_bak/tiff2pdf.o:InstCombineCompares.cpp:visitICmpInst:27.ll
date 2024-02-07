target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.90 = external constant [7 x i8]
@__const.tiff2pdf_match_paper_size.sizes = private constant [80 x ptr] [ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null, ptr @.str.90, ptr null]

define i32 @tiff2pdf_match_paper_size(i64 %0) {
entry:
  %sizes = alloca [80 x ptr], align 16
  call void @llvm.memcpy.p0.p0.i64(ptr %sizes, ptr @__const.tiff2pdf_match_paper_size.sizes, i64 0, i1 false)
  br label %for.cond4

for.cond4:                                        ; preds = %for.cond4, %entry
  %arrayidx5 = getelementptr [80 x ptr], ptr %sizes, i64 0, i64 %0
  %1 = load ptr, ptr %arrayidx5, align 8
  %cmp6 = icmp ne ptr %1, null
  br i1 %cmp6, label %for.cond4, label %for.end19

for.end19:                                        ; preds = %for.cond4
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
