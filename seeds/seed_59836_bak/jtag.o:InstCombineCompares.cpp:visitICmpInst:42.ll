target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %return

if.then55:                                        ; No predecessors!
  call void @jtag_readline_loop()
  br label %return

return:                                           ; preds = %if.then55, %entry
  ret i32 0
}

define internal void @jtag_readline_loop() {
entry:
  %call1 = call i32 @jtag_readline_multiple_commands_support(ptr null)
  ret void
}

define internal i32 @jtag_readline_multiple_commands_support(ptr %line.addr) {
entry:
  %call = call i64 @strlen(ptr %line.addr)
  %cmp = icmp ugt i64 %call, 0
  br i1 %cmp, label %common.ret, label %if.then

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  store i32 0, ptr %line.addr, align 4
  br label %common.ret
}

declare i64 @strlen(ptr)
