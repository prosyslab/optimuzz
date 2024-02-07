target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.libzpaq::Array.0" = type <{ ptr, i64, i32, [4 x i8] }>

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

define linkonce_odr void @_ZN7libzpaq5ArrayIhE6resizeEmi(ptr %this1, i64 %0) {
entry:
  %cmp4 = icmp ugt i64 %0, 0
  br i1 %cmp4, label %if.then5, label %if.end6

if.then5:                                         ; preds = %entry
  %data = getelementptr %"class.libzpaq::Array.0", ptr %this1, i32 0, i32 0
  br label %if.end6

if.end6:                                          ; preds = %if.then5, %entry
  ret void
}

; uselistorder directives
uselistorder ptr null, { 1, 3, 4, 0, 5, 6, 2 }
