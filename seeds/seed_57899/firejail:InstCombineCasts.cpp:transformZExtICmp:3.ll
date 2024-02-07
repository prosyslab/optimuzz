target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @dbus_check_name() {
entry:
  %call1 = call i32 @check_bus_or_interface_name(ptr null, i8 0)
  ret i32 0
}

define internal i32 @check_bus_or_interface_name(ptr %p, i8 %0) {
entry:
  %cmp49 = icmp eq i8 %0, 0
  %conv50 = zext i1 %cmp49 to i32
  store i32 %conv50, ptr %p, align 4
  ret i32 0
}
