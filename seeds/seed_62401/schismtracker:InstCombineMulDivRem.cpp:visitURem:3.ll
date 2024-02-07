target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @csf_export_s3m_effect(ptr %effect, i8 %0) {
entry:
  %conv4 = zext i8 %0 to i32
  %rem = srem i32 %conv4, 10
  %conv5 = trunc i32 %rem to i8
  store i8 %conv5, ptr %effect, align 1
  ret void
}
