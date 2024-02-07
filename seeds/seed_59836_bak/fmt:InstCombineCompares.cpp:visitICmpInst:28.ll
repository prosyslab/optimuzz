target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Word = type { ptr, i32, i32, i8, i32, i64, ptr }

define i32 @main() {
entry:
  unreachable

if.then34:                                        ; No predecessors!
  %call53 = call i1 @fmt()
  unreachable
}

define internal i1 @fmt() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  call void @fmt_paragraph(ptr null, ptr null)
  br label %while.cond
}

define internal void @fmt_paragraph(ptr %word_limit, ptr %0) {
entry:
  %add.ptr = getelementptr %struct.Word, ptr %0, i64 -1
  %cmp.not = icmp ult ptr %add.ptr, %word_limit
  br i1 %cmp.not, label %common.ret, label %for.body

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  store i64 0, ptr %word_limit, align 8
  br label %common.ret
}
