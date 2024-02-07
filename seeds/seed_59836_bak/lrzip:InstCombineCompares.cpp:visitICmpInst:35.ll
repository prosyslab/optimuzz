target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @rzip_fd() {
entry:
  br label %retry

retry:                                            ; preds = %if.then448, %retry, %entry
  br label %retry

if.then448:                                       ; No predecessors!
  call void @rzip_chunk()
  br label %retry
}

define internal void @rzip_chunk() {
entry:
  call void @hash_search()
  ret void
}

define internal void @hash_search() {
entry:
  call void @insert_hash()
  ret void
}

define internal void @insert_hash() {
entry:
  %call51 = call i1 @lesser_bitness(i64 0)
  ret void
}

define internal i1 @lesser_bitness(i64 %0) {
entry:
  %call = call i32 @ffsll(i64 %0)
  %call2 = call i32 @ffsll(i64 %0)
  %cmp = icmp slt i32 %call, %call2
  ret i1 %cmp
}

declare i32 @ffsll(i64)

; uselistorder directives
uselistorder ptr @ffsll, { 1, 0 }
