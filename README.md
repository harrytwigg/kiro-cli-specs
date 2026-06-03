# kiro-cli-specs

> Spec-driven development agents for terminal environments — bringing the [Kiro IDE](https://kiro.dev) specs workflow to the CLI.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/harrytwigg/kiro-cli-specs/main/install.sh | bash
```

The script will:
- Download all agents into `~/.kiro/agents/`
- Detect any existing agents and **ask before overriding** them
- Exit cleanly with no changes if you decline

> **Note:** This repo must be public (or you must be authenticated) for the raw URL to resolve. If the repo is private, clone it and run `install.sh` directly.

---

## Overview

This repository contains a set of AI agents that implement **spec-driven development** directly in your terminal. The agents replicate the structured specs workflow found in the Kiro IDE, making it available to any CLI-based AI coding assistant (such as GitHub Copilot CLI).

The core idea is simple: before writing code, write a spec. A spec consists of three documents:

| Document | Purpose |
|---|---|
| `requirements.md` | EARS-compliant user stories and acceptance criteria |
| `design.md` | Architecture, interfaces, data models, and testing strategy |
| `tasks.md` | Ordered, dependency-aware coding tasks with requirement traceability |

These agents guide you — or your AI assistant — through creating and executing those documents consistently, feature by feature.

---

## Agents

### `spec-orchestrator`
The entry point. Detects whether you want a feature spec, bugfix spec, or quick plan, then delegates to the appropriate specialist agents. Start here.

### `spec-requirements`
Generates EARS-pattern requirements documents with INCOSE quality rules. Produces `.kiro/specs/{feature}/requirements.md` with structured user stories and testable acceptance criteria.

### `spec-design`
Creates a technical design document covering architecture decisions, component interfaces, data models, correctness properties, and testing strategy. Produces `.kiro/specs/{feature}/design.md`.

### `spec-tasks`
Converts the design into an ordered task list with a dependency graph and requirement traceability. Produces `.kiro/specs/{feature}/tasks.md` in checkbox format.

### `spec-task-executor`
Executes individual tasks from `tasks.md`. Reads all spec documents, implements the code, runs tests, and updates task status.

### `spec-bugfix`
Creates bugfix specs using the bug condition methodology (`C(X)`, `F`, `F'`). Generates `bugfix.md`, `design.md`, and `tasks.md` with fix-checking and preservation-checking.

### `spec-fast-plan`
Quick-turnaround spec generation. Scans the workspace, asks 2–4 targeted questions, then silently generates requirements, design, and tasks in one pass. Good for smaller features.

### `requirement-detailer`
Refines individual requirements through 5-phase vagueness detection and gap analysis, making acceptance criteria unambiguous enough that two independent testers reach identical pass/fail results.

---

## Usage

Run the one-line installer (see [Install](#install) above), then invoke an agent from your CLI assistant. For example, with GitHub Copilot CLI:

```
@spec-orchestrator I want to add OAuth2 login to the API
```

The orchestrator will guide you through requirements → design → tasks, then you can execute tasks one at a time with `@spec-task-executor`.

---

## Directory Structure

```
agents/
├── spec-orchestrator.json       # Entry-point orchestrator
├── spec-requirements.json       # Requirements phase
├── spec-design.json             # Design phase
├── spec-tasks.json              # Task generation phase
├── spec-task-executor.json      # Task execution
├── spec-bugfix.json             # Bugfix workflow
├── spec-fast-plan.json          # Quick planning workflow
├── requirement-detailer.json    # Requirement refinement utility
└── prompts/
    ├── spec-orchestrator.md
    ├── spec-requirements.md
    ├── spec-design.md
    ├── spec-tasks.md
    ├── spec-task-executor.md
    ├── spec-bugfix.md
    ├── spec-fast-plan.md
    └── requirement-detailer.md
```

---

## Disclaimer

> **Kiro** and **Kiro CLI** are products and trademarks of **Amazon Web Services (AWS)**. This repository is an independent community project that adapts the spec-driven development workflow inspired by the Kiro IDE for use in CLI environments. It is not affiliated with, endorsed by, or officially supported by Amazon Web Services or any of its subsidiaries. All references to Kiro, the Kiro IDE, and related concepts remain the intellectual property of AWS.
>
> Use of this repository is subject to your own discretion. Nothing in this repository should be construed as an official AWS or Kiro product, service, or offering.
