define i32 @0(ptr %val0, i8 %val1, i32 %0, i32 %1) {
entry:
  %val2 = zext i8 2 to i64
  %val3 = urem i64 %val2, 32
  %val4 = trunc i64 %val3 to i32
  store i32 %val4, ptr %val0, align 4
  ret i32 %val4
}
