target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_regexec() {
entry:
  br label %return

if.then3:                                         ; No predecessors!
  %call91 = call i32 @re_search_internal(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.then3, %entry
  ret i32 0
}

define internal i32 @re_search_internal(ptr %preg.addr, i8 %bf.load52) {
entry:
  %bf.lshr53 = lshr i8 %bf.load52, 7
  %bf.cast54 = zext i8 %bf.lshr53 to i32
  %tobool55 = icmp ne i32 %bf.cast54, 0
  br i1 %tobool55, label %common.ret, label %if.then56

common.ret:                                       ; preds = %if.then56, %entry
  ret i32 0

if.then56:                                        ; preds = %entry
  %0 = load i64, ptr %preg.addr, align 8
  br label %common.ret
}
