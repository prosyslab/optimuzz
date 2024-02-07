target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.T2P = type { i32, ptr, ptr, i32, i16, i16, i16, i16, i16, i16, i32, i32, float, float, i16, i64, i64, i64, i16, i16, i16, i16, float, float, float, float, float, float, float, float, float, float, i32, %struct.T2P_BOX, %struct.T2P_BOX, i16, i16, i32, i32, i32, i32, i16, i32, [33 x i8], [17 x i8], [512 x i8], i32, [512 x i8], i32, [512 x i8], i32, [512 x i8], i32, [512 x i8], i32, i32, i16, i16, i16, ptr, [4 x i32], i32, i16, i32, i16, i16, i32, i32, ptr, i32, i32, [2 x float], [6 x float], [2 x float], [3 x ptr], i32, i16, i32, i32, ptr, ptr, i32, i64 }
%struct.T2P_BOX = type { float, float, float, float, [9 x float] }

define void @t2p_validate(ptr %t2p.addr, ptr %0, ptr %pdf_defaultcompressionquality, i16 %1, ptr %m, i16 %2, i32 %conv6, i1 %cmp7) {
entry:
  %t2p.addr1 = alloca ptr, align 8
  %m2 = alloca i16, align 2
  br label %if.then

if.then:                                          ; preds = %entry
  %3 = load ptr, ptr %t2p.addr, align 8
  %pdf_defaultcompressionquality3 = getelementptr inbounds %struct.T2P, ptr %0, i32 0, i32 62
  %4 = load i16, ptr %t2p.addr, align 4
  %conv = zext i16 %1 to i32
  %rem = srem i32 %conv, 100
  %conv1 = trunc i32 %rem to i16
  store i16 %conv1, ptr %t2p.addr, align 2
  br label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then
  %5 = load i16, ptr %t2p.addr, align 2
  %conv64 = zext i16 %1 to i32
  %cmp75 = icmp sgt i32 %conv6, 0
  br i1 %cmp7, label %land.lhs.true, label %lor.lhs.false12

land.lhs.true:                                    ; preds = %lor.lhs.false
  %6 = load i16, ptr undef, align 2
  br label %lor.lhs.false12

lor.lhs.false12:                                  ; preds = %land.lhs.true, %lor.lhs.false
  ret void
}
