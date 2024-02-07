target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@anonymize_ident_line.which_buffer = external dso_local global i32

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

define i32 @cmd_fast_export() {
while.body:
  call void @handle_commit()
  ret i32 0
}

define internal void @handle_commit() {
if.then49:
  call void @anonymize_ident_line(ptr undef, i32 undef)
  ret void
}

declare void @strbuf_setlen.3207()

define internal void @anonymize_ident_line(ptr %anonymize_ident_line.which_buffer, i32 %0) {
entry:
  %1 = load i32, ptr %anonymize_ident_line.which_buffer, align 4
  %conv = zext i32 %0 to i64
  %rem = urem i64 %conv, 2
  %conv1 = trunc i64 %rem to i32
  store i32 %conv1, ptr %anonymize_ident_line.which_buffer, align 4
  ret void
}

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
