---
name: langflow-variables-state
description: Expert guide for managing global variables, credentials, and conversation state in Langflow.
---

# Langflow Variables & State

Master guide for handling data that persists across flows and sessions.

---

## 1. Global Variables

Global variables allow you to share generic configuration strings or custom secrets across multiple flows without hardcoding them.

**Distinction: Global Variables vs. Global Providers**:
- **Global Variables**: Used for custom strings, generic secrets, and custom metadata.
- **Global Model Providers**: Native LLM authentication (OpenAI, Anthropic, etc.) MUST strictly utilize the Langflow 1.8 Global Model Provider setup. This ensures seamless routing and provider-specific optimizations (e.g., using the LiteLLM bundle).

**Tools**:
- `list_variables`: See all available keys.
- `create_variable`: Add a new secret or config.
- `update_variable`: Update a value (e.g., rotating an API key).

**Usage in Components**:
Inside a node's template, you can often reference a variable by its name. Langflow will automatically look up the value in the variable store.

---

## 2. Conversation Memory (State)

To make an AI agent "remember" previous messages, you must include a Memory component.

### Patterns:
- **Chat Memory**: Stores the history in the local Langflow database.
- **Zep/Redis Memory**: Stores history in external databases for high-scale production.

### Essential Parameter: `session_id`
*   When executing `run_flow`, you **must** pass a `session_id` (e.g., `user_123_chat_456`).
*   The Memory component uses this ID to retrieve the correct message history for that specific user.
*   **Agent Tip**: If the user asks "What did I just say?", ensure you are using the same `session_id` as the previous turn.

---

## 3. The Tweaks vs. Variables Choice

| Feature | Use Global Variables | Use Tweaks (`run_flow`) |
|---------|----------------------|-------------------------|
| **Longevity** | Permanent | Per-request |
| **Security** | Encrypted in DB | Passed in transit |
| **Use Case** | API Keys, DB URLs | User Preferences, Temporary data |

---

## 4. Cleaning State

If a conversation gets corrupted or off-track:
1.  **Migrate Session**: Use `migrate_monitor_session` to move messages to a fresh ID.
2.  **Delete Messages**: Use `delete_monitor_messages` to clear specific errors or sensitive data from the history.
3.  **New Session**: Simply change the `session_id` in your next `run_flow` call to start with a blank slate.
