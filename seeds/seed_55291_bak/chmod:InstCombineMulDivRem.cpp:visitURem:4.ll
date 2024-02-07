target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.I_ring = type { [4 x i32], i32, i32, i32, i8 }

define i32 @i_ring_push(ptr %ir.addr, ptr %0, ptr %ir_front, i32 %1, i32 %add, ptr %dest_idx, ptr %2, i32 %3, ptr %ir_data1, i64 %idxprom2, ptr %arrayidx3) {
entry:
  %ir.addr1 = alloca ptr, align 8
  %dest_idx2 = alloca i32, align 4
  %4 = load ptr, ptr %ir.addr, align 8
  %ir_front3 = getelementptr inbounds %struct.I_ring, ptr %0, i32 0, i32 2
  %5 = load i32, ptr %ir.addr, align 4
  %lnot.ext = zext i1 false to i32
  %add4 = add i32 %1, 0
  %rem = urem i32 %1, 4
  store i32 %rem, ptr %ir.addr, align 4
  %6 = load ptr, ptr undef, align 8
  %ir_data15 = getelementptr inbounds %struct.I_ring, ptr %2, i32 0, i32 0
  %7 = load i32, ptr %ir.addr, align 4
  %idxprom26 = zext i32 %1 to i64
  %arrayidx37 = getelementptr inbounds [4 x i32], ptr %ir_data1, i64 0, i64 %idxprom2
  store i32 0, ptr %ir.addr, align 4
  ret i32 0
}
