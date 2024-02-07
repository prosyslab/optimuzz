target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.widget = type { i32, %union._widget_data_union, i32, i32, i32, i32, i32, i32, i32, %struct.anon, ptr, ptr, ptr, i32 }
%union._widget_data_union = type { %struct.widget_numentry }
%struct.widget_numentry = type { i32, i32, i32, ptr, ptr, i32 }
%struct.anon = type { i32, i32, i32, i32, i32 }

define i32 @widget_handle_key(ptr %widgets, ptr %0, i64 %idxprom) {
entry:
  %arrayidx = getelementptr inbounds %struct.widget, ptr %0, i64 %idxprom
  %tobool = icmp ne ptr %arrayidx, null
  br i1 %tobool, label %common.ret, label %if.then

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  store i32 0, ptr %widgets, align 4
  br label %common.ret
}
