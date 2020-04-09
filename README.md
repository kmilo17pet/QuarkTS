[![Built for](https://img.shields.io/badge/built%20for-microcontrollers-lightgrey)](https://github.com/kmilo17pet/QuarkTS)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/feb105e70ad84459851b3bdc8202d700)](https://app.codacy.com/gh/TECREA/QuarkTS?utm_source=github.com&utm_medium=referral&utm_content=TECREA/QuarkTS&utm_campaign=Badge_Grade_Dashboard)
[![CodeFactor](https://www.codefactor.io/repository/github/tecrea/quarkts/badge)](https://www.codefactor.io/repository/github/tecrea/quarkts)
[![Language grade: C/C++](https://img.shields.io/lgtm/grade/cpp/g/TECREA/QuarkTS.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/TECREA/QuarkTS/context:cpp)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/TECREA/QuarkTS.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/TECREA/QuarkTS/alerts/)
[![Latest Release](https://img.shields.io/badge/Release-6.2.3-green.svg)](https://github.com/TECREA/QuarkTS/releases)
[![MISRAC2012](https://img.shields.io/badge/MISRAC2012-Compliant-blue.svg)](https://en.wikipedia.org/wiki/MISRA_C)
[![CERT](https://img.shields.io/badge/CERT-Compliant-blue.svg)](https://wiki.sei.cmu.edu/confluence/display/seccode/SEI+CERT+Coding+Standards)
[![C Standard](https://img.shields.io/badge/STD-C99-green.svg)](https://en.wikipedia.org/wiki/C99)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/TECREA/QuarkTS/graphs/commit-activity)
[![Licence](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0.en.html)


![Logo](https://sites.google.com/site/controlpoli2/quarkts.jpg)

# QuarkTS : An open-source OS for resource-constrained embedded applications.

* Download the latest release [here](https://github.com/TECREA/QuarkTS/releases)
* Download the latest [User Manual](https://www.overleaf.com/read/wtmsjyvtznmy)

![MISRAC2012 Compliant](https://eenews.cdnartwhere.eu/sites/default/files/styles/inner_article/public/import/2014-07-22-edne-gp-misra-logo-snip.jpg?itok=bQVhv7S_)

Checked with C-STAT for MISRAC2012 Compliance.

QuarkTS is an operating system that provides a modern environment to build stable and predictable event-driven multitasking embedded software. The OS is built on top of a cooperative quasi-static scheduler and its simplified kernel implements a specialized round-robin scheme using a linked-chain approach and an event-queue to provide true FIFO priority-scheduling.

## Features:
- Prioritized cooperative scheduling.
- Time control (Timed tasks and software timers)
- Inter-Task comunnication primitives, queues, notifications and event-flags.
- State-Machines ( hierarchical support )
- Co-routines.
- AT Command Line Interface (CLI)

All the included features make this OS suitable for resource-constrained microcontrollers, where a full-preemptive RTOS is an overkill and their inclusion adds unnecessary complexity to the firmware development. Their modularity and reliability make this OS a great choice to develop efficiently a wide range of applications in low-cost devices, including automotive controls, monitoring and Internet of Things.
