target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@digest_length = external dso_local global i64

declare ptr @gettext()

declare ptr @setlocale()

define i32 @main(ptr %digest_length, i64 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.cond
  switch i32 0, label %sw.default [
    i32 0, label %sw.bb
  ]

sw.bb:                                            ; preds = %while.body
  %1 = load i64, ptr %digest_length, align 8
  %rem = urem i64 %0, 8
  %cmp9 = icmp ne i64 %rem, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %sw.bb
  unreachable

if.end:                                           ; preds = %sw.bb
  ret i32 0

sw.default:                                       ; preds = %while.body
  unreachable
}

declare ptr @ptr_align()

declare ptr @bindtextdomain()

declare ptr @textdomain()

declare i32 @atexit()

declare i32 @setvbuf()

declare i32 @getopt_long()

declare void @set_program_name()

declare i64 @xdectoumax()
