---
name: langflow-validation-expert
description: Expert guide for debugging and validating Langflow flows. Use when a flow fails to build, returns execution errors, or has disconnected components.
---

# Langflow Validation Expert

Master guide for interpreting and fixing Langflow validation and build errors.

---

## The Build-First Protocol

Before running any flow that has been programmatically modified or created, you **must** build it.

1.  **Trigger Build**: Call `build_flow(flow_id: "...")`.
2.  **Monitor Status**: Use `get_build_status(job_id: "...")`.
3.  **Analyze Results**: Look for the `vertex_build_results` in the build status response.

---

## Common Build Errors & Fixes

### 1. "Missing Required Parameter"
*   **Error**: `Component 'OpenAIModel' is missing required field 'api_key'`.
*   **Cause**: You created or updated a node without setting a field marked `required: true` in the component schema.
*   **Fix**: Check `list_components` for that component type and ensure all mandatory fields are in the node's `template`.

### 2. "Disconnected Node" or "Invalid Connection"
*   **Error**: `Edge source 'Node-A' is not connected to any target`.
*   **Cause**: A node exists in the `nodes` array but has no corresponding entries in the `edges` array, or the `sourceHandle`/`targetHandle` names are malformed.
*   **Fix**: Verify handle naming convention: `ComponentName-direction-portName` (e.g., `ChatInput-output-message`).

### 3. "Circular Dependency"
*   **Error**: `Cycle detected in flow graph`.
*   **Cause**: You've connected a component's output back to its own input (directly or through a chain).
*   **Fix**: Langflow graphs are Directed Acyclic Graphs (DAGs). Break the loop. If you need state, use **Memory** components instead of loops.

---

## Execution Errors (Runtime)

### 1. "API Key Invalid" / "Authentication Error"
*   **Fix**: Use the `tweaks` parameter in `run_flow` to inject a fresh API key at runtime if the stored one is failing.

### 2. "Component Timeout"
*   **Cause**: An LLM or Vector Store search is taking too long.
*   **Fix**: Simplify the prompt, reduce the `k` value in Vector Store searches, or increase the timeout in the component settings.

### 3. "Output Not Found"
*   **Error**: `The specified output_component was not reached during execution`.
*   **Fix**: Ensure your flow actually leads to a `Chat Output` or the specific component you designated as the result node.

---

## Debugging Workflow

1.  **Check Logs**: Use `get_logs()` to see system-level errors.
2.  **Inspect Transactions**: Use `get_monitor_transactions(flow_id: "...")` to see the exact data passing through each node.
3.  **Minimal Reproduction**: If a complex flow fails, use `update_flow` to create a simplified 2-node version (e.g., Chat Input -> Chat Output) to verify the environment is working.

---

**Validation is the path to stability.** Never assume a `run_flow` call will work if the `build_flow` status hasn't been confirmed as `SUCCESS`.
