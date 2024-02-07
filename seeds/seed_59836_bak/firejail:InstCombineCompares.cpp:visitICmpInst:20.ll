target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @rand()

define void @fs_hostname() {
entry:
  unreachable

if.then:                                          ; No predecessors!
  %call1 = call ptr @random_hostname(i32 0)
  unreachable
}

define internal ptr @random_hostname(i32 %call26) {
entry:
  %rem27 = srem i32 %call26, 2
  %tobool28 = icmp ne i32 %rem27, 0
  br i1 %tobool28, label %if.then29, label %if.end44

if.then29:                                        ; preds = %entry
  %call30 = call i32 @rand()
  br label %if.end44

if.end44:                                         ; preds = %if.then29, %entry
  ret ptr null
}
