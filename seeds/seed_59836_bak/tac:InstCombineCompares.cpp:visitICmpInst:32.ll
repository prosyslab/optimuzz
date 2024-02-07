target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_search_internal() {
entry:
  ret i32 0

if.then360:                                       ; No predecessors!
  %call383 = call i32 @prune_impossible_nodes()
  br label %for.cond416

for.cond416:                                      ; preds = %for.cond416, %if.then360
  br label %for.cond416
}

define internal i32 @prune_impossible_nodes() {
entry:
  br label %return

if.end21:                                         ; No predecessors!
  %call241 = call i32 @sift_states_backward(ptr null, ptr null, i32 0, i1 false)
  br label %return

return:                                           ; preds = %if.end21, %entry
  ret i32 0
}

define internal i32 @sift_states_backward(ptr %sctx.addr, ptr %null_cnt, i32 %0, i1 %cmp15) {
entry:
  %cond = select i1 %cmp15, i32 %0, i32 0
  store i32 %cond, ptr %null_cnt, align 4
  %1 = load i32, ptr %null_cnt, align 4
  %cmp20 = icmp sgt i32 %1, 0
  br i1 %cmp20, label %if.then22, label %common.ret

common.ret:                                       ; preds = %if.then22, %entry
  ret i32 0

if.then22:                                        ; preds = %entry
  %2 = load ptr, ptr %sctx.addr, align 8
  br label %common.ret
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
