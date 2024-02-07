target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.117.3100 = external constant [4 x i8]
@__const.clean_supplementary_groups.allowed = private constant [4 x ptr] [ptr null, ptr @.str.117.3100, ptr null, ptr null]

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

define void @drop_privs() {
entry:
  unreachable

if.then19:                                        ; No predecessors!
  call void @clean_supplementary_groups(i64 0)
  unreachable
}

define internal void @clean_supplementary_groups(i64 %idxprom) {
entry:
  %allowed = alloca [4 x ptr], align 16
  call void @llvm.memcpy.p0.p0.i64(ptr %allowed, ptr @__const.clean_supplementary_groups.allowed, i64 0, i1 false)
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %arrayidx = getelementptr [4 x ptr], ptr %allowed, i64 0, i64 %idxprom
  %0 = load ptr, ptr %arrayidx, align 8
  %tobool19 = icmp ne ptr %0, null
  br i1 %tobool19, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret void
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
