target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @irealloc(i64 %0) {
entry:
  %tobool = icmp ne i64 %0, 0
  %conv = zext i1 %tobool to i64
  %call = call ptr @realloc(i64 %conv)
  ret ptr null
}

declare ptr @realloc(i64)
