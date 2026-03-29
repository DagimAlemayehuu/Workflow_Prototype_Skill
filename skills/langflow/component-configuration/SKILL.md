---
name: langflow-component-configuration
description: Expert guide for configuring specific Langflow components. Use when setting up LLMs, Vector Stores, Embeddings, and Prompt templates.
---

# Langflow Component Configuration

Master guide for setting the correct parameters for Langflow's most important components.

---

## 1. LLM Components (OpenAI, Anthropic, Ollama)

**Common IDs**: `OpenAIModel`, `AnthropicModel`, `ChatOllama`.

| Parameter | Recommended Value | Description |
|-----------|-------------------|-------------|
| `model_name` | `gpt-4o`, `claude-3-5-sonnet` | The specific model version. |
| `temperature` | `0.1` (Logic) - `0.7` (Creative) | Controls randomness. |
| `max_tokens` | `2048` | Limit output length to save costs. |

**Global Model Provider Setup**: Model providers for LLMs, embedding models, and agents MUST be configured globally via the Model providers configuration, not within individual component templates.

---

## 2. Vector Stores (Chroma, Pinecone, FAISS)

**Crucial Logic**: Vector stores require an **Embedding Model** as an input.

| Parameter | Requirement |
|-----------|-------------|
| `collection_name` | Unique string for your knowledge base. |
| `persist_directory` | (Chroma) Path to store data. |
| `index_name` | (Pinecone) The target index. |
| `number_of_results` | `4` - `10` | How many documents to retrieve per query. |

---

## 3. Embeddings (OpenAIEmbeddings, HuggingFaceEmbeddings)

**Use case**: Must match the embeddings used during the initial document ingestion.

- **Global Config**: Embedding models MUST be configured globally via Model Providers.
- **HuggingFace**: Can run locally; specify `model_name`.

---

## 4. Prompts (PromptComponent)

The most flexible component. It turns text into a template.

**The Variable Pattern**:
Any word in curly braces `{like_this}` automatically becomes an **input handle** on the node.

*   **Template**: `You are an expert in {topic}. Answer this: {question}`
*   **Handles Created**: `topic`, `question`.
*   **Agent Action**: You must connect edges to *both* of these handles for the prompt to be valid.

---

## 5. Input/Output (ChatInput, ChatOutput)

- **ChatInput**: Usually the start of the flow. Use `input_value` for the user message.
- **ChatOutput**: Usually the end. Connect the LLM text output to its `input_value`.

---

## Configuration Strategy

1.  **Check Schema**: Call `list_components` to get the latest field names (they occasionally change in Langflow updates).
2.  **Use ID-based Tweaks**: When running via `run_flow`, use the **Node ID** (e.g., `OpenAIModel-abc12`) to target specific instances if your flow has multiple models.
3.  **Handle Overrides**: If a user wants to "use a cheaper model," apply a `tweak` for `model_name` rather than modifying the whole flow.
