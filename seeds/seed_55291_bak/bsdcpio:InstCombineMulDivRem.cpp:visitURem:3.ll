target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.1940 = external dso_local constant [31 x i8]

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

declare ptr @archive_strncat(ptr)

define i32 @archive_write_set_format_mtree() {
entry:
  %call = call i32 @archive_write_set_format_mtree_default()
  ret i32 0
}

define internal i32 @archive_write_set_format_mtree_default() {
do.end20:
  store ptr @archive_write_mtree_close, ptr undef, align 8
  ret i32 0
}

define internal i32 @archive_write_mtree_close() {
if.then:
  %call = call i32 @write_mtree_entry_tree()
  ret i32 0
}

define internal i32 @write_mtree_entry_tree() {
if.then11:
  %call12 = call i32 @write_mtree_entry()
  ret i32 0
}

define internal i32 @write_mtree_entry() {
if.then30:
  call void @mtree_quote(ptr undef, i8 undef, ptr undef)
  ret i32 0
}

define internal void @mtree_quote(ptr %c, i8 %0, ptr %arrayidx19) {
entry:
  %c1 = alloca i8, align 1
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %if.end

if.end:                                           ; preds = %for.body
  br label %if.end5

if.end5:                                          ; preds = %if.end
  %1 = load i8, ptr %c, align 1
  %conv15 = zext i8 %0 to i32
  %rem16 = srem i32 %conv15, 8
  %add17 = add nsw i32 8, 0
  %conv18 = trunc i32 %rem16 to i8
  %arrayidx192 = getelementptr inbounds [4 x i8], ptr undef, i64 0, i64 3
  store i8 %conv18, ptr %c, align 1
  ret void
}

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
