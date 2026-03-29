---
name: langflow-core
description: Expert guide for building Langflow workflows. Use when creating flows programmatically, configuring components (Input, Model, Prompt, Output), managing edges/connections, or understanding Langflow JSON structure.
---

# Langflow Core Concepts

Master guide for building and configuring Langflow workflows via JSON and API.

---

## Tool Categories (Langflow MCP)

Langflow provides native MCP tools for managing and executing flows:

1. **Flow Discovery** → `list_flows`, `get_flow`
2. **Flow Creation** → `create_flow`, `update_flow`
3. **Flow Execution** → `build_flow`, `run_flow`
4. **Component Schema** → `list_components`

---

## Core Components (Detailed Reference: [NODE_REFERENCE.md](NODE_REFERENCE.md))

### 1. Chat Input
- **Type**: `ChatInput`
- **Output Handle**: `ChatInput-output-message`.

### 2. Language Model (e.g., OpenAIModel)
- **Type**: `OpenAIModel`
- **Input Handle**: `OpenAIModel-input-input_prompt`.
- **Output Handle**: `OpenAIModel-output-text`.

### 3. Prompt
- **Type**: `Prompt`
- **Input Handle**: `Prompt-input-input_variables`.
- **Output Handle**: `Prompt-output-prompt`.

### 4. Chat Output
- **Type**: `ChatOutput`
- **Input Handle**: `ChatOutput-input-input_value`.

---

## JSON Structure (Source of Truth)

Every Langflow workflow is represented by a `data` object with `nodes` and `edges`.

### Node Format
```json
{
  "id": "Component_ID",
  "data": {
    "type": "ComponentType",
    "node": {
      "template": {
        "field_name": { "value": "field_value" }
      }
    }
  },
  "position": { "x": 100, "y": 100 }
}
```

### Edge Format
```json
{
  "source": "Source_Node_ID",
  "target": "Target_Node_ID",
  "sourceHandle": "Source_Node_Type-output-handle_name",
  "targetHandle": "Target_Node_Type-input-handle_name"
}
```

---

## Building a Basic Chain (JSON Workflow)

**Chat Input → Prompt → OpenAI Model → Chat Output**

1. **Chat Input** (id: `chat_input`)
2. **Prompt** (id: `prompt_node`)
   - `template`: "Explain this: {topic}"
   - `topic`: connected to `chat_input`
3. **OpenAI Model** (id: `llm_node`)
   - `openai_api_key`: "YOUR_KEY"
4. **Chat Output** (id: `chat_output`)

### Connections (Edges):
- `chat_input` (message) → `prompt_node` (topic)
- `prompt_node` (prompt) → `llm_node` (prompt)
- `llm_node` (text) → `chat_output` (input_value)

---

## Common Mistakes

### Mistake 1: Wrong Handle Names
**Problem**: "Connection failed" error.
**Solution**: Handle names are formatted as `ComponentName-direction-portName`.
- ✅ `ChatInput-output-message`
- ❌ `ChatInput-message`

### Mistake 2: Missing Required Parameters
**Problem**: Component fails to build.
**Solution**: Use `GET /api/v1/all` to check for `required: true` fields in the template.

### Mistake 3: Invalid JSON Structure
**Problem**: "Invalid JSON" error on POST.
**Solution**: Ensure `nodes` and `edges` are inside a `data` object, which is inside the main request body.

---

## Best Practices

### Do
- Build a prototype in the Langflow UI first and export to JSON for inspection.
- Use unique, descriptive IDs for nodes.
- Group related components (e.g., all RAG components) in the visual layout using `position`.
- Use the `x-api-key` header for all production API calls.

### Don't
- Hardcode API keys in the `template` value; use the Langflow secret store or environment variables.
- Try to build 100+ node workflows in one shot; use sub-flows or component modularity.
- Forget to handle the `run_id` when executing asynchronous flows.

---

## Integration with n8n

Langflow workflows can be called from n8n using:
1. **HTTP Request Node**: Calling the Langflow API `/api/v2/workflows`.
2. **MCP Tool**: Exposing the Langflow flow as an MCP tool and calling it from an n8n AI Agent.

*Always utilize the v2 workflow synchronous endpoints for enhanced error handling and timeout protection.*

---

**Ready to build Langflow workflows!** Start by inspecting an exported JSON to understand the specific component handles you need for your task.
