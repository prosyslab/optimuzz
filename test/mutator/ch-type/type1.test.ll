define i34 @0(ptr %val0, i34 %val1, i64 %val2, i8 %val3) {
entry:
  %val4 = shl i34 -1, 4294967295
  %val5 = urem i34 -1, %val1
  ret i34 %val5
}

