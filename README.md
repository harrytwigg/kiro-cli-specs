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

## Example Flow

```
🤖 spec-orchestrator › Help me create a spec to build a new webserver

I can help you create a spec for a new webserver. To generate a good spec, 
I need a bit more information about what you're looking for:

 1. Language/framework — Do you have a preference? (e.g., Node.js, Go, Rust, FastAPI)
 2. Purpose — What will the server do? (REST API, static file serving, proxy, etc.)
 3. Key features — Any specific requirements? (auth, database, WebSockets, rate limiting)
 4. Deployment target — Where will it run? (AWS, Docker, bare metal, etc.)

Or if you'd like, I can kick off the spec orchestrator agent which will walk 
you through a structured requirements → design → tasks workflow interactively. 
Want me to do that?

[ 💰 Credits: 0.16 • ⏱️ Time: 6s ]
─────────────────────────────────────────────────────────────────────────────────

🤖 spec-orchestrator › Help me create a spec to build a new webserver

I'd be happy to help you build a spec for a new webserver! Before we get 
started, I'd like to confirm:

What type of spec would you like to create?

 1. Build a Feature — Define the webserver as new functionality with full 
                      requirements, design, and implementation tasks.
 2. Quick Plan       — Auto-generate a complete spec with minimal back-and-forth.

Since you're building something new, I'd recommend option 1. 
Which would you prefer?

[ 💰 Credits: 0.03 • ⏱️ Time: 3s ]
─────────────────────────────────────────────────────────────────────────────────

❯ 1

🤖 spec-orchestrator › Great! Now, how would you like to approach building out the spec?

 1. Requirements First — Start by gathering what the webserver needs to do, 
                         then figure out how to build it.
   - Best when: you know what you need but haven't decided on the technical approach yet.

 2. Design First       — Start with the technical architecture, then formalize 
                         requirements from that.
   - Best when: you already have a clear technical vision in mind.

Which approach works better for you?

[ 💰 Credits: 0.02 • ⏱️ Time: 3s ]
─────────────────────────────────────────────────────────────────────────────────
```

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

Run the one-line installer (see [Install](#install) above), then invoke agents via `kiro-cli`:

**Start chat with a specific agent directly:**
```bash
kiro-cli chat --agent spec-orchestrator
kiro-cli chat --agent spec-fast-plan
kiro-cli chat --agent spec-bugfix
```

**Or launch `kiro-cli` and pick an agent interactively:**
```bash
kiro-cli
# then inside the session, type:
/agent
```

**List all installed agents:**
```bash
kiro-cli agent list
```

The orchestrator will guide you through requirements → design → tasks, then you can execute tasks one at a time with `kiro-cli chat --agent spec-task-executor`.

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
>
>The spec files contained in this repository were copied directly from the official AWS Kiro source. This was done because the kiro-cli does not currently include these specific files out of the box.
>
>This repository is an independent, community-driven workaround and is not officially maintained, endorsed, or supported by Amazon Web Services (AWS) or the Kiro development team. All rights, trademarks, and intellectual property regarding Kiro and the Kiro IDE belong entirely to AWS.
