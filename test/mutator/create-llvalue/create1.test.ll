define i64 @0(ptr %val0, i64 %val1, i64 %0, i64 %1) {
entry:
  %val2 = alloca i64, align 8
  br label %if.else

if.else:                                          ; preds = %entry
  br label %if.then1

if.then1:                                         ; preds = %if.else
  %val3 = load i64, ptr %val0, align 4
  %val4 = urem i64 %val1, 2
  store i64 %val4, ptr null, align 4
  ret i64 2
}

