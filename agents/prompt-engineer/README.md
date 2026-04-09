# Prompt Engineer Agent

Expert prompt optimization for LLMs and AI systems.

---

## Overview

The Prompt Engineer agent is a specialized AI assistant that helps you craft, optimize, and improve prompts for Large Language Models (LLMs) and AI systems. It masters prompt patterns, techniques, and model-specific optimizations.

---

## When to Use This Agent

Use the **Prompt Engineer** agent when you need to:

- ✅ Create effective prompts for AI systems
- ✅ Optimize existing prompts for better performance
- ✅ Build prompts for Claude Code agents, skills, or commands
- ✅ Improve AI feature performance in your applications
- ✅ Design system prompts for chatbots or assistants
- ✅ Debug why an AI system isn't responding as expected
- ✅ Learn prompt engineering best practices

**IMPORTANT:** This agent should be used **PROACTIVELY** when building AI features or agent systems.

---

## Expertise Areas

### 1. Prompt Optimization Techniques
- Few-shot vs zero-shot prompting
- Chain-of-thought reasoning
- Role-playing and perspective setting
- Output format specification
- Constraint and boundary setting

### 2. Advanced Techniques
- Constitutional AI principles
- Recursive prompting
- Tree of thoughts
- Self-consistency checking
- Prompt chaining and pipelines

### 3. Model-Specific Optimization
- **Claude:** Emphasis on helpful, harmless, honest
- **GPT:** Clear structure and examples
- **Open models:** Specific formatting needs
- **Specialized models:** Domain adaptation

---

## How It Works

The agent follows a structured optimization process:

1. **Analyze** the intended use case
2. **Identify** key requirements and constraints
3. **Select** appropriate prompting techniques
4. **Create** initial prompt with clear structure
5. **Test** and iterate based on outputs
6. **Document** effective patterns

---

## Output Format

When you request a prompt, the agent **ALWAYS provides**:

### ✅ The Complete Prompt Text
```
[Full prompt displayed here in a clearly marked section]
```

### ✅ Implementation Notes
- Key techniques used
- Why these choices were made
- Expected outcomes

### ✅ Usage Guidelines
- How to use the prompt
- Example expected outputs
- Performance benchmarks
- Error handling strategies

---

## Example Use Cases

### 1. Creating an AI Agent
```
"Create a prompt for a Marketing Strategy agent that helps
plan campaigns for telehealth brands"
```

### 2. Optimizing an Existing Prompt
```
"Here's my current prompt for code review. It's giving
inconsistent results. Can you optimize it?"
```

### 3. Building a Skill
```
"I need a prompt for a Claude Code skill that generates
financial reports from spreadsheet data"
```

### 4. Debugging AI Behavior
```
"My chatbot keeps ignoring the tone instructions.
Help me fix the system prompt"
```

---

## Common Patterns Used

- **System/User/Assistant structure** - Clear role separation
- **XML tags** - For structured sections
- **Explicit output formats** - JSON, markdown, tables
- **Step-by-step reasoning** - Chain-of-thought
- **Self-evaluation criteria** - Quality checks

---

## Tips for Best Results

1. **Be specific about your use case** - The more context, the better
2. **Describe desired outputs** - Show examples if possible
3. **Mention constraints** - Length limits, tone, format requirements
4. **Specify the target model** - Claude, GPT, etc.
5. **Share existing attempts** - So the agent can improve them

---

## Configuration

**Model:** `opus` (configured for maximum prompt engineering capability)

**Tools:**
- `Read` - Analyze existing prompts from files
- `Write` - Save optimized prompts
- `Edit` - Refine prompts iteratively

---

## Examples of Agent Output

### Example 1: Code Review Prompt

**Request:** "Create a prompt for code review focusing on security"

**Agent Output:**

#### The Prompt
```
You are an expert code reviewer with 10+ years of experience.
Review the provided code focusing on:

1. Security vulnerabilities
2. Performance optimizations
3. Code maintainability
4. Best practices

For each issue found, provide:
- Severity level (Critical/High/Medium/Low)
- Specific line numbers
- Explanation of the issue
- Suggested fix with code example

Format your response as a structured report with clear sections.
```

#### Implementation Notes
- Uses role-playing for expertise establishment
- Provides clear evaluation criteria
- Specifies output format for consistency
- Includes actionable feedback requirements

---

## Related Resources

- [Claude Prompt Engineering Guide](https://docs.anthropic.com/claude/docs/prompt-engineering)
- [Prompt Library](https://docs.anthropic.com/claude/prompt-library)
- [Best Practices](https://docs.anthropic.com/claude/docs/best-practices)

---

## Limitations

- Cannot test prompts in real-time (you'll need to test them yourself)
- Focused on Claude/GPT models primarily
- May need iteration for highly specialized domains

---

**Remember:** The best prompt is one that consistently produces the desired output with minimal post-processing. This agent ALWAYS shows you the complete prompt text, never just describes it!

---

*Agent installed from: claude-code-templates (ai-specialists/prompt-engineer)*