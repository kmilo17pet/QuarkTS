/*
 @licstart  The following is the entire license notice for the JavaScript code in this file.

 The MIT License (MIT)

 Copyright (C) 1997-2020 by Dimitri van Heesch

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 and associated documentation files (the "Software"), to deal in the Software without restriction,
 including without limitation the rights to use, copy, modify, merge, publish, distribute,
 sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 @licend  The above is the entire license notice for the JavaScript code in this file
*/
var NAVTREE =
[
  [ "OS", "index.html", [
    [ "User manual", "index.html", null ],
    [ "Overview", "q_background.html", [
      [ "About the OS", "q_background.html#q_about", null ],
      [ "License", "q_background.html#q_license", null ],
      [ "Hardware compatibility", "q_background.html#q_hardwarecompatibility", null ],
      [ "Development process and coding standard", "q_background.html#q_codstandard", null ],
      [ "Memory usage", "q_background.html#q_memusage", null ]
    ] ],
    [ "Foundations", "q_foundations.html", [
      [ "RTC(Run To Completion) model", "q_foundations.html#rtcmodel", null ],
      [ "Timing Approach", "q_foundations.html#q_timmingapproach", null ],
      [ "Setting up the OS kernel", "q_foundations.html#q_setupkernel", null ],
      [ "Tasks", "q_foundations.html#q_tasks", [
        [ "The idle task", "q_foundations.html#q_idletask", null ],
        [ "Adding tasks to the scheme", "q_foundations.html#q_addtasks", null ],
        [ "Event-triggered tasks", "q_foundations.html#q_eventtasks", null ],
        [ "Removing a task", "q_foundations.html#q_removetask", null ]
      ] ],
      [ "Running the OS", "q_foundations.html#q_runos", [
        [ "Releasing the scheduler", "q_foundations.html#q_releasescheduler", null ]
      ] ],
      [ "Global states and scheduling rules", "q_foundations.html#q_globalstates", [
        [ "Rules", "q_foundations.html#q_osrules", [
          [ "Event precedence", "q_foundations.html#q_os_evenprecedence", null ],
          [ "Additional operational states", "q_foundations.html#q_os_operational_states", null ]
        ] ]
      ] ],
      [ "Critical sections", "q_foundations.html#q_critical", null ],
      [ "Configuration macros", "q_foundations.html#q_configmacros", null ]
    ] ],
    [ "Getting-Started", "q_gettingstarted.html", [
      [ "Getting the OS", "q_gettingstarted.html#q_getos", [
        [ "Cloning QuarkTS", "q_gettingstarted.html#q_cloneos", null ],
        [ "Including QuarkTS as a git sub-module", "q_gettingstarted.html#q_submodule", null ],
        [ "Get a copy of the OS configuration file", "q_gettingstarted.html#q_getqconfig", null ]
      ] ],
      [ "First steps", "q_gettingstarted.html#q_firststeps", null ],
      [ "Two simple demonstrative examples", "q_gettingstarted.html#q_os_demo", [
        [ "A simple scheduling", "q_gettingstarted.html#q_os_example1", null ],
        [ "Using the task argument", "q_gettingstarted.html#q_os_example2", null ]
      ] ]
    ] ],
    [ "Events", "q_events.html", [
      [ "Retrieving the event data", "q_events.html#eventdata", null ],
      [ "The Time-Elapsed event", "q_events.html#q_event_timeelapsed", null ],
      [ "Asynchronous events and inter-task communication", "q_events.html#q_asyncevents", [
        [ "Notifications", "q_events.html#q_notifications", [
          [ "Simple Notifications", "q_events.html#q_simplenot", null ],
          [ "Queued Notifications", "q_events.html#q_queuednot", null ],
          [ "Sending notifications", "q_events.html#q_notificationsend", null ],
          [ "Spread a notification", "q_events.html#qnotspread", null ]
        ] ],
        [ "Queues", "q_events.html#q_queues", [
          [ "Setting up a queue", "q_events.html#q_queuesetup", null ],
          [ "Attach a queue to a task", "q_events.html#q_attachqueue", null ],
          [ "A queue example", "q_events.html#q_queueexample", null ]
        ] ],
        [ "Event Flags", "q_events.html#qeventflags", [
          [ "Using the task Event-flags", "q_events.html#q_eventflagsexample", null ]
        ] ]
      ] ]
    ] ],
    [ "Extensions", "q_extensions.html", [
      [ "STimers", "q_extensions.html#q_stimers", [
        [ "Using a STimer", "q_extensions.html#q_stimerusage", null ],
        [ "STimer example", "q_extensions.html#q_stimerexample", null ]
      ] ],
      [ "Finite State Machines (FSM)", "q_extensions.html#q_fsm", [
        [ "The provided approach", "q_extensions.html#qfsm_approach", null ],
        [ "Setting up a state machine", "q_extensions.html#q_fsmsetup", null ],
        [ "Subscribing states and defining callbacks", "q_extensions.html#q_fsm_subscribe_states", null ],
        [ "The state callback handler: performing transitions and retreiving data", "q_extensions.html#q_fsmhandler", null ],
        [ "The surrounding callback", "q_extensions.html#q_fsm_surrounding", null ],
        [ "Adding a state machine as a task", "q_extensions.html#q_fsm_astask", null ],
        [ "A demonstrative example for a FSM", "q_extensions.html#q_fsm_example1", null ],
        [ "Sending signals", "q_extensions.html#q_fsmsendsignals", null ],
        [ "Installing a signal queue", "q_extensions.html#q_fsminstallsignalqueue", null ],
        [ "Using a transition table", "q_extensions.html#q_fsm_ttable", null ],
        [ "Signal actions and guards", "q_extensions.html#q_fsm_sigactions", null ],
        [ "FSM Timeout specification", "q_extensions.html#q_fsm_timeout", null ],
        [ "Demonstrative example using transition tables", "q_extensions.html#q_fsm_example2", null ],
        [ "Using the hierarchical approach", "q_extensions.html#qfsm_happroach", [
          [ "Example usign a hierarchical FSM", "q_extensions.html#q_fsm_example3", null ],
          [ "Example with history pseudo-states", "q_extensions.html#q_fsm_example4", null ]
        ] ]
      ] ],
      [ "Co-Routines", "q_extensions.html#q_qcoroutines", [
        [ "Coding a Co-Routine", "q_extensions.html#q_coroutine_code", null ],
        [ "Blocking calls in a Co-routine", "q_extensions.html#q_coroutine_blocking", null ],
        [ "Co-Routine usage example", "q_extensions.html#q_coroutine_example1", null ],
        [ "Positional jumps", "q_extensions.html#q_coroutine_positions", null ],
        [ "Semaphores", "q_extensions.html#q_coroutine_semaphores", null ],
        [ "Co-Routine example with semaphores.", "q_extensions.html#q_coroutine_example2", null ],
        [ "External control", "q_extensions.html#q_coroutine_ext", null ]
      ] ],
      [ "AT Command Line Interface (CLI)", "q_extensions.html#q_atcli", [
        [ "The components of the CLI", "q_extensions.html#q_atcli_components", null ],
        [ "Supported syntax", "q_extensions.html#q_atcli_syntax", null ],
        [ "Setting up an AT-CLI instance", "q_extensions.html#q_atcli_setup", null ],
        [ "Subscribing commands to the parser", "q_extensions.html#q_atcli_sub_commands", null ],
        [ "Writting a command callback", "q_extensions.html#q_atcli_cmd_callback", null ],
        [ "Handling the input", "q_extensions.html#q_atcli_inputh", null ],
        [ "Running the CLI parser", "q_extensions.html#q_atcli_run", null ],
        [ "A CLI example", "q_extensions.html#q_atcli_example1", null ]
      ] ],
      [ "Memory Management", "q_extensions.html#q_memmang", [
        [ "Principle of operation", "q_extensions.html#q_memmang_principle", null ],
        [ "Memory pools", "q_extensions.html#q_memmang_pools", null ],
        [ "Usage example", "q_extensions.html#q_memmang_usage", null ]
      ] ],
      [ "Trace and debugging", "q_extensions.html#q_trace", [
        [ "Viewing variables", "q_extensions.html#q_trace_viewvars", null ],
        [ "Viewing a memory block", "q_extensions.html#q_trace_mblock", null ],
        [ "Usage", "q_extensions.html#q_trace_usage", null ]
      ] ]
    ] ],
    [ "Modules", "modules.html", "modules" ],
    [ "Data Structures", "annotated.html", [
      [ "Data Structures", "annotated.html", "annotated_dup" ],
      [ "Data Structure Index", "classes.html", null ],
      [ "Data Fields", "functions.html", [
        [ "All", "functions.html", null ],
        [ "Variables", "functions_vars.html", null ]
      ] ]
    ] ]
  ] ]
];

var NAVTREEINDEX =
[
"annotated.html",
"group__qmemmang.html",
"q_gettingstarted.html#q_submodule"
];

var SYNCONMSG = 'click to disable panel synchronisation';
var SYNCOFFMSG = 'click to enable panel synchronisation';