[![Built for](https://img.shields.io/badge/built%20for-microcontrollers-lightgrey)](https://github.com/kmilo17pet/QuarkTS)
[![Build Status](https://travis-ci.org/TECREA/QuarkTS.svg?branch=master)](https://travis-ci.org/TECREA/QuarkTS)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/feb105e70ad84459851b3bdc8202d700)](https://app.codacy.com/gh/TECREA/QuarkTS?utm_source=github.com&utm_medium=referral&utm_content=TECREA/QuarkTS&utm_campaign=Badge_Grade_Dashboard)
[![CodeFactor](https://www.codefactor.io/repository/github/tecrea/quarkts/badge)](https://www.codefactor.io/repository/github/tecrea/quarkts)
[![Language grade: C/C++](https://img.shields.io/lgtm/grade/cpp/g/TECREA/QuarkTS.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/TECREA/QuarkTS/context:cpp)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/TECREA/QuarkTS.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/TECREA/QuarkTS/alerts/)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/TECREA/QuarkTS)](https://github.com/TECREA/QuarkTS/releases)
[![MISRAC2012](https://img.shields.io/badge/MISRAC2012-Compliant-blue.svg)](https://en.wikipedia.org/wiki/MISRA_C)
[![CERT](https://img.shields.io/badge/CERT-Compliant-blue.svg)](https://wiki.sei.cmu.edu/confluence/display/seccode/SEI+CERT+Coding+Standards)
[![C Standard](https://img.shields.io/badge/STD-C99-green.svg)](https://en.wikipedia.org/wiki/C99)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/TECREA/QuarkTS/graphs/commit-activity)
[![License](https://img.shields.io/github/license/TECREA/QuarkTS)](https://github.com/TECREA/QuarkTS/blob/master/LICENSE) [![Join the chat at https://gitter.im/embedded-c/QuarkTS-OS](https://badges.gitter.im/embedded-c/QuarkTS-OS.svg)](https://gitter.im/embedded-c/QuarkTS-OS?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

![Logo](https://sites.google.com/site/controlpoli2/quarkts.jpg)

# QuarkTS : An open-source OS for resource-constrained embedded applications.

* Download the latest release [here](https://github.com/TECREA/QuarkTS/releases)
* Download the latest [User Manual](https://github.com/kmilo17pet/quarkts-usermanual/raw/travis-pdf/main.pdf)

Checked with C-STAT for MISRAC2012 Compliance.

QuarkTS is an operating system that provides a modern environment to build stable and predictable event-driven multitasking embedded software. The OS is built on top of a cooperative quasi-static scheduler and its simplified kernel implements a specialized round-robin scheme using a linked-chain approach and an event-queue to provide true FIFO priority-scheduling.

## Features:
- Prioritized cooperative scheduling.
- Time control (Timed tasks and software timers)
- Inter-Task communication primitives, queues, notifications and event-flags.
- State-Machines ( hierarchical support )
- Co-routines.
- AT Command Line Interface (CLI)

All the included features make this OS suitable for resource-constrained microcontrollers, where a full-preemptive RTOS is an overkill and their inclusion adds unnecessary complexity to the firmware development. Their modularity and reliability make this OS a great choice to develop efficiently a wide range of applications in low-cost devices, including automotive controls, monitoring and Internet of Things.
