target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.epilog, %entry
  br label %sw.epilog

if.then140:                                       ; No predecessors!
  call void @system_join()
  unreachable
}

define internal void @system_join() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

if.then165:                                       ; No predecessors!
  br label %while.cond183

while.cond183:                                    ; preds = %while.cond183, %if.then165
  %call184 = call i1 @get_line()
  br label %while.cond183
}

define internal i1 @get_line() {
entry:
  call void @xfields(ptr null)
  ret i1 false
}

define internal void @xfields(ptr %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %incdec.ptr = getelementptr i8, ptr %0, i64 1
  %cmp14 = icmp eq ptr %incdec.ptr, null
  br i1 %cmp14, label %if.then15, label %while.cond

if.then15:                                        ; preds = %while.cond
  ret void
}
