# Langflow Component Discovery Guide

This guide describes the best practices for finding, identifying, and verifying Langflow components and their handles programmatically.

---

## The "Golden Workflow" (Search -> Inspect -> Verify)

If you don't know the exact `type` or `handle` for a node, **do not guess**. Follow this workflow:

### Step 1: Find a Similar Flow
- Call `list_starter_projects()` or `get_basic_examples()`.
- If you find a flow that sounds similar to your goal, call `get_flow({flow_id: "..."})`.
- **Extract Schema**: Look at the `nodes` and `edges` in the returned JSON.
  - `nodes[i].data.type` → The exact string for the component type.
  - `edges[i].sourceHandle` / `targetHandle` → The exact handle names.

### Step 2: Search the Component Store
- If no local examples exist, use `list_store_components({search: "keyword"})`.
- This tool returns a list of components with their metadata. Use the `id` from the results to get more details if needed.

### Step 3: Verify via the Component Schema
- Use `list_components()` and find your target component to see its full schema.
- Check the `template` field for `required: true` fields.
- Check the `outputs` field for available output handles.

---

## Component Identification Tips

| Goal | Component Type |
|------|----------------|
| **Chat Interaction** | `ChatInput`, `ChatOutput` |
| **Language Model** | `LanguageModel` (core) or `OpenAIModel`, `AnthropicModel` (bundled) |
| **Embeddings** | `EmbeddingModel` (core) or `OpenAIEmbeddings` (bundled) |
| **Vector Store** | `AstraDB`, `Chroma`, `Pinecone` |
| **Prompts** | `Prompt` |
| **Data Extraction** | `Parser` |
| **File Processing** | `FileLoader`, `RecursiveCharacterTextSplitter` |

---

## Handle Identification Tips

All handles follow the convention: `{Type}-{direction}-{Port}`

- **direction**: `input` or `output`
- **Port**: The name of the field (e.g., `input_value`, `text`, `prompt`)

**Examples**:
- `ChatInput-output-message`
- `OpenAIModel-input-input_prompt`
- `Parser-input-input_data`

---

## Common Mistakes to Avoid

1.  **Guessing Types**: `OpenAIModel` is common, but it might be `ChatOpenAI` in some environments or versions. Always check `list_components()`.
2.  **Using Short Names**: Edges require the **full** handle name (e.g., `ChatInput-output-message`), not just `message`.
3.  **Missing Required Parameters**: Components will fail to build if any field marked `required: true` in the `template` is missing from the node configuration.
