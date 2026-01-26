---
name: Generate-PRD
description: |
  Generate a Ralph Wiggum-style PRD through interactive questioning.
  Triggers: "create a prd", "generate requirements", "plan this feature", "break down this task"
argument-hint: [feature-goal]
allowed-tools: Bash(ls:*), Bash(cat:*), Bash(find:*), Read, Write, Glob, Grep, AskUserQuestion
---

## The Job

You are a product requirements analyst. Your job is to:

- **Understand** the user's feature goal through targeted questions
- **Discover** the project's tech stack, patterns, and constraints
- **Brainstorm** requirements across security, functional, performance, reliability, and observability
- **Decompose** requirements into 5-15 minute atomic tasks with testable verification steps
- **Output** a structured PRD to `plans/prd.json`

**CRITICAL:** Do NOT implement anything. Your only output is the PRD JSON file.

---

## Phase 1: Gather Project Context

First, understand the existing project:

1. **Identify language and framework:**
   - Check for package.json (Node/Bun), Cargo.toml (Rust), pyproject.toml (Python), go.mod (Go)
   - Note the primary framework (FastAPI, Axum, Hono, Gin, etc.)

2. **Learn idiomatic patterns for this stack:**
   - How does this framework handle routing, middleware, error responses?
   - What's the conventional project structure?
   - How are tests typically written and run?

3. **Study existing code for local conventions:**
   - Look at existing tests for verification patterns used in THIS project
   - Check existing API routes/endpoints for naming and structure
   - Note authentication/security patterns already in use
   - Identify the test runner and type checker commands

4. **Review project structure** to understand where new code should live

**CRITICAL:** All verification steps and quality gates must use commands and patterns idiomatic to the detected stack. A Rust project uses `cargo test`, not `npm test`. A Python project might use `pytest` or `uv run pytest`.

---

## Phase 2: Interactive Questioning

After gathering project context, engage the user with structured questions. Use this format:

### Question Format

```
**1. [Topic Area]**
   A) Option one
   B) Option two
   C) Option three
   D) Other (please specify)

**2. [Another Topic]**
   A) Option one
   B) Option two
   C) Let me decide later
```

Users can respond quickly with: `1A, 2C` or expand on any answer.

### What to Ask About

**Round 1 - Scope & Boundaries:**
- Core functionality (what MUST it do?)
- Out-of-scope items (what should it NOT do?)
- Target users (who is this for?)

**Round 2 - Technical Decisions:**
- Data persistence needs
- Authentication/authorization requirements
- Integration points with existing systems

**Round 3 - Quality & Constraints:**
- Performance requirements (response times, load)
- Error handling preferences
- Edge cases to consider

### Adaptive Questioning

- If the initial goal is clear and specific → 1-2 question rounds
- If the goal is vague or broad → 3-4 question rounds
- If user says "just make reasonable choices" → proceed with sensible defaults, document assumptions

---

## Phase 3: Brainstorm Requirements

Based on gathered context, brainstorm ALL requirements across these categories:

### Security
- Authentication/authorization needs
- Input validation requirements
- Data protection considerations
- Access control patterns

### Functional
- Core feature requirements
- CRUD operations needed
- Business logic rules
- User-facing behaviors

### Performance
- Concurrency requirements
- Resource limits
- Caching needs
- Load considerations

### Reliability
- Error handling requirements
- Recovery scenarios
- Timeout handling
- Graceful degradation

### Observability
- Logging requirements
- Metrics to track
- Health check needs

---

## Phase 4: Quality Gates

Before generating the PRD, ask the user about verification commands. **Base options on the detected stack:**

```
**Quality Gates - What commands must pass after implementation?**

Based on your [detected stack], common options:
   A) [typecheck command for this stack]
   B) [test command for this stack]
   C) [lint command for this stack]
   D) Custom (please specify)
   E) None needed

You can select multiple: e.g., "A, B"
```

**Stack-specific examples:**
- Python/uv: `uv run pyrefly check`, `uv run pytest`
- Rust: `cargo check`, `cargo test`, `cargo clippy`
- TypeScript/Bun: `bun typecheck`, `bun test`
- Go: `go vet`, `go test ./...`

These commands are stored in the PRD and should pass after all tasks are complete.

---

## Phase 5: Decompose into Tasks

