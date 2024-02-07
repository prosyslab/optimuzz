target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ImportID3v2() {
entry:
  br label %return

if.end33:                                         ; No predecessors!
  %call1 = call i32 @ImportID3v2_syncsafe(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.end33, %entry
  ret i32 0
}

define internal i32 @ImportID3v2_syncsafe(ptr %id3_header, i8 %0) {
entry:
  %conv21 = zext i8 %0 to i32
  %and22 = and i32 %conv21, 128
  %tobool23 = icmp ne i32 %and22, 0
  br i1 %tobool23, label %if.then24, label %common.ret

common.ret:                                       ; preds = %if.then24, %entry
  ret i32 0

if.then24:                                        ; preds = %entry
  %1 = load ptr, ptr %id3_header, align 8
  br label %common.ret
}
