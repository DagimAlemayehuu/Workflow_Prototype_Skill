# Installation Guide

Complete installation instructions for n8n-skills across all platforms.

---

## Prerequisites

### 1. n8n-mcp MCP Server

You **must** have the n8n-mcp MCP server installed and configured before using these skills.

**Install n8n-mcp**:
```bash
npm install -g n8n-mcp
```

**Configure MCP server** in `.mcp.json`:
```json
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "npx",
      "args": ["n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error",
        "DISABLE_CONSOLE_OUTPUT": "true",
        "N8N_API_URL": "https://your-n8n-instance.com",
        "N8N_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

**Note**: `N8N_API_URL` and `N8N_API_KEY` are optional but enable workflow creation/management tools.

### 2. AI Agent Access

You need one of:
- **AI Coding Agent** (desktop application)
- **AI Assistant** (web interface)
- **AI Agent API** (via SDK)

---

## Installation Methods

### Method 1: AI Coding Agent (Recommended)

**Step 1**: Clone the repository
```bash
git clone https://github.com/[your-username]/workflow-expert-skills.git
cd workflow-expert-skills
```

**Step 2**: Copy skills to AI Coding Agent skills directory

**macOS/Linux**:
```bash
mkdir -p ~/.claude/skills
cp -r skills/* ~/.claude/skills/
```

**Windows**:
```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills"
Copy-Item -Recurse skills\* "$env:USERPROFILE\.claude\skills\"
```

**Step 3**: Reload AI Coding Agent
- Restart AI Coding Agent application
- Skills will activate automatically

---

### Method 2: AI Assistant (Web Interface)

**Step 1**: Download skill folders

Download the repository and navigate to `skills/` directory. You'll need to upload each skill individually.

**Step 2**: Zip each skill folder and upload via your AI Assistant's interface (e.g., Settings → Capabilities → Skills).

---

### Method 3: AI Agent API / SDK

Point your agent's skills configuration to the `skills/` directory in this repository.

---

## Verification

### Test Installation

**1. Check MCP server availability**
```
Ask the AI Agent: "Can you search for the webhook node using n8n-mcp?"
```

**2. Test skill activation**
```
Ask the AI Agent: "How do I access webhook data in n8n expressions?"
```

---

## Troubleshooting

### Skills Not Activating

1. Verify skills are in correct directory (e.g., `~/.claude/skills/`).
2. Reload AI Coding Agent.

### MCP Tools Not Available

1. Verify `.mcp.json` configuration.
2. Restart AI Coding Agent.

---

## 📝 License

MIT License - see [LICENSE](../LICENSE) file for details.
