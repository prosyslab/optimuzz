target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printTIF() {
entry:
  ret void

if.then12:                                        ; No predecessors!
  call void @emitFont(ptr null)
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.then12
  br label %for.cond
}

define internal void @emitFont(ptr %emitFont.fontPrologue) {
entry:
  %cmp = icmp ne ptr %emitFont.fontPrologue, null
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %0 = load ptr, ptr %emitFont.fontPrologue, align 8
  br label %common.ret
}
