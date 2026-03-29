---
name: langflow-workflow-patterns
description: Expert guide for building Langflow AI architectures. Use when designing LLM workflows, connecting RAG (Retrieval-Augmented Generation) systems, or implementing Agentic tool-calling patterns.
---

# Langflow Workflow Patterns

Master guide for proven architectural patterns in Langflow.

---

## Pattern 1: Basic Conversational Chain
**Use case**: A simple chatbot that answers questions based on a system prompt.

### Architecture:
1. **Chat Input**: `ChatInput`
   - `ChatInput-output-message` → `LanguageModel-input-input_value`
2. **Language Model**: `LanguageModel`
   - `LanguageModel-output-text` → `ChatOutput-input-input_value`
3. **Chat Output**: `ChatOutput`

---

## Pattern 2: RAG (Retrieval-Augmented Generation)
**Use case**: Answer questions based on a specific knowledge base.

### Architecture:
1. **Chat Input**: `ChatInput`
   - `ChatInput-output-message` → `AstraDB-input-search_query`
2. **OpenAI Embeddings**: `OpenAIEmbeddings`
   - `OpenAIEmbeddings-output-embeddings` → `AstraDB-input-embedding_model`
3. **Vector Store**: `AstraDB`
   - `AstraDB-output-search_results` → `Parser-input-input_data`
4. **Parser**: `Parser`
   - `Parser-output-text` → `Prompt-input-context`
5. **Prompt**: `Prompt`
   - Template: `Context: {context}\nQuestion: {question}`
   - `ChatInput-output-message` → `Prompt-input-question`
   - `Prompt-output-prompt` → `LanguageModel-input-input_value`
6. **Language Model**: `LanguageModel`
   - `LanguageModel-output-text` → `ChatOutput-input-input_value`
7. **Chat Output**: `ChatOutput`

---

## Pattern 3: Multi-Agent Router
**Use case**: Route queries to different specialized agents based on intent.

### Architecture:
1. **Chat Input** -> **Prompt** -> **LLM** -> **Conditional Router**.
2. **Logic**: Use the `If-Else` component or a custom router.
3. **Specialized Agents**: Connect different `Agent` components.

---

## Pattern 4: Agentic Tool Use
**Use case**: An agent that can interact with the real world via tools.

### Architecture:
1. **Chat Input**: `ChatInput`
   - `ChatInput-output-message` → `Agent-input-user_message`
2. **Language Model**: `LanguageModel`
   - Change output type to `Language Model`.
   - `LanguageModel-output-model` → `Agent-input-language_model`
3. **MCP Tool**: `MCPToolComponent`
   - `MCPToolComponent-output-tool` → `Agent-input-tools`
4. **Agent**: `Agent`
   - `Agent-output-text` → `ChatOutput-input-input_value`
5. **Chat Output**: `ChatOutput`

---

## Golden Rules for Langflow Architecture

1. **Keep it modular**: Use the `Sub Flow` component for complex logic.
2. **Handle Names Matter**: Always use `{Type}-{direction}-{Port}`.
3. **Always Build**: Remember that modifying edges or nodes requires calling `build_flow` before execution.
4. **Output Verification**: Terminate your flow with a `Chat Output` or a specific component for predictable results.
