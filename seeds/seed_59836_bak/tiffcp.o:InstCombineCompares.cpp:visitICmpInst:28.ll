target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb45

sw.bb45:                                          ; preds = %sw.bb45, %entry
  br label %sw.bb45

if.end151:                                        ; No predecessors!
  br label %for.cond152

for.cond152:                                      ; preds = %for.cond152, %if.end151
  %call1611 = call i32 @nextSrcImage(ptr null, ptr null)
  br label %for.cond152
}

define internal i32 @nextSrcImage(ptr %imageSpec.addr, ptr %0) {
entry:
  %add.ptr = getelementptr i8, ptr %0, i64 1
  %cmp4 = icmp eq ptr %add.ptr, null
  br i1 %cmp4, label %if.then6, label %if.end

if.then6:                                         ; preds = %entry
  %1 = load ptr, ptr %imageSpec.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then6, %entry
  ret i32 0
}
