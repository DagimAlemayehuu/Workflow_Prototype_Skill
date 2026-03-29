# Langflow Handle Reference

This document provides the exact handle names for connecting Langflow components programmatically.

---

## Handle Naming Convention

All handles follow the format: `{ComponentType}-{direction}-{portName}`

- **direction**: `input` or `output`
- **portName**: The name of the field or port (e.g., `input_value`, `text`, `prompt`)

---

## 1. Core Components

### Chat Input (`ChatInput`)
- **Outputs**:
  - `ChatInput-output-message`: Emits a `Message` object.

### Chat Output (`ChatOutput`)
- **Inputs**:
  - `ChatOutput-input-input_value`: Accepts `Message`, `Data`, or `DataFrame`.

### Language Model (`LanguageModel`)
- **Inputs**:
  - `LanguageModel-input-input_value`: The user prompt/input.
  - `LanguageModel-input-system_message`: System instructions.
- **Outputs**:
  - `LanguageModel-output-text`: Emits a `Message` object (Model Response mode).
  - `LanguageModel-output-model`: Emits a `LanguageModel` object (Language Model mode).

### Prompt Template (`Prompt`)
- **Inputs**:
  - `Prompt-input-template`: The raw template string.
  - `Prompt-input-{variable}`: Dynamic handle for each `{variable}` in the template.
- **Outputs**:
  - `Prompt-output-prompt`: Emits the formatted prompt string.

### Parser (`Parser`)
- **Inputs**:
  - `Parser-input-input_data`: Accepts `Data` or `DataFrame`.
- **Outputs**:
  - `Parser-output-text`: Emits a `Message` object.

---

## 2. Bundled Components (Specific Providers)

### OpenAI (`OpenAIModel`)
- **Inputs**:
  - `OpenAIModel-input-input_prompt`: The prompt for the model.
- **Outputs**:
  - `OpenAIModel-output-text`: Emits a `Message`.
  - `OpenAIModel-output-model`: Emits a `LanguageModel`.

### OpenAI Embeddings (`OpenAIEmbeddings`)
- **Outputs**:
  - `OpenAIEmbeddings-output-embeddings`: Emits an `Embeddings` object.

### Astra DB (`AstraDB`)
- **Inputs**:
  - `AstraDB-input-embedding_model`: Accepts `Embeddings`.
  - `AstraDB-input-ingest_data`: Accepts `Data` or `DataFrame` for writing.
  - `AstraDB-input-search_query`: Accepts `Message` or `string` for searching.
- **Outputs**:
  - `AstraDB-output-search_results`: Emits `Data` or `DataFrame`.

---

## 3. Data Processing

### Split Text (`RecursiveCharacterTextSplitter`)
- **Inputs**:
  - `RecursiveCharacterTextSplitter-input-data`: Accepts `Data` or `DataFrame`.
- **Outputs**:
  - `RecursiveCharacterTextSplitter-output-chunks`: Emits `Data`.

### File Loader (`FileLoader`)
- **Outputs**:
  - `FileLoader-output-data`: Emits `Data`.

---

## Summary of Data Types

| Type | Description | Components |
|------|-------------|------------|
| `Message` | Chat message with metadata | Chat Input, Chat Output, LLM Output |
| `Data` | Generic structured data | File Loader, Parser Input, Vector Store Results |
| `DataFrame` | Tabular data (pandas) | Data Operations, Vector Store Results |
| `LanguageModel` | Configured LLM instance | LLM Output, Agent Input |
| `Embeddings` | Configured Embeddings instance | Embeddings Output, Vector Store Input |
