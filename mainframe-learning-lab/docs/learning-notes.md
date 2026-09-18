# Mainframe Interview Learning Notes

## IBM mainframe
A mainframe is a high-throughput enterprise computer designed for reliability,
large transaction volumes, batch workloads, and long-running business systems.

## z/OS
IBM's operating system for IBM Z mainframes. It plays the same broad role that
Linux or Windows does on other systems, although the environment and tooling are
different.

## MVS / Sysplex
MVS is the historical architecture behind modern z/OS. A Parallel Sysplex links
multiple z/OS systems so workloads can be distributed while supporting high
availability.

## JCL
Job Control Language tells z/OS what batch job to run, what program to execute,
and which datasets/resources the job needs. JCL is orchestration, not the same
thing as the application program itself.

## TSO / ISPF
TSO provides interactive access to z/OS. ISPF is the menu/panel environment often
used to edit datasets, submit jobs, and inspect output.

## VSAM
A mainframe data-access method used for structured datasets. Common organizations
include KSDS (key-sequenced), ESDS (entry-sequenced), and RRDS
(relative-record).

## COBOL
A business-oriented programming language heavily used in enterprise batch and
transaction-processing systems.

## Broadcom ESP
An enterprise workload automation/scheduling product. Conceptually it coordinates
when jobs run, their dependencies, calendars, alerts, and recovery behavior.

## Git / Bitbucket / GitHub
Git is the version-control system. GitHub and Bitbucket are platforms that host Git
repositories and add collaboration features such as pull requests and issue
tracking.

## SDLC
Software Development Life Cycle: plan/requirements -> design -> build -> test ->
deploy -> operate/maintain.

## Kanban
A visual workflow method where work moves through stages such as To Do, In
Progress, Review, and Done. It emphasizes limiting work in progress and improving
flow.

## Root-cause analysis
A structured process for finding the underlying reason an incident happened
rather than only treating the immediate symptom.
