target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.51 = private constant [4 x i8] c".?!\00"

define i32 @main() {
entry:
  br label %sw.bb31

sw.bb31:                                          ; preds = %sw.bb31, %entry
  br label %sw.bb31

if.then34:                                        ; No predecessors!
  %call53 = call i1 @fmt()
  unreachable
}

define internal i1 @fmt() {
entry:
  %call1 = call i1 @get_paragraph()
  ret i1 false
}

define internal i1 @get_paragraph() {
entry:
  ret i1 false

if.then14:                                        ; No predecessors!
  br label %do.body

do.body:                                          ; preds = %do.body, %if.then14
  %call15 = call i32 @get_line()
  br label %do.body
}

define internal i32 @get_line() {
entry:
  call void @check_punctuation(ptr null, i32 0)
  ret i32 0
}

define internal void @check_punctuation(ptr %finish, i32 %conv17) {
entry:
  %call18 = call ptr @strchr(ptr @.str.51, i32 %conv17)
  %cmp19 = icmp ne ptr %call18, null
  %conv20 = zext i1 %cmp19 to i32
  %0 = trunc i32 %conv20 to i8
  store i8 %0, ptr %finish, align 8
  ret void
}

declare ptr @strchr(ptr, i32)
