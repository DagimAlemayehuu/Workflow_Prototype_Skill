# Memory Management in Agentic Flows

Guide for integrating persistent state and chat history in n8n AI Agent workflows.

---

## Core Concepts

In agentic workflows, memory allows the model to recall previous turns of a conversation. Without memory, each message is processed in isolation, leading to a "forgetful" experience.

### 1. Window Buffer Memory (Session-Based)
**Best for**: General chat, single-session interactions.
**How it works**: Keeps a sliding window of the last *N* messages in memory.
**Pros**: Simple to set up, no external dependencies.
**Cons**: Data is lost if the workflow execution is cleared or the session ends.

### 2. Redis Chat Memory (Persistence)
**Best for**: Production apps, multi-device sync, long-term memory.
**How it works**: Stores chat history in a Redis database.
**Pros**: Survives workflow restarts, allows cross-device persistence.
**Cons**: Requires a Redis instance.

---

## Implementation Rules

### 🚨 Rule: Always Use Session Keys
To prevent "cross-talk" (where User A sees User B's history), you **must** use a unique identifier as a session key.

**Correct Usage**:
- Webhook trigger: `{{ $json.body.user_id }}` or `{{ $json.body.chat_id }}`
- Production key: `user_{{ $json.body.user_id }}_{{ $now.toFormat('yyyy-MM') }}`

### Configuration: Context Window
For optimal performance on local or small-tier models (like Llama 3 or Gemini Flash):
- **Recommended window**: 5-10 messages.
- **Why**: Larger windows cause "context bloat," increasing latency and token costs without significantly improving reasoning.

---

## Pattern: The Memory Connection

In the n8n canvas, the **AI Agent** node has a specific input port for memory.

1. Drag a **Window Buffer Memory** or **Redis Chat Memory** node.
2. Connect its output to the **Memory** input port of the AI Agent.
3. Configure the **Session ID** using an expression (e.g., `{{ $json.body.session_id || 'default' }}`).

---

## Best Practices

- **Clear Memory**: Provide a way for users to "Reset" the conversation by changing the Session ID.
- **Summary Memory**: For very long conversations, consider **Conversation Summary Memory** to compress old messages into a brief overview.
- **Security**: Never use sensitive data (passwords, PII) directly in Session Keys if they are logged.
