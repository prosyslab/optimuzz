target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

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
  %call11 = call i1 @tail_bytes(ptr null, i1 false)
  br label %return

return:                                           ; preds = %if.else, %entry
  ret i1 false
}

define internal i1 @tail_bytes(ptr %end_pos, i1 %cmp39) {
entry:
  %0 = load i64, ptr %end_pos, align 8
  %cond = select i1 %cmp39, i64 0, i64 512
  %cmp41 = icmp sle i64 %0, %cond
  br i1 %cmp41, label %if.then42, label %common.ret

common.ret:                                       ; preds = %if.then42, %entry
  ret i1 false

if.then42:                                        ; preds = %entry
  %1 = load ptr, ptr %end_pos, align 8
  br label %common.ret
}
