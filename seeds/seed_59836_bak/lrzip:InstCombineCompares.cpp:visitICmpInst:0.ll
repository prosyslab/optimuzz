target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_ZN7libzpaq5ZPAQLD2Ev() personality ptr null {
entry:
  call void @_ZN7libzpaq5ArrayIhED2Ev()
  ret void
}

define linkonce_odr void @_ZN7libzpaq5ArrayIhED2Ev() personality ptr null {
entry:
  call void @_ZN7libzpaq5ArrayIhE6resizeEmi(i64 0)
  ret void
}

define linkonce_odr void @_ZN7libzpaq5ArrayIhE6resizeEmi(i64 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %if.then, %while.cond, %entry
  %cmp2 = icmp ugt i64 1, %0
  br i1 %cmp2, label %if.then, label %while.cond

if.then:                                          ; preds = %while.cond
  call void @_ZN7libzpaq5errorEPKc()
  br label %while.cond
}

declare void @_ZN7libzpaq5errorEPKc()

; uselistorder directives
uselistorder ptr null, { 2, 3, 0, 4, 5, 1 }
