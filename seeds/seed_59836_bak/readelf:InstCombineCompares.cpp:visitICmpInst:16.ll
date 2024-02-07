target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @gettext()

define i32 @setup_archive() {
entry:
  br label %return

if.end13:                                         ; No predecessors!
  %call171 = call i32 @process_archive_index_and_symbols(i64 0)
  br label %return

return:                                           ; preds = %if.end13, %entry
  ret i32 0
}

define internal i32 @process_archive_index_and_symbols(i64 %0) {
entry:
  %cmp97 = icmp ult i64 %0, 1
  br i1 %cmp97, label %if.then99, label %common.ret

common.ret:                                       ; preds = %if.then99, %entry
  ret i32 0

if.then99:                                        ; preds = %entry
  %call100 = call ptr @gettext()
  br label %common.ret
}
