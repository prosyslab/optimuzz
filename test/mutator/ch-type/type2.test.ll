define i32 @0(ptr %val0, i8 %val1, i1 %0, i1 %1) {
entry:
  %val2 = trunc i8 1 to i1
  %val3 = xor i1 %val2, true
  %val4 = zext i1 %val3 to i32
  store i32 %val4, ptr %val0, align 4
  ret i32 %val4
}
