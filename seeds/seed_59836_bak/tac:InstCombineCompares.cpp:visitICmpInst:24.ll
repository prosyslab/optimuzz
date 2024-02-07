target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_search_internal() {
entry:
  br label %return

if.end181:                                        ; No predecessors!
  switch i32 0, label %return [
    i32 8, label %sw.epilog
    i32 7, label %while.cond
    i32 0, label %while.cond193
    i32 4, label %return
    i32 1, label %return
  ]

while.cond:                                       ; preds = %while.cond, %if.end181
  br label %while.cond

while.cond193:                                    ; preds = %while.cond193, %if.end181
  br label %while.cond193

sw.epilog:                                        ; preds = %if.end181
  %call3121 = call i32 @re_string_reconstruct(i32 0)
  br label %return

return:                                           ; preds = %sw.epilog, %if.end181, %if.end181, %if.end181, %entry
  ret i32 0
}

define internal i32 @re_string_reconstruct(i32 %0) {
entry:
  br label %while.cond240

while.cond240:                                    ; preds = %while.cond240, %entry
  %dec241 = add nsw i32 %0, 1
  %cmp242 = icmp sge i32 %dec241, 0
  br i1 %cmp242, label %while.cond240, label %while.end251

while.end251:                                     ; preds = %while.cond240
  ret i32 0
}

define internal i64 @re_search_stub() {
entry:
  br label %return

land.rhs:                                         ; No predecessors!
  %call96 = call i32 @re_search_internal()
  br label %return

return:                                           ; preds = %land.rhs, %entry
  ret i64 0
}

define i64 @rpl_re_search() {
entry:
  %call = call i64 @re_search_stub()
  ret i64 0
}
