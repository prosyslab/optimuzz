+++
date = '2025-05-08'
title = 'Optimuzz meets LLM!'
summary = 'We have successfully integrated LLMs into our workflow to automate Optimuzz for LLVM.'
+++

## Introduction

Given a target optimization, Optimuzz excels at generating input programs that trigger the optimization.
Optimuzz then checks the correctness of the optimization by translation-validating the optimized programs from the generated input programs.
It has demonstrated its effectiveness in finding miscompilation bugs in LLVM and TurboFan, and even found out unknown bugs in the recent LLVM versions.

While the nearly whole process is effective and automated, it still requires human effort to identify the target optimization.
For example, an update on an optimization in LLVM may introduce a new optimization, change the optimization condition, or even remove the optimization.
In addition, from such changes, one should also identify an exact target line in the optimization.
Although the process is not very difficult, it still requires manual intervention.

## Optimuzz and LLM

This is where LLMs come to the rescue.
We observe that the process of identifying the target optimization does not require a deep understanding of the whole compiler.
Instead, it can be easily identified by reading the commit message and the code changes.
For example, we asked the LLM with the following prompt:

```
The commit message is:
[InstCombine] Preserve the sign bit of NaN in `SimplifyDemandedUseFPClass` (#137287)

Alive2: https://alive2.llvm.org/ce/z/uiUzEf

Closes https://github.com/llvm/llvm-project/issues/137196.

Note: To avoid regression in
`ret_nofpclass_nopositives_copysign_nnan_flag`, the second commit takes
FMF into account.

The code change is as follows:

File: llvm/lib/Transforms/InstCombine/InstCombineSimplifyDemanded.cpp
Status: modified
Patch:
...
2022 |
--- | -      if ((DemandedMask & fcPositive) == fcNone) {
2023 | +      if ((DemandedMask & fcNegative) == DemandedMask) {
2024 |          // Roundabout way of replacing with fneg(fabs)
2025 |          I->setOperand(1, ConstantFP::get(VTy, -1.0));
2026 |          return I;
2027 |        }

...

Which target line should Optimuzz aim at? Provide your best suggestion of the target line.
```

The LLM answered with the target line 2026, where the optimized instruction is returned for the update optimization condition.
Therefore, we confirmed that the LLM can effectively identify the target line of the optimization update.

As a result, we have successfully integrated LLMs into our workflow.
Every time there is an update on an optimization in LLVM, we automatically fetch the commit information using the GitHub API.
We then use the commit message and the code changes to consult the LLM.
Then, we run Optimuzz to check the correctness of the updated optimization using the target line suggested by the LLM.

## Conclusion

Reading a commit information and identifying the target optimization for each update is a tedious task.
However, we used LLMs to automate this process and successfully integrated it into our workflow.
This comes with two benefits as we describe below.

This drastically improves the productivity in employing Optimuzz.
As of now, there is no need to manually intervene in the process of running Optimuzz for LLVM.
This means that we can run Optimuzz for every optimization update in LLVM.
Therefore, we can contribute more to enhance the reliability of the LLVM compiler.

In addition, this workflow provides an insight into the potential usefulness of LLMs in a wide range of software testing tasks.
Typically, analyzing a source code requires a well-formed input even if the input is small and simple.
For example, it would not be possible to analyze a commit with a message and code changes with
traditional tools such as static analyzer.
However, LLMs can take such unstructured inputs and provide a useful analysis result.
