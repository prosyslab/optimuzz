target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.then173:                                       ; No predecessors!
  call void @print_files()
  unreachable
}

define internal void @print_files() {
entry:
  call void @init_funcs(ptr null)
  ret void
}

define internal void @init_funcs(ptr %print_func13) {
entry:
  br label %if.end14

if.else11:                                        ; No predecessors!
  store ptr @read_line, ptr %print_func13, align 8
  br label %if.end14

if.end14:                                         ; preds = %if.end14, %if.else11, %entry
  br label %if.end14
}

define internal i1 @read_line() {
entry:
  %call261 = call i32 @char_to_clump(ptr null, i8 0)
  ret i1 false
}

define internal i32 @char_to_clump(ptr %uc, i8 %0) {
entry:
  %conv36 = zext i8 %0 to i32
  %cmp37 = icmp slt i32 %conv36, 128
  br i1 %cmp37, label %if.then39, label %common.ret

common.ret:                                       ; preds = %if.then39, %entry
  ret i32 0

if.then39:                                        ; preds = %entry
  store i32 0, ptr %uc, align 4
  br label %common.ret
}
