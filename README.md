# workflow-expert-skills

**Expert AI Agent skills for building flawless automation and AI workflows using the n8n-mcp and langflow-mcp servers**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🎯 What is this?

This repository contains **14 complementary AI Agent skills** (7 for n8n, 7 for Langflow) that teach AI assistants how to build production-ready workflows across the world's leading automation and AI orchestration platforms.

### Why These Skills Exist

Building complex workflows programmatically across logic (n8n) and reasoning (Langflow) platforms is the current frontier of AI engineering. Common issues include:
- **Platform Confusion**: Not knowing when to use n8n vs Langflow.
- **Tool Inefficiency**: Using raw API calls when native MCP tools are available.
- **Validation Loops**: Getting stuck in "Fix -> Error -> Fix" cycles.
- **Architectural Debt**: Building brittle, non-scalable patterns.

These skills solve these problems by providing the AI Agent with a high-fidelity "Expert Brain" for both systems.

---

## 📚 The Ultimate Skill Set

### Logic & Integration (n8n)
1. **n8n Expression Syntax**: Core syntax and `$json.body` gotchas.
2. **n8n MCP Tools Expert**: Precision tool selection for searching and editing.
3. **n8n Workflow Patterns**: 5 proven production architectures.
4. **n8n Validation Expert**: Interpreting runtime and build errors.
5. **n8n Node Configuration**: Operation-aware parameter mapping.
6. **n8n Code JavaScript**: High-performance data processing.
7. **n8n Code Python**: Standard library usage and limitations.

### Reasoning & AI (Langflow)
1. **Langflow Core**: JSON structure and handle naming conventions.
2. **Langflow MCP Expert**: Programmatic orchestration via native tools.
3. **Langflow Patterns**: RAG, Multi-Agent, and Tool-use architectures.
4. **Langflow Validation**: Debugging build jobs and execution failures.
5. **Component Configuration**: Deep-dive into LLM and Vector Store settings.
6. **Variables & State**: Global secrets and session-based memory management.
7. **Multi-Platform Bridge**: Orchestrating hybrid (n8n + Langflow) systems.

---

## 🚀 Installation

### Prerequisites

1. **n8n-mcp** server installed and configured.
2. **langflow-mcp** server installed and configured (if using Langflow skills).
3. **AI Agent** access (Claude Code, Gemini CLI, Jules, etc.)
4. `.mcp.json` (or equivalent config) connected to these servers.

### Installation

1. **Clone this repository**
```bash
git clone https://github.com/[your-username]/workflow-expert-skills.git
```

2. **Copy skills to your agent's skills directory**
   - **Claude Code**: `cp -r skills/* ~/.claude/skills/`
   - **Gemini CLI / Jules**: Copy `skills/` to your project's local skills path.

### General MCP Agents

For other MCP-compatible agents, point your agent's skills configuration to the `skills/` directory in this repository. These skills are designed to be compatible with any agent that supports the MCP protocol and skill-based guidance.

---

## 💡 Usage

Skills activate **automatically** when relevant queries are detected:

```
"How do I write n8n expressions?"
→ Activates: n8n Expression Syntax

"Find me a Slack node"
→ Activates: n8n MCP Tools Expert

"Build a webhook workflow"
→ Activates: n8n Workflow Patterns

"Why is validation failing?"
→ Activates: n8n Validation Expert

"How do I configure the HTTP Request node?"
→ Activates: n8n Node Configuration

"How do I access webhook data in a Code node?"
→ Activates: n8n Code JavaScript

"Can I use pandas in Python Code node?"
→ Activates: n8n Code Python
```

### Skills Work Together

When you ask: **"Build and validate a webhook to Slack workflow"**

1. **n8n Workflow Patterns** identifies webhook processing pattern
2. **n8n MCP Tools Expert** searches for webhook and Slack nodes
3. **n8n Node Configuration** guides node setup
4. **n8n Code JavaScript** helps process webhook data with proper .body access
5. **n8n Expression Syntax** helps with data mapping in other nodes
6. **n8n Validation Expert** validates the final workflow

All skills compose seamlessly!

---

## 📖 Documentation

- [Installation Guide](docs/INSTALLATION.md) - Detailed installation for all platforms
- [Usage Guide](docs/USAGE.md) - How to use skills effectively
- [Development Guide](docs/DEVELOPMENT.md) - Contributing and testing
- [MCP Testing Log](docs/MCP_TESTING_LOG.md) - Real tool responses used in skills

---


## 🧪 Testing

Each skill includes 3+ evaluations for quality assurance:

```bash
# Run evaluations (if testing framework available)
npm test

# Or manually test with the AI Agent
claude-code --skill n8n-expression-syntax "Test webhook data access"
```

---

## 🤝 Contributing

Contributions welcome! Please see [DEVELOPMENT.md](docs/DEVELOPMENT.md) for guidelines.

### Development Approach

1. **Evaluation-First**: Write test scenarios before implementation
2. **MCP-Informed**: Test tools, document real responses
3. **Iterative**: Test against evaluations, iterate until 100% pass
4. **Concise**: Keep SKILL.md under 500 lines
5. **Real Examples**: All examples from real templates/tools

---

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 📊 What's Included

- **14** complementary skills that work together
- **525+** n8n nodes supported
- **2,653+** workflow templates for examples
- **10** production-tested Code node patterns
- **Comprehensive** error catalogs and troubleshooting guides

---

**Ready to build flawless automation workflows? Get started now!** 🚀
