[![Built for](https://img.shields.io/badge/built%20for-microcontrollers-lightgrey)](https://github.com/kmilo17pet/QuarkTS)
[![Build Status](https://travis-ci.org/kmilo17pet/QuarkTS.svg?branch=master)](https://travis-ci.org/kmilo17pet/QuarkTS)
[![C/C++ CI](https://github.com/kmilo17pet/QuarkTS/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/kmilo17pet/QuarkTS/actions/workflows/c-cpp.yml)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/feb105e70ad84459851b3bdc8202d700)](https://app.codacy.com/gh/TECREA/QuarkTS?utm_source=github.com&utm_medium=referral&utm_content=TECREA/QuarkTS&utm_campaign=Badge_Grade_Dashboard)
[![CodeFactor](https://www.codefactor.io/repository/github/kmilo17pet/quarkts/badge)](https://www.codefactor.io/repository/github/kmilo17pet/quarkts)
[![Language grade: C/C++](https://img.shields.io/lgtm/grade/cpp/g/TECREA/QuarkTS.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/TECREA/QuarkTS/context:cpp)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/TECREA/QuarkTS.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/TECREA/QuarkTS/alerts/)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/TECREA/QuarkTS)](https://github.com/TECREA/QuarkTS/releases)
[![MISRAC2012](https://img.shields.io/badge/MISRAC2012-Compliant-blue.svg)](https://en.wikipedia.org/wiki/MISRA_C)
[![CERT](https://img.shields.io/badge/CERT-Compliant-blue.svg)](https://wiki.sei.cmu.edu/confluence/display/seccode/SEI+CERT+Coding+Standards)
[![C Standard](https://img.shields.io/badge/STD-C99-green.svg)](https://en.wikipedia.org/wiki/C99)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/TECREA/QuarkTS/graphs/commit-activity)
[![License](https://img.shields.io/github/license/TECREA/QuarkTS)](https://github.com/TECREA/QuarkTS/blob/master/LICENSE) [![Join the chat at https://gitter.im/embedded-c/QuarkTS-OS](https://badges.gitter.im/embedded-c/QuarkTS-OS.svg)](https://gitter.im/embedded-c/QuarkTS-OS?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

![Logo](https://sites.google.com/site/controlpoli2/quarkts.jpg)

# QuarkTS : An open-source OS for small embedded applications.

* Download the latest release [here](https://github.com/TECREA/QuarkTS/releases)
* Download the latest [User Manual](https://github.com/kmilo17pet/quarkts-usermanual/raw/travis-pdf/main.pdf)

QuarkTS is an operating system that provides a modern environment to build stable and predictable event-driven multitasking embedded software. The OS is built on top of a cooperative quasi-static scheduler and its simplified kernel implements a specialized round-robin scheme using a linked-chain approach and an event-queue to provide true FIFO priority-scheduling.

## Features:
- Prioritized cooperative scheduling.
- Time control (Timed tasks and software timers)
- Inter-Task communication primitives, queues, notifications and event-flags.
- State-Machines ( hierarchical support )
- Co-routines.
- AT Command Line Interface (CLI)

QuarkTS is developed using a formal and rigorous process framed in compliance of the MISRA C 2012 and CERT coding standard guidelines and complemented with multiple static-analysis checks targered to safe critical applications. 

### Why cooperative?

Rather than having preemption, tasks manage their own life-cycle. This bring significant benefits, fewer re-entrance problems are encountered, because tasks cannot be interrupted arbitrarily by other tasks, but only at positions permitted by the programmer, so you mostly do not need to worry about pitfalls of the concurrent approach (resource-sharing, race-conditions, deadlocks, etc...). 

### What is it made for?

The design goal of QuarkTS is to achieve its stated functionality using a small, simple, and (most importantly) robust implementation to  make it suitable on resource-constrained microcontrollers, where a full-preemptive RTOS is an overkill and their inclusion adds unnecessary complexity to the firmware development. In addition with a state-machines support, co-routines, time control and the inter-task communication primitives, QuarkTS provides a modern environment to build stable and predictable event-driven multitasking embedded software. Their modularity and reliability make this OS a great choice to develop efficiently a wide range of applications in low-cost devices, including automotive controls, monitoring and Internet of Things.

### Why should I choose QuarkTS?

QuarkTS is not intended to replace o compete with the other great and proven RTOS options already available today, for example [FreeRTOS](https://freertos.org/) or [MicroC/OS-II](https://www.micrium.com/rtos/), in fact, you should check these options first. However, due to its size and features, is intended to play in the space between RTOSes and bare-metal. QuarkTS was written for embedded developers who want more functionality than what existing task schedulers offer yet want to avoid the space and complexity of a full RTOS, but keeping the taste of a robust and safe one. 

## Cloning QuarkTS

Make sure to use the recursive flag to fetch the kernel submodule into src/os

```
git clone https://github.com/kmilo17pet/QuarkTS.git --recursive
```


## QuarkTS as a git submodule :

### Creating

```
git submodule add -b kernel_only https://github.com/kmilo17pet/QuarkTS.git <destination path>
```

Then, run the initialize command to fetch the code for the first time:

```
git submodule update --init
```

### Updating

```
git submodule update --remote
```

### Get a copy of the configuration file (qconfig.h):

```
curl https://raw.githubusercontent.com/kmilo17pet/QuarkTS/master/src/config/qconfig.h -o <destination path>/qconfig.h
```
