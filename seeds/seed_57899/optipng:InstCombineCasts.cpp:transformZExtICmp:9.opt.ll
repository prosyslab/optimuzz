; ModuleID = 'seeds/seed_57899/optipng:InstCombineCasts.cpp:transformZExtICmp:9.ll'
source_filename = "seeds/seed_57899/optipng:InstCombineCasts.cpp:transformZExtICmp:9.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @GIFReadNextBlock() {
entry:
  call void @GIFReadNextImage()
  ret i32 0
}

define internal void @GIFReadNextImage() {
entry:
  call void @GIFReadImageData()
  ret void
}

define internal void @GIFReadImageData() {
entry:
  %call1 = call i32 @LZWDecodeByte()
  ret void
}

define internal i32 @LZWDecodeByte() {
entry:
  %call1 = call i32 @LZWGetCode(ptr null, i32 0)
  ret i32 0
}

define internal i32 @LZWGetCode(ptr %LZWGetCode.buffer, i32 %0) {
entry:
  store i32 0, ptr %LZWGetCode.buffer, align 4
  ret i32 0
}
