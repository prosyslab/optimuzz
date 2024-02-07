; ModuleID = 'seeds/seed_57899/libslirp:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/libslirp:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @tcpx_listen(i32 %0) {
entry:
  %and109 = lshr i32 %0, 14
  %and109.lobit = and i32 %and109, 1
  %call112 = call i32 @slirp_socket_set_v6only(i32 %and109.lobit)
  ret ptr null
}

declare i32 @slirp_socket_set_v6only(i32)
