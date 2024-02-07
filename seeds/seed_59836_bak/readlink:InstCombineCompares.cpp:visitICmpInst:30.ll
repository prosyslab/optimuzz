target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.scratch_buffer = type { ptr, i64, %union.anon }
%union.anon = type { %struct.max_align_t, [992 x i8] }
%struct.max_align_t = type { i64, x86_fp80 }

define i1 @gl_scratch_buffer_grow() {
entry:
  call void @scratch_buffer_free.65(ptr null, ptr null)
  ret i1 false
}

define internal void @scratch_buffer_free.65(ptr %buffer.addr, ptr %0) {
entry:
  %1 = load ptr, ptr %buffer.addr, align 16
  %__space = getelementptr %struct.scratch_buffer, ptr %0, i32 0, i32 2
  %cmp = icmp ne ptr %1, %__space
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %buffer.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
