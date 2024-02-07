target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @snprintf(ptr, i64, ptr, ...)

define i64 @t2p_write_pdf_xobject_stream_filter(i16 %0) {
entry:
  %conv206 = zext i16 %0 to i32
  %rem207 = urem i32 %conv206, 100
  %call210 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr null, i64 0, ptr null, i32 %rem207)
  ret i64 0
}
