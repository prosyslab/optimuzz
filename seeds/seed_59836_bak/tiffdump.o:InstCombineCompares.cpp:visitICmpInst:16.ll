target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb8

sw.bb8:                                           ; preds = %sw.bb8, %entry
  br label %sw.bb8

if.then22:                                        ; No predecessors!
  call void @dump(i32 0)
  ret i32 0
}

define internal void @dump(i32 %0) {
entry:
  %cmp113 = icmp ugt i32 %0, 0
  br i1 %cmp113, label %if.then115, label %if.end117

if.then115:                                       ; preds = %entry
  %call116 = call i32 @putchar()
  br label %if.end117

if.end117:                                        ; preds = %if.then115, %entry
  ret void
}

declare i32 @putchar()
