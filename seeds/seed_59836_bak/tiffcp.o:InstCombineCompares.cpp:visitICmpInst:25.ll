target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@compression = external global i16

define i32 @main() {
entry:
  br label %sw.bb50

sw.bb50:                                          ; preds = %sw.bb50, %entry
  br label %sw.bb50

if.end151:                                        ; No predecessors!
  br label %for.cond152

for.cond152:                                      ; preds = %for.cond152, %if.end151
  %call1531 = call i32 @tiffcp(ptr null)
  br label %for.cond152
}

define internal i32 @tiffcp(ptr %out.addr) {
entry:
  %0 = load i16, ptr @compression, align 2
  %conv83 = zext i16 %0 to i32
  %cmp84 = icmp eq i32 %conv83, 34676
  br i1 %cmp84, label %if.then90, label %lor.lhs.false86

lor.lhs.false86:                                  ; preds = %entry
  %1 = load i16, ptr @compression, align 2
  %conv87 = zext i16 %1 to i32
  %cmp88 = icmp eq i32 %conv87, 34677
  br i1 %cmp88, label %if.then90, label %common.ret

common.ret:                                       ; preds = %if.then90, %lor.lhs.false86
  ret i32 0

if.then90:                                        ; preds = %lor.lhs.false86, %entry
  %2 = load ptr, ptr %out.addr, align 8
  br label %common.ret
}
