target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.T2P_TILES = type { i32, i32, i32, i32, i32, i32, i32, ptr }

define i32 @t2p_tile_is_right_edge(ptr %tiles, i32 %0) {
entry:
  %add = add i32 %0, 1
  %rem = urem i32 %add, %0
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %tiles_edgetilewidth = getelementptr %struct.T2P_TILES, ptr %tiles, i32 0, i32 5
  br label %common.ret
}
