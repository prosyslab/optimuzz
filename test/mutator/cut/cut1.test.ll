define i8 @0(ptr %0, i8 %1, i1 %2, i1 %3) {
entry:
  %val2 = zext i8 %1 to i64
  %4 = urem i64 32, %val2
  %val4 = trunc i64 %4 to i32
  %val5 = icmp ne i32 %val4, 0
  %val6 = load i8, ptr %0, align 1
  ret i8 %val6
}
