target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.libzpaq::Predictor" = type <{ i32, i32, [256 x i32], [256 x i32], ptr, [256 x %"struct.libzpaq::Component"], [256 x i32], [1024 x i32], [4096 x i16], [32768 x i16], %"class.libzpaq::StateTable", ptr, i32, [4 x i8] }>
%"struct.libzpaq::Component" = type { i64, i64, i64, i64, i64, %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0" }
%"class.libzpaq::Array.0" = type <{ ptr, i64, i32, [4 x i8] }>
%"class.libzpaq::StateTable" = type { [1024 x i8] }

define void @_ZN7libzpaq9PredictorD2Ev(ptr %this1, ptr %arraydestroy.elementPast) personality ptr null {
entry:
  %comp = getelementptr %"class.libzpaq::Predictor", ptr %this1, i64 0, i32 5
  br label %arraydestroy.body

arraydestroy.body:                                ; preds = %arraydestroy.body, %entry
  %arraydestroy.element4 = getelementptr %"struct.libzpaq::Component", ptr %arraydestroy.elementPast, i64 -1
  %arraydestroy.done = icmp eq ptr %arraydestroy.element4, %comp
  br i1 %arraydestroy.done, label %arraydestroy.done2, label %arraydestroy.body

arraydestroy.done2:                               ; preds = %arraydestroy.body
  ret void
}

; uselistorder directives
uselistorder ptr null, { 1, 2, 0 }
