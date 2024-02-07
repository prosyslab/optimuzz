target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.then6:                                         ; No predecessors!
  %call81 = call ptr @xalloc(ptr null)
  br label %for.cond18

for.cond18:                                       ; preds = %for.cond18, %if.then6
  br label %for.cond18
}

define internal ptr @xalloc(ptr %0) {
entry:
  %tobool.not = icmp eq ptr %0, null
  call void @llvm.assume(i1 %tobool.not)
  ret ptr null
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
