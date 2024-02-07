; ModuleID = 'seeds/seed_57899/tiff2pdf.o:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/tiff2pdf.o:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @t2p_compose_pdf_page(ptr %t2p.addr, i32 %0) {
entry:
  %cmp140 = icmp ne i32 %0, 0
  %cond = zext i1 %cmp140 to i32
  store i32 %cond, ptr %t2p.addr, align 4
  ret void
}
