target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @setup_archive() {
entry:
  br label %return

if.end13:                                         ; No predecessors!
  %call171 = call i32 @process_archive_index_and_symbols(i64 0)
  br label %return

return:                                           ; preds = %if.end13, %entry
  ret i32 0
}

define internal i32 @process_archive_index_and_symbols(i64 %conv) {
entry:
  %cmp18 = icmp ule i64 %conv, 0
  call void @llvm.assume(i1 %cmp18)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
