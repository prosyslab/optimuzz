target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @backupfile_internal() {
entry:
  br label %return

if.else:                                          ; No predecessors!
  %call1512 = call i32 @numbered_backup(ptr null, i32 0, i1 false)
  switch i32 0, label %return [
    i32 0, label %return
    i32 2, label %return
    i32 1, label %return
    i32 3, label %return
  ]

return:                                           ; preds = %if.else, %if.else, %if.else, %if.else, %if.else, %entry
  ret ptr null
}

define internal i32 @numbered_backup(ptr %p, i32 %conv49, i1 %cmp50) {
entry:
  br label %for.cond42

for.cond42:                                       ; preds = %for.cond42, %entry
  %conv51 = zext i1 %cmp50 to i32
  %and = and i32 %conv49, %conv51
  %tobool54 = icmp ne i32 %and, 0
  %frombool55 = zext i1 %tobool54 to i8
  store i8 %frombool55, ptr %p, align 1
  br label %for.cond42
}
