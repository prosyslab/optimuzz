target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @ftp_request(ptr %defanged) {
entry:
  %buf = alloca [256 x i8], align 16
  %0 = load ptr, ptr %defanged, align 8
  %cmp24 = icmp ne ptr %0, %buf
  br i1 %cmp24, label %do.body27, label %common.ret

common.ret:                                       ; preds = %do.body27, %entry
  ret ptr null

do.body27:                                        ; preds = %entry
  %1 = load ptr, ptr %defanged, align 8
  br label %common.ret
}

define i32 @ftp_port() {
entry:
  %call51 = call ptr @ftp_request(ptr null)
  ret i32 0
}
