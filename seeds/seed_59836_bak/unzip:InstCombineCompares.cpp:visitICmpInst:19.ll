target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @extract_or_test_files() {
entry:
  ret i32 0

while.cond44:                                     ; No predecessors!
  %call2091 = call i32 @extract_or_test_entrylist(ptr null)
  br label %while.cond237

while.cond237:                                    ; preds = %while.cond237, %while.cond44
  br label %while.cond237
}

define internal i32 @extract_or_test_entrylist(ptr %error_in_archive.addr) {
entry:
  %0 = load i32, ptr %error_in_archive.addr, align 4
  %cmp169 = icmp slt i32 %0, 0
  %spec.store.select = select i1 %cmp169, i32 0, i32 %0
  store i32 %spec.store.select, ptr %error_in_archive.addr, align 4
  ret i32 0
}
