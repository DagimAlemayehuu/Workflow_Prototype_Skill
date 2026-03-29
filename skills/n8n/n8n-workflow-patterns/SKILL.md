---
name: n8n-workflow-patterns
description: Expert guide for building production-ready n8n workflows. Use when designing architectures, connecting nodes, or implementing common patterns like Webhook Processing, HTTP API Integration, Database Sync, AI Agents, and Scheduled Tasks.
---

# n8n Workflow Patterns

Master guide for proven architectural patterns in n8n.

---

## Pattern 1: Webhook Processor (The "Ingest & Respond" Pattern)

**Use case**: Receive data from a 3rd party (e.g., Typeform, GitHub, Custom App), process it, and send an immediate response.

### 1. Webhook Trigger
```json
{
  "parameters": {
    "path": "your-endpoint-path",
    "httpMethod": "POST",
    "responseMode": "responseNode"
  },
  "type": "n8n-nodes-base.webhook",
  "typeVersion": 1
}
```

### 2. Processing (Logic)
- Connect nodes like **Filter**, **Set**, or **Code** to transform the incoming `$json.body`.

### 3. Respond to Webhook
```json
{
  "parameters": {
    "respondWith": "json",
    "responseBody": "{\n  \"status\": \"success\",\n  \"message\": \"Data received\"\n}",
    "options": {}
  },
  "type": "n8n-nodes-base.respondToWebhook",
  "typeVersion": 1
}
```

---

## Pattern 2: HTTP API Integration (The "External Engine" Pattern)

**Use case**: Call external REST APIs (like Langflow) to perform specialized tasks.

### HTTP Request Configuration
```json
{
  "parameters": {
    "method": "POST",
    "url": "https://api.example.com/v1/run",
    "sendBody": true,
    "specifyBody": "json",
    "jsonBody": "={\n  \"input_value\": \"{{ $json.query }}\",\n  \"api_key\": \"{{ $credentials.apiKey }}\"\n}",
    "sendHeaders": true,
    "specifyHeaders": "json",
    "jsonHeaders": "{\n  \"Content-Type\": \"application/json\"\n}"
  },
  "type": "n8n-nodes-base.httpRequest",
  "typeVersion": 4.1
}
```

---

## Pattern 3: AI Agent Orchestration

**Use case**: Using the AI Agent node for reasoning and tool use.

### AI Agent Node
```json
{
  "parameters": {
    "options": {
      "systemMessage": "You are a helpful assistant..."
    }
  },
  "type": "@n8n/n8n-nodes-langchain.agent",
  "typeVersion": 3.1
}
```
**Connections**: 
- Input: **Chat Trigger** or **Webhook**.
- Output: **OpenAI Chat Model**, **Window Buffer Memory**, and various **Tools** (Calculator, Wikipedia, etc.).

---

## Golden Rules for "Perfect" Workflows

### 1. Webhook Data Nesting
- ✅ Always use `$json.body` to access data from a Webhook node.
- ❌ Do not use `$json` directly (it will be undefined).

### 2. Error Handling
- Use the **Error Trigger** node to catch failures globally.
- Enable **Continue on Fail** for non-critical nodes.

### 3. Efficiency
- Use **Code** nodes for complex logic instead of chaining 10+ simple nodes.
- Use **Wait** nodes for rate-limited APIs.

---

**Patterns ready!** Use these verified JSON structures to build reliable, production-ready workflows.
