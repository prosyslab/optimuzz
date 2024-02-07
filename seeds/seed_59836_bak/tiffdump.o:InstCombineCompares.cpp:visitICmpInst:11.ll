target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb8

sw.bb8:                                           ; preds = %sw.bb8, %entry
  br label %sw.bb8

if.then22:                                        ; No predecessors!
  call void @dump()
  ret i32 0
}

define internal void @dump() {
entry:
  br label %for.cond81

for.cond81:                                       ; preds = %cond.true, %for.cond81, %entry
  br label %for.cond81

cond.true:                                        ; No predecessors!
  %call1181 = call i64 @ReadDirectory(ptr null, i64 0)
  br label %for.cond81
}

define internal i64 @ReadDirectory(ptr %type, i64 %conv102) {
entry:
  %cmp103 = icmp uge i64 %conv102, 1
  br i1 %cmp103, label %if.then105, label %common.ret

common.ret:                                       ; preds = %if.then105, %entry
  ret i64 0

if.then105:                                       ; preds = %entry
  store i16 0, ptr %type, align 2
  br label %common.ret
}
