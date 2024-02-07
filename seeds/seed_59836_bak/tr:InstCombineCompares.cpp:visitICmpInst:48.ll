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
  %call11 = call i1 @build_spec_list(ptr null, i64 0)
  ret i1 false
}

define internal i1 @build_spec_list(ptr %closing_delim_idx, i64 %0) {
entry:
  %add12 = add i64 %0, 1
  store i64 %add12, ptr %closing_delim_idx, align 8
  %cmp14 = icmp eq i64 %add12, 0
  br i1 %cmp14, label %common.ret, label %if.end23

common.ret:                                       ; preds = %if.end23, %entry
  ret i1 false

if.end23:                                         ; preds = %entry
  %1 = load i64, ptr %closing_delim_idx, align 8
  br label %common.ret
}
