target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @set_file_metadata() {
entry:
  %call41 = call i32 @write_xattr_metadata(ptr null)
  ret i32 0
}

define internal i32 @write_xattr_metadata(ptr %retval1) {
entry:
  %retval11 = alloca i32, align 4
  %0 = load i32, ptr %retval11, align 4
  %cmp = icmp slt i32 %0, 0
  %1 = load i32, ptr %retval11, align 4
  %cond = select i1 %cmp, i32 %1, i32 0
  store i32 %cond, ptr %retval1, align 4
  %2 = load i32, ptr %retval1, align 4
  %tobool7 = icmp ne i32 %2, 0
  br i1 %tobool7, label %if.then8, label %common.ret

common.ret:                                       ; preds = %if.then8, %entry
  ret i32 0

if.then8:                                         ; preds = %entry
  %3 = load i8, ptr %retval1, align 1
  br label %common.ret
}