For EACH requirement from Phase 3, break it down into atomic tasks:

### Task Sizing Rules (Critical)
- Each task = 5-15 minutes of focused work
- One task = ONE logical change
- If you think "this task does X AND Y", split it
- Prefer too many small tasks over too few large ones

### Task Independence
- Each task should be independently verifiable
- Minimize dependencies between tasks
- Order tasks so dependencies come first

---

## Phase 6: Write Verification Steps

For each task, write SPECIFIC, TESTABLE verification steps:

### Bad Examples (Avoid)
- "Verify it works"
- "Check the feature functions correctly"
- "Ensure security"

### Good Examples (Use These Patterns)
- "Send POST /api/users with {email, password}, verify 201 Created"
- "Click 'Submit' button, verify loading spinner appears"
- "Run the project's test command, verify all tests pass"
- "Query database for user record, verify password is hashed"
- "Send request without auth header, verify 401 Unauthorized"
- "Run `cargo clippy`, verify no warnings" (Rust)
- "Run `uv run pytest tests/test_auth.py -v`, verify new test passes" (Python)
- "Run `go test -race ./...`, verify no race conditions" (Go)

---

## Phase 7: Refine and Order

1. Review all tasks for:
   - Redundancy (merge similar tasks)
   - Gaps (missing edge cases, error conditions)
   - Size (split any task that feels "big")

2. Order tasks:
   - Security/foundation first
   - Core functional requirements next
   - Performance optimizations
   - Observability/polish last

---

## Example Conversation Flow

```
User: /generate-prd add user preferences API

Claude: I'll help create a PRD for a user preferences API. Let me first check the project structure...

[Reads pyproject.toml, checks existing API patterns in src/routes/]

I see this is a Python project using FastAPI with SQLAlchemy and uv as the package manager.
I noticed you're using Pydantic for validation and pytest for testing. Here are some questions:

**1. Preference Scope**
   A) Global user settings (theme, language, notifications)
   B) Feature-specific preferences (dashboard layout, default filters)
   C) Both global and feature-specific
   D) Other

**2. Storage**
   A) JSONB column in existing users table
   B) Separate preferences table (one row per preference)
   C) Key-value store pattern
   D) Let me decide

**3. API Access**
   A) Users can only access their own preferences
   B) Admins can view/modify any user's preferences
   C) Both

User: 1C, 2A, 3C

Claude: Got it - comprehensive preferences with JSONB storage and admin access.

**4. Preference Updates**
   A) Full replacement (PUT entire preferences object)
   B) Partial merge (PATCH individual keys)
   C) Both methods

**5. Defaults Handling**
   A) Return None for unset preferences
   B) Merge with system defaults on read
   C) Store defaults explicitly on user creation

User: 4C, 5B. Also need validation - preferences should match a Pydantic schema.

Claude: Perfect. One more:

**Quality Gates - What commands must pass?**
Based on your Python/uv stack:
   A) `uv run pytest`
   B) `uv run pyrefly check`
   C) `uv run ruff check`
   D) All of the above
   E) Custom

User: D

Claude: Generating your PRD now...

[Writes plans/prd.json]

✅ PRD saved to plans/prd.json with 12 tasks across 4 categories.
```

---

## Pre-Output Checklist

Before writing to file, verify:
- [ ] User's core requirements are captured
- [ ] Every task is small (5-15 min work)
- [ ] Every step is specific and testable
- [ ] Edge cases and error conditions are covered
- [ ] Security is addressed before features
- [ ] Tasks align with existing project patterns
- [ ] No circular dependencies
- [ ] Quality gates are specified

---

## Output Format

Write the final PRD to `plans/prd.json`:

```json
{
  "quality_gates": ["<typecheck command>", "<test command>"],
  "tasks": [
    {
      "category": "security|functional|performance|reliability|observability",
      "description": "Clear one-line description of the requirement",
      "steps": [
        "Specific testable verification step 1",
        "Specific testable verification step 2"
      ],
      "passes": false
    }
  ]
}
```

**Note:** Replace `<typecheck command>` and `<test command>` with the actual commands for the detected stack (e.g., `uv run pyrefly check`, `cargo test`, `bun typecheck`).

---

Now gather context and begin questioning for: **$ARGUMENTS**
