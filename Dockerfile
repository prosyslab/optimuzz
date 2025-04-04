FROM ubuntu:24.04

########## Dependencies ##########

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y cmake ninja-build re2c opam libz3-dev z3
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo git python3.12 python3-pip pkg-config libcairo2-dev libssl-dev libreadline-dev

########## Dependencies Ends ##########

# Setup Working Environment

RUN groupadd user
RUN useradd -g user -m -d /home/user user
RUN usermod -aG sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV TERM xterm-256color

WORKDIR /home/user
RUN chown -R user:user /home/user && chmod -R 755 /home/user

USER user

COPY --chown=user:user . optimuzz

WORKDIR /home/user/optimuzz
ENV LLVM_PATH /home/user/llvm-project
ENV LLVM_BUILDS /home/user/llvm-builds
