target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.mbuif_state = type { i8, %struct.__mbstate_t, i32 }
%struct.__mbstate_t = type { i32, %union.anon.0 }
%union.anon.0 = type { i32 }

define ptr @mbschr(i8 %conv, ptr %state) {
entry:
  %conv1 = zext i8 %conv to i32
  %cmp2 = icmp sge i32 %conv1, 1
  br i1 %cmp2, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %in_shift = getelementptr %struct.mbuif_state, ptr %state, i32 0, i32 0
  br label %common.ret
}
