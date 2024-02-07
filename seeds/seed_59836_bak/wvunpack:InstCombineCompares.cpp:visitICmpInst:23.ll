target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

if.then696:                                       ; No predecessors!
  %call740 = call i32 @unpack_file()
  ret i32 0
}

define internal i32 @unpack_file() {
entry:
  br label %return

if.then248:                                       ; No predecessors!
  call void @dump_summary(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.then248, %entry
  ret i32 0
}

define internal void @dump_summary(ptr %header_data, i8 %0) {
entry:
  %conv283 = zext i8 %0 to i32
  %cmp284 = icmp sle i32 %conv283, 127
  br i1 %cmp284, label %if.then286, label %if.end291

if.then286:                                       ; preds = %entry
  %1 = load ptr, ptr %header_data, align 8
  br label %if.end291

if.end291:                                        ; preds = %if.then286, %entry
  ret void
}
