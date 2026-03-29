---
name: langflow-mcp-tools-expert
description: Expert guide for using Langflow MCP tools effectively. Use when interacting with Langflow directly via an agent to create, build, manage, or run AI workflows. Replaces legacy HTTP REST calls.
---

# Langflow MCP Tools Expert

Master guide for using native Langflow MCP server tools to orchestrate and manage AI workflows.

---

## The Golden Rule: Use MCP Tools over Raw HTTP
Langflow provides a complete suite of native MCP tools. **Do not** manually construct `curl` or raw HTTP `POST /api/v1/run` calls if you are an agent equipped with Langflow MCP. Use the tools below.

---

## Core Langflow MCP Tools

### 1. Workflow Discovery & Inspection
*   **`list_flows`**: List all flows. Use pagination (`page`, `size`) or `folder_id` to organize.
*   **`get_flow`**: Retrieves the full schema (`nodes`, `edges`) of a flow by its UUID. Essential for inspecting available handles and components before updating or running.
*   **`list_components`**: See all available Langflow components (e.g., Models, Prompts, Memories) and their required configurations.

### 2. Workflow Creation & Modification
*   **`create_flow`**: Create a new workflow. Pass a `name` and optional `data` (nodes and edges). Start simple, then use `update_flow`.
*   **`update_flow`**: Modify existing flow metadata (name/description) or its internal structure (`data.nodes`, `data.edges`).
*   **`delete_flow`**: Remove a workflow permanently.

### 3. Execution Lifecycle (Critical Flow)
Langflow flows must be *built* (compiled) before they can be run effectively, especially when making structural changes.

**Step A: Build Flow**
*   **`build_flow`**: Compiles the flow graph and validates connections. 
    *   **Crucial Parameter**: `flow_id`.
    *   **Returns**: `job_id`. 
    *   *Always* build after updating the structure!

**Step B: Check Build Status**
*   **`get_build_status`**: Poll this using the `job_id` returned from `build_flow` to ensure compilation succeeded without errors.

**Step C: Run Flow**
*   **`run_flow`**: Execute the compiled flow.
    *   **Developer API**: Enforces the use of `/api/v2/workflows` endpoints for structured responses.
    *   **Crucial Parameters**: `flow_id_or_name`, `input_request`.
    *   **Input Request Format**: 
      ```json
      {
        "input_value": "Your prompt or data",
        "input_type": "chat",
        "output_type": "chat",
        "tweaks": {
           "Component_ID": { "parameter": "value" }
        }
      }
      ```
    *   **Streaming**: Set `stream: true` for real-time LLM token responses.

---

## The "Tweaks" Pattern (Dynamic Configuration)

The `tweaks` object in `run_flow` is your most powerful capability. It allows you to override component configurations *at runtime* without modifying the actual flow structure.

**Pattern**:
```json
"tweaks": {
  "OpenAIModel-id-123": {
    "temperature": 0.2,
    "model_name": "gpt-4o"
  },
  "Prompt-id-456": {
    "template": "You are a specialized agent..."
  }
}
```

---

## Standard Agent Workflow

1.  **Discover**: `list_flows` to find the target flow UUID.
2.  **Inspect**: `get_flow` to understand component IDs (for tweaks) and required inputs.
3.  **Modify (If needed)**: `update_flow` with new nodes/edges.
4.  **Validate**: `build_flow` -> check `get_build_status`.
5.  **Execute**: `run_flow` with `input_value` and necessary `tweaks`.

## Component Discovery (Full Guide: [DISCOVERY_GUIDE.md](DISCOVERY_GUIDE.md))

If you don't know the exact `type` or `handle` for a node, **do not guess**.

1.  **Search Examples**: `list_starter_projects()` or `get_basic_examples()`.
2.  **Inspect Flow**: `get_flow({flow_id: "..."})` on an example.
3.  **Verify Schema**: `list_components()` to find the exact `type`, `template` (fields), and `outputs`.

---

## Best Practices

### Do
*   Use **Tweaks** in `run_flow` to dynamically pass context, keys, or instructions.
*   **Always** call `get_flow` on a similar example before attempting to build a new one from scratch.
*   **Always** call `build_flow` and verify via `get_build_status` if you've modified the flow.
*   Use the [NODE_REFERENCE.md](../core/NODE_REFERENCE.md) for common handle patterns.

### Don't
*   **Guess component types**. `OpenAIModel` is common, but it might be `ChatOpenAI` in some versions.
*   **Guess handle names**. They are almost always `{Type}-{direction}-{Field}`.
*   Execute raw HTTP requests to the Langflow API.
