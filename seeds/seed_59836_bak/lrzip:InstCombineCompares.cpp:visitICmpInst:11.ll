target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_ZN7libzpaq5ZPAQLD2Ev() personality ptr null {
entry:
  call void @_ZN7libzpaq5ArrayIhED2Ev()
  ret void
}

define linkonce_odr void @_ZN7libzpaq5ArrayIhED2Ev() personality ptr null {
entry:
  call void @_ZN7libzpaq5ArrayIhE6resizeEmi(ptr null, i64 0)
  ret void
}

define linkonce_odr void @_ZN7libzpaq5ArrayIhE6resizeEmi(ptr %nb, i64 %0) {
entry:
  %cmp14 = icmp ule i64 %0, 0
  br i1 %cmp14, label %if.then17, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i64, ptr %nb, align 8
  br label %if.then17

if.then17:                                        ; preds = %lor.lhs.false, %entry
  ret void
}

; uselistorder directives
uselistorder ptr null, { 1, 3, 4, 0, 5, 6, 2 }
