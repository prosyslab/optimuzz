target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.termios = type { i32, i32, i32, i32, i8, [32 x i8], i32, i32 }

declare ptr @gettext()

define i32 @main() {
entry:
  unreachable

if.then49:                                        ; No predecessors!
  call void @apply_settings()
  unreachable
}

define internal void @apply_settings() {
entry:
  %call245 = call i64 @integer_arg()
  %conv246 = trunc i64 %call245 to i8
  %c_line = getelementptr %struct.termios, ptr undef, i32 0, i32 4
  store i8 %conv246, ptr %c_line, align 4
  %0 = load i8, ptr undef, align 4
  %conv248 = zext i8 %0 to i64
  %cmp249 = icmp ne i64 %conv248, %call245
  br i1 %cmp249, label %if.then251, label %if.end256

if.then251:                                       ; preds = %entry
  %call252 = call ptr @gettext()
  br label %if.end256

if.end256:                                        ; preds = %if.then251, %entry
  ret void
}

declare i64 @integer_arg()
