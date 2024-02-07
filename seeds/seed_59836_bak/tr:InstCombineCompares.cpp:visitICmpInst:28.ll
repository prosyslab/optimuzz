target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end55:                                         ; No predecessors!
  %call58 = call i1 @parse_str()
  unreachable
}

define internal i1 @parse_str() {
entry:
  %call1 = call i1 @build_spec_list()
  ret i1 false
}

define internal i1 @build_spec_list() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %if.then34, %entry
  ret i1 false

if.then34:                                        ; No predecessors!
  %call561 = call i32 @find_bracketed_repeat(ptr null, ptr null, i64 0)
  br label %for.cond
}

define internal i32 @find_bracketed_repeat(ptr %digit_str, ptr %0, i64 %1) {
entry:
  %add.ptr = getelementptr i8, ptr %0, i64 %1
  %cmp30 = icmp ne ptr %add.ptr, null
  br i1 %cmp30, label %if.then32, label %common.ret

common.ret:                                       ; preds = %if.then32, %entry
  ret i32 0

if.then32:                                        ; preds = %entry
  %2 = load ptr, ptr %digit_str, align 8
  br label %common.ret
}
