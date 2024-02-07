target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_search_internal(i8 %bf.load52) {
entry:
  %bf.lshr53 = lshr i8 %bf.load52, 7
  %bf.cast54 = zext i8 %bf.lshr53 to i32
  %tobool55 = icmp ne i32 %bf.cast54, 0
  br i1 %tobool55, label %if.end64, label %common.ret

common.ret:                                       ; preds = %if.end64, %entry
  ret i32 0

if.end64:                                         ; preds = %entry
  %cmp65 = icmp ne i64 0, 0
  br label %common.ret
}

define internal i64 @re_search_stub() {
entry:
  br label %return

land.rhs:                                         ; No predecessors!
  %call961 = call i32 @re_search_internal(i8 0)
  br label %return

return:                                           ; preds = %land.rhs, %entry
  ret i64 0
}

define i64 @rpl_re_search() {
entry:
  %call = call i64 @re_search_stub()
  ret i64 0
}
