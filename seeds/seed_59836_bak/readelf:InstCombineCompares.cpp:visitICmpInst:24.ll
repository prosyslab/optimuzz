target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_tr_flush_block() {
entry:
  call void @build_tree()
  ret void
}

define internal void @build_tree() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

do.end:                                           ; No predecessors!
  call void @gen_bitlen(ptr null, i32 0, ptr null)
  ret void
}

define internal void @gen_bitlen(ptr %tree, i32 %conv, ptr %bits) {
entry:
  %add23 = add nsw i32 %conv, 1
  store i32 %add23, ptr %bits, align 4
  %0 = load i32, ptr %bits, align 4
  %cmp24 = icmp sgt i32 %0, 0
  br i1 %cmp24, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %tree, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
