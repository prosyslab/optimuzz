target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb3

sw.bb3:                                           ; preds = %sw.bb3, %entry
  br label %sw.bb3

if.end16:                                         ; No predecessors!
  br label %while.cond17

while.cond17:                                     ; preds = %while.cond17, %if.end16
  %call18 = call i32 @tiffcmp()
  br label %while.cond17
}

define internal i32 @tiffcmp() {
entry:
  unreachable

if.end162:                                        ; No predecessors!
  %call163 = call i32 @ContigCompare()
  ret i32 0
}

define internal i32 @ContigCompare() {
entry:
  ret i32 0

for.cond5:                                        ; preds = %for.cond5
  call void @PrintIntDiff(ptr null)
  br label %for.cond5
}

define internal void @PrintIntDiff(ptr %sample.addr) {
entry:
  %0 = load i32, ptr %sample.addr, align 4
  %cmp = icmp slt i32 %0, 0
  %spec.store.select = select i1 %cmp, i32 0, i32 %0
  store i32 %spec.store.select, ptr %sample.addr, align 4
  ret void
}
