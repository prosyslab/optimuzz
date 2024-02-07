target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  br label %do.body

cond.true:                                        ; No predecessors!
  br label %for.cond101

for.cond101:                                      ; preds = %for.cond101, %cond.true
  %call108 = call i1 @head_file()
  br label %for.cond101
}

define internal i1 @head_file() {
entry:
  %call13 = call i1 @head()
  ret i1 false
}

define internal i1 @head() {
entry:
  br label %return

if.else:                                          ; No predecessors!
  %call20 = call i1 @elide_tail_bytes_file()
  br label %return

return:                                           ; preds = %if.else, %entry
  ret i1 false
}

define internal i1 @elide_tail_bytes_file() {
entry:
  %call1 = call i1 @elide_tail_bytes_pipe(ptr null, i64 0)
  ret i1 false
}

define internal i1 @elide_tail_bytes_pipe(ptr %i_next, i64 %0) {
entry:
  br label %for.cond60

for.cond60:                                       ; preds = %for.cond60, %entry
  %add107 = add i64 %0, 1
  %rem108 = urem i64 %add107, %0
  store i64 %rem108, ptr %i_next, align 8
  br label %for.cond60
}
