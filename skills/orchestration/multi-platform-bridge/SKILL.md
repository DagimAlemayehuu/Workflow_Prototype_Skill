---
name: multi-platform-bridge
description: Expert guide for orchestrating n8n and Langflow workflows together. Use when an n8n workflow needs to call a Langflow AI engine, or when Langflow agents need to trigger n8n integrations.
---

# Multi-Platform Orchestration (n8n & Langflow)

Master guide for building hybrid workflows that leverage n8n for integrations and Langflow for advanced AI logic.

---

## The Hybrid Architecture

### n8n: The Integrator
- **Strengths**: 800+ nodes (Slack, CRM, Database), Error handling, Loops, Complex logic, Webhooks.
- **Role**: Input ingestion, Data transformation, Multi-service delivery.

### Langflow: The Brain
- **Strengths**: LangChain visual builder, RAG (Retrieval-Augmented Generation), Multi-Agent systems, State management for AI.
- **Role**: AI Reasoning, Document Retrieval, Agentic Task Solving.

---

## Pattern 1: n8n Calls Langflow (AI Engine)

**Workflow**: Webhook (n8n) → API Call → Langflow Agent → Result → Slack (n8n)

### Langflow Setup:
- Ensure the flow has a `Chat Input` and `Chat Output`.
- Flow ID is required (get from URL or `GET /api/v1/flows`).

### n8n Setup:
1. **HTTP Request Node**:
   - **Method**: `POST`
   - **URL**: `http://langflow-server:7860/api/v1/run/{flow_id}`
   - **Headers**:
     - `x-api-key`: `YOUR_LANGFLOW_KEY`
     - `Content-Type`: `application/json`
   - **Body**:
     ```json
     {
       "input_value": "{{ $json.user_message }}",
       "input_type": "chat",
       "output_type": "chat",
       "tweaks": {
         "OpenAIModel-id": {
           "temperature": 0.5
         }
       }
     }
     ```

### Why use this?
- Offload complex AI reasoning to Langflow while using n8n for easy connections to 400+ SaaS apps.

---

## Pattern 2: Langflow Uses n8n as a Tool (MCP)

**Workflow**: Langflow Agent → MCP Client → n8n Tool → Search Database → Result → Langflow Agent

### n8n Setup:
- Use `n8n-mcp` to expose specific n8n workflows as tools.
- Each n8n workflow must have a `Webhook Trigger` or `Manual Trigger`.

### Langflow Setup:
1. **MCP Tool Component**:
   - **Mode**: `HTTP/SSE`
   - **URL**: `http://n8n-server:5678/api/v1/mcp/streamable`
2. **Agent Component**:
   - Connect the `MCP Tool` output to the `Tools` input.

### Why use this?
- Give your Langflow AI agent "hands" to perform actions in n8n (e.g., "Create a Trello card" or "Query PostgreSQL").

---

## Decision Matrix: n8n vs. Langflow

| Feature | Use n8n | Use Langflow |
|---------|---------|--------------|
| API Integrations | ✅ Superior (800+) | ❌ Limited |
| AI Agent Orchestration | ❌ Basic | ✅ Superior (LangChain native) |
| Data Transformation | ✅ Visual/JS/Python | ❌ Limited |
| RAG / Vector Stores | ❌ Limited (basic) | ✅ Native & Deep |
| Long-running Workflows | ✅ Excellent | ❌ Limited state |
| Rapid AI Prototyping | ❌ Slow | ✅ Very Fast |

---

## Best Practices

### Do
- Use n8n for **Webhooks** and **Authentication**; it handles rate limits and retries better.
- Use Langflow for **Prompt Engineering**; the visual builder is faster for refining AI behavior.
- Use `tweaks` in the Langflow API to override parameters (like models or temperatures) dynamically from n8n.
- Standardize on JSON for all data passed between platforms.

### Don't
- Duplicate logic; if n8n can transform the data, don't build a complex transformation chain in Langflow.
- Use n8n for long LLM context management; Langflow's `Memory` components are more robust for this.

---

## Unified Validation

When building hybrid flows, validate in steps:
1. Validate n8n connection to Langflow API.
2. Validate Langflow's internal component logic.
3. Validate the final end-to-end response in n8n.

---

**Bridge established!** Start by calling a Langflow flow from n8n to see the power of hybrid automation.
