target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_search_internal() {
entry:
  br label %return

land.rhs444:                                      ; No predecessors!
  %call449 = call i32 @set_regs()
  br label %return

return:                                           ; preds = %land.rhs444, %entry
  ret i32 0
}

define internal i32 @set_regs() {
entry:
  br label %return

if.end46:                                         ; No predecessors!
  %call48 = call i64 @proceed_next_node()
  br label %return

return:                                           ; preds = %if.end46, %entry
  ret i32 0
}

define internal i64 @proceed_next_node() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then46:                                        ; No predecessors!
  %call1291 = call i1 @check_node_accept(ptr null, i8 0)
  ret i64 0
}

define internal i1 @check_node_accept(ptr %ch, i8 %0) {
entry:
  %conv9 = zext i8 %0 to i32
  %cmp10 = icmp sge i32 %conv9, 128
  br i1 %cmp10, label %if.then12, label %common.ret

common.ret:                                       ; preds = %if.then12, %entry
  ret i1 false

if.then12:                                        ; preds = %entry
  store i1 false, ptr %ch, align 1
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
