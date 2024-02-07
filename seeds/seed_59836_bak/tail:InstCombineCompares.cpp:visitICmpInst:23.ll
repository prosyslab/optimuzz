target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then86:                                        ; No predecessors!
  br label %for.cond88

for.cond88:                                       ; preds = %for.cond88, %if.then86
  %call93 = call i1 @tail_file()
  br label %for.cond88
}

define internal i1 @tail_file() {
entry:
  br label %if.end102

if.then22:                                        ; No predecessors!
  %call26 = call i1 @tail()
  br label %if.end102

if.end102:                                        ; preds = %if.then22, %entry
  ret i1 false
}

define internal i1 @tail() {
entry:
  br label %return

if.else:                                          ; No predecessors!
  %call11 = call i1 @tail_bytes(i64 0, ptr null)
  br label %return

return:                                           ; preds = %if.else, %entry
  ret i1 false
}

define internal i1 @tail_bytes(i64 %0, ptr %stats) {
entry:
  %cmp = icmp ule i64 %0, 9223372036854775807
  br i1 %cmp, label %land.lhs.true7, label %common.ret

common.ret:                                       ; preds = %land.lhs.true7, %entry
  ret i1 false

land.lhs.true7:                                   ; preds = %entry
  %st_mode = getelementptr %struct.stat, ptr %stats, i32 0, i32 3
  br label %common.ret
}
