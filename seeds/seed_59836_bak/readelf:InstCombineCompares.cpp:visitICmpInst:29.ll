target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.elf_internal_shdr = type { i32, i32, i64, i64, i64, i64, i32, i32, i64, i64, ptr, ptr }

define i1 @load_debug_section(ptr %filedata, ptr %0, i64 %idx.ext) {
entry:
  %add.ptr = getelementptr inbounds %struct.elf_internal_shdr, ptr %0, i64 %idx.ext
  %cmp15 = icmp ne ptr %add.ptr, null
  br i1 %cmp15, label %land.lhs.true16, label %common.ret

common.ret:                                       ; preds = %land.lhs.true16, %entry
  ret i1 false

land.lhs.true16:                                  ; preds = %entry
  %1 = load ptr, ptr %filedata, align 8
  br label %common.ret
}
