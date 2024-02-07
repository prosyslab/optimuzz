target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.png_color_16_struct = type { i8, i16, i16, i16, i16 }

define i32 @opng_reduce_image() {
if.end:
  %call21 = call i32 @opng_reduce_bits(ptr undef, ptr undef, ptr undef, i16 undef)
  ret i32 0
}

define internal i32 @opng_reduce_bits(ptr %trans_color, ptr %0, ptr %green, i16 %1) {
entry:
  %trans_color1 = alloca ptr, align 8
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.then3

if.then3:                                         ; preds = %if.end
  br label %if.end4

if.end4:                                          ; preds = %if.then3
  br label %if.else10

if.else10:                                        ; preds = %if.end4
  br label %if.end11

if.end11:                                         ; preds = %if.else10
  br label %if.end22

if.end22:                                         ; preds = %if.end11
  br label %if.end32

if.end32:                                         ; preds = %if.end22
  br label %for.cond

for.cond:                                         ; preds = %if.end32
  br label %for.end

for.end:                                          ; preds = %for.cond
  br label %if.end66

if.end66:                                         ; preds = %for.end
  br label %if.then69

if.then69:                                        ; preds = %if.end66
  br label %if.end71

if.end71:                                         ; preds = %if.then69
  br label %for.cond73

for.cond73:                                       ; preds = %if.end71
  br label %for.end101

for.end101:                                       ; preds = %for.cond73
  br label %if.then104

if.then104:                                       ; preds = %for.end101
  br label %if.then107

if.then107:                                       ; preds = %if.then104
  br i1 true, label %land.lhs.true111, label %if.else143

land.lhs.true111:                                 ; preds = %if.then107
  %2 = load ptr, ptr %trans_color, align 8
  %green2 = getelementptr inbounds %struct.png_color_16_struct, ptr %0, i32 0, i32 2
  %3 = load i16, ptr %trans_color, align 2
  %conv112 = zext i16 %1 to i32
  %rem113 = srem i32 %conv112, 257
  %cmp114 = icmp eq i32 %rem113, 0
  br i1 %cmp114, label %land.lhs.true116, label %if.else143

land.lhs.true116:                                 ; preds = %land.lhs.true111
  %4 = load ptr, ptr undef, align 8
  br i1 false, label %land.lhs.true121, label %if.else143

land.lhs.true121:                                 ; preds = %land.lhs.true116
  br i1 false, label %if.then126, label %if.else143

if.then126:                                       ; preds = %land.lhs.true121
  ret i32 0

if.else143:                                       ; preds = %land.lhs.true121, %land.lhs.true116, %land.lhs.true111, %if.then107
  ret i32 0
}

declare i32 @opng_analyze_bits()

declare ptr @png_get_rows()

declare i8 @png_get_channels()

declare i32 @png_get_bKGD()

declare i32 @png_get_IHDR()

declare i32 @png_get_tRNS()
