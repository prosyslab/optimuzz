target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @archive_write_set_format_mtree_default(ptr %format_close) {
entry:
  br label %return

if.end9:                                          ; No predecessors!
  store ptr @archive_write_mtree_close, ptr %format_close, align 8
  br label %return

return:                                           ; preds = %if.end9, %entry
  ret i32 0
}

define internal i32 @archive_write_mtree_close() {
entry:
  %call = call i32 @write_mtree_entry_tree()
  ret i32 0
}

define internal i32 @write_mtree_entry_tree() {
entry:
  br label %return

for.end:                                          ; No predecessors!
  %call12 = call i32 @write_mtree_entry()
  br label %return

return:                                           ; preds = %for.end, %entry
  ret i32 0
}

define internal i32 @write_mtree_entry() {
entry:
  call void @mtree_quote(ptr null, i8 0)
  ret i32 0
}

define internal void @mtree_quote(ptr %c, i8 %0) {
entry:
  %conv15 = zext i8 %0 to i32
  %rem16 = srem i32 %conv15, 8
  %conv18 = trunc i32 %rem16 to i8
  store i8 %conv18, ptr %c, align 1
  ret void
}

define i32 @archive_write_set_format_mtree_classic() {
entry:
  %call1 = call i32 @archive_write_set_format_mtree_default(ptr null)
  ret i32 0
}
