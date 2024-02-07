target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @aes_setkey_enc() {
entry:
  call void @aes_gen_tables(ptr null, i8 0)
  ret i32 0
}

define internal void @aes_gen_tables(ptr %FSb, i8 %.pre) {
entry:
  br label %for.cond55

for.cond55:                                       ; preds = %for.cond55, %entry
  %conv61 = zext i8 %.pre to i32
  %and63 = and i32 %conv61, 128
  %tobool64 = icmp ne i32 %and63, 0
  %cond65 = select i1 %tobool64, i32 1, i32 0
  %xor68 = xor i32 %cond65, %conv61
  %conv77 = sext i32 %xor68 to i64
  store i64 %conv77, ptr %FSb, align 8
  br label %for.cond55
}
