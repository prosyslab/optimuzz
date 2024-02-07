target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ImportID3v2() {
entry:
  %call45 = call fastcc i32 @ImportID3v2_syncsafe()
  ret i32 0
}

define internal fastcc i32 @ImportID3v2_syncsafe() {
entry:
  %call2101 = call fastcc i32 @ID3v2StringsToUTF8(i16 0, i1 false)
  ret i32 0
}

define internal fastcc i32 @ID3v2StringsToUTF8(i16 %0, i1 %cmp2.i) {
entry:
  %cmp.i = icmp ult i16 %0, 1
  %or.cond = select i1 %cmp.i, i1 %cmp2.i, i1 false
  br i1 %or.cond, label %if.then.i232, label %if.else.i

if.then.i232:                                     ; preds = %entry
  %conv4.i = trunc i16 0 to i8
  br label %if.else.i

if.else.i:                                        ; preds = %if.then.i232, %entry
  ret i32 0
}
