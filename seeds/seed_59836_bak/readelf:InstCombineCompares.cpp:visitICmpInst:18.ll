target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @gettext()

define i32 @setup_archive() {
entry:
  br label %return

if.end13:                                         ; No predecessors!
  %call171 = call i32 @process_archive_index_and_symbols(i64 0, i1 false)
  br label %return

return:                                           ; preds = %if.end13, %entry
  ret i32 0
}

define internal i32 @process_archive_index_and_symbols(i64 %0, i1 %cmp125) {
entry:
  %cmp123 = icmp ne i64 %0, 0
  %or.cond = select i1 %cmp123, i1 %cmp125, i1 false
  br i1 %or.cond, label %if.then127, label %common.ret

common.ret:                                       ; preds = %if.then127, %entry
  ret i32 0

if.then127:                                       ; preds = %entry
  %call128 = call ptr @gettext()
  br label %common.ret
}
