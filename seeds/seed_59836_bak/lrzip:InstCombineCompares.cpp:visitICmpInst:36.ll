target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_ZN7libzpaq5ZPAQLD2Ev() personality ptr null {
entry:
  call void @_ZN7libzpaq5ArrayIhED2Ev()
  ret void
}

define linkonce_odr void @_ZN7libzpaq5ArrayIhED2Ev() personality ptr null {
entry:
  call void @_ZN7libzpaq5ArrayIhE6resizeEmi(ptr null)
  ret void
}

define linkonce_odr void @_ZN7libzpaq5ArrayIhE6resizeEmi(ptr %this1) {
entry:
  %tobool.not = icmp eq ptr %this1, null
  br i1 %tobool.not, label %if.then21, label %if.end22

if.then21:                                        ; preds = %entry
  call void @_ZN7libzpaq5errorEPKc()
  br label %if.end22

if.end22:                                         ; preds = %if.then21, %entry
  ret void
}

declare void @_ZN7libzpaq5errorEPKc()

; uselistorder directives
uselistorder ptr null, { 0, 2, 4, 5, 1, 6, 7, 3 }
