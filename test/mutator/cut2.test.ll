define i1 @0(ptr %val0, i8 %val1, i64 %0, i64 %1) {
entry:
  %val2 = zext i8 %val1 to i64
  %val3 = urem i64 %val2, 32
  %val4 = trunc i64 %val3 to i32
  %val5 = icmp ne i32 %val4, 0
  br i1 %val5, label %if.end578, label %land.lhs.true575

land.lhs.true575:                                 ; preds = %entry
  %val6 = load i8, ptr %val0, align 1
  br label %if.end578

if.end578:                                        ; preds = %land.lhs.true575, %entry
  ret i1 %val5
}

