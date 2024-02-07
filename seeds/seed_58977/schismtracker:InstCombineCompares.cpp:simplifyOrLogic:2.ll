target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @widget_handle_key(ptr %widget, i8 %bf.load96) {
entry:
  %bf.clear97 = and i8 %bf.load96, 1
  %bf.set = or i8 %bf.clear97, 1
  store i8 %bf.set, ptr %widget, align 8
  ret i32 0
}
