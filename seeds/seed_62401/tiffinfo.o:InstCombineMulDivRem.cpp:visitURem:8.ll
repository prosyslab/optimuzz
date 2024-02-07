target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @TIFFReadContigTileData() {
entry:
  ret void

for.cond18:                                       ; preds = %if.then30, %for.cond18
  br label %for.cond18

if.then30:                                        ; No predecessors!
  call void @ShowTile(i32 0)
  br label %for.cond18
}

declare i32 @putchar()

define internal void @ShowTile(i32 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %if.then14, %for.cond, %entry
  %add = add i32 %0, 1
  %rem = urem i32 %add, 24
  %cmp12 = icmp eq i32 %rem, 0
  br i1 %cmp12, label %if.then14, label %for.cond

if.then14:                                        ; preds = %for.cond
  %call15 = call i32 @putchar()
  br label %for.cond
}
