target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@delims = external global ptr

define i32 @main() {
entry:
  unreachable

if.then:                                          ; No predecessors!
  %cond23 = select i1 false, ptr @paste_serial, ptr null
  unreachable
}

define internal i1 @paste_serial() {
entry:
  %delimptr = alloca ptr, align 8
  %0 = load ptr, ptr %delimptr, align 8
  %incdec.ptr = getelementptr i8, ptr %0, i32 1
  %cmp22 = icmp eq ptr %incdec.ptr, null
  br i1 %cmp22, label %if.then24, label %if.end25

if.then24:                                        ; preds = %entry
  %1 = load ptr, ptr @delims, align 8
  br label %if.end25

if.end25:                                         ; preds = %if.then24, %entry
  ret i1 false
}
