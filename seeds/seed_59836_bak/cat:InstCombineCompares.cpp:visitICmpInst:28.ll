target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb5

sw.bb5:                                           ; preds = %sw.bb5, %entry
  br label %sw.bb5

if.end140:                                        ; No predecessors!
  %call1481 = call i1 @cat(ptr null, ptr null, i64 0)
  br label %contin

contin:                                           ; preds = %contin, %if.end140
  br label %contin
}

define internal i1 @cat(ptr %outbuf.addr, ptr %0, i64 %1) {
entry:
  %add.ptr6 = getelementptr i8, ptr %0, i64 %1
  %cmp = icmp ule ptr %add.ptr6, null
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i1 false

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %outbuf.addr, align 8
  br label %common.ret
}
