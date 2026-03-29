# Langflow Common Node Reference

This document provides exact node types and handle names for building common Langflow workflows.

---

## 1. Input / Output

### Chat Input
- **Type**: `ChatInput`
- **Handles**:
  - `output`: `ChatInput-output-message`
- **Parameters**: `input_value`, `sender`, `sender_name`.

### Chat Output
- **Type**: `ChatOutput`
- **Handles**:
  - `input`: `ChatOutput-input-input_value`
- **Parameters**: `input_value`, `sender`, `sender_name`.

---

## 2. Models (LLMs)

### OpenAI Model
- **Type**: `OpenAIModel`
- **Handles**:
  - `input`: `OpenAIModel-input-input_prompt`
  - `output`: `OpenAIModel-output-text`
- **Parameters**: `model_name` (e.g. `gpt-4o`), `temperature`.

### Anthropic Model
- **Type**: `AnthropicModel`
- **Handles**:
  - `input`: `AnthropicModel-input-input_prompt`
  - `output`: `AnthropicModel-output-text`
- **Parameters**: `model_name` (e.g. `claude-3-5-sonnet`).

---

## 3. Prompts

### Prompt Component
- **Type**: `Prompt`
- **Handles**:
  - `input`: `Prompt-input-input_variables`
  - `output`: `Prompt-output-prompt`
- **Dynamic Handles**: Every `{variable}` in the `template` creates an input handle named `Prompt-input-{variable}`.

---

## 4. RAG (Retrieval-Augmented Generation)

### OpenAI Embeddings
- **Type**: `OpenAIEmbeddings`
- **Handles**:
  - `output`: `OpenAIEmbeddings-output-embeddings`
- **Parameters**: None (Handled globally).

### Chroma Vector Store
- **Type**: `Chroma`
- **Handles**:
  - `input`: `Chroma-input-embeddings` (Connect to `OpenAIEmbeddings-output-embeddings`)
  - `input`: `Chroma-input-documents` (Connect to `TextSplitter-output-chunks`)
  - `output`: `Chroma-output-vector_store`
- **Parameters**: `collection_name`, `persist_directory`.

### File Loader
- **Type**: `FileLoader`
- **Handles**:
  - `output`: `FileLoader-output-data`
- **Parameters**: `path` (file path).

### Text Splitter
- **Type**: `RecursiveCharacterTextSplitter`
- **Handles**:
  - `input`: `RecursiveCharacterTextSplitter-input-data` (Connect to `FileLoader-output-data`)
  - `output`: `RecursiveCharacterTextSplitter-output-chunks`
- **Parameters**: `chunk_size`, `chunk_overlap`.

---

## 5. Memory

### Window Memory
- **Type**: `WindowMemory`
- **Handles**:
  - `output`: `WindowMemory-output-history`
- **Parameters**: `window_size`, `session_id`.

---

## Handle Naming Convention (CRITICAL)

All handles follow the format:
`{ComponentType}-{direction}-{portName}`

- **direction**: `input` or `output`.
- **portName**: The name of the field (e.g. `message`, `text`, `prompt`).

**Example**:
`ChatInput-output-message`
`OpenAIModel-input-input_prompt`

---

## Discovery Pattern

If a node type or handle is unknown, use the following sequence:

1.  **Search Store**: `list_store_components({search: "keyword"})`
2.  **Check Starter Projects**: `list_starter_projects()`
3.  **Inspect Example**: `get_basic_examples()`
4.  **Verify Schema**: `list_components()` and look for the `template` and `outputs` fields.
