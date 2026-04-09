# Agent Structure Guide

This guide documents the complete structure and requirements for creating production-ready AI agents in the Claude ecosystem. Based on analysis of successful agents like CFO advisor, this guide ensures consistency and quality.

## Directory Structure

Every agent must follow this exact structure:

```
~/.claude/agents/[agent-name]/
├── AGENT.md              # Required: Main agent specification file
├── README.md             # Required: User documentation
├── reference/            # Required: Reference materials directory
│   ├── [agent-name]-responsibilities.md    # Core responsibilities guide
│   ├── [sector]-guide.md                   # Sector-specific guide (if applicable)
│   └── [additional-references].md          # Additional domain knowledge
├── templates/            # Required: Practical templates directory
│   ├── [template-1].md   # Minimum 3-5 templates
│   ├── [template-2].md   # Based on agent deliverables
│   ├── [template-3].md   # Ready-to-use quality
│   └── ...
└── examples/            # Optional: Examples directory (can be empty initially)
```

## File Requirements

### AGENT.md Specifications

**Minimum Length**: 200+ lines

**Required YAML Frontmatter**:
```yaml
---
name: agent-name          # kebab-case, no spaces
description: One-line description of agent purpose and expertise
model: opus              # Default model (opus recommended)
tools:                   # List of required tools
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebFetch
  - WebSearch
---
```

**Required Sections** (in order):

1. **Agent Title & Introduction**
   - Clear statement of agent role
   - Brief overview of expertise

2. **Core Identity & Purpose/Expertise**
   - Years of experience (simulated)
   - Credentials and qualifications
   - Areas of deep expertise
   - Unique value proposition

3. **Core Responsibilities** (or Primary Functions)
   - 5-7 macro-functions
   - Detailed description of each
   - How they interconnect

4. **Key Competencies & Skills**
   - Technical expertise
   - Strategic & business acumen
   - Leadership & communication
   - Domain-specific skills

5. **Primary Deliverables**
   - Numbered list (8-12 items)
   - Specific outputs agent can produce
   - Level of detail for each

6. **Sector/Industry Expertise** (if applicable)
   - Industry-specific knowledge
   - Key metrics and KPIs
   - Regulatory considerations
   - Competitive landscape
   - Trends and innovations

7. **Operating Principles**
   - 5-10 guiding principles
   - How agent approaches problems
   - Decision-making framework

8. **Communication Style**
   - Tone and approach
   - How to interact with users
   - Level of formality

9. **Key Frameworks & Tools**
   - Methodologies used
   - Standard frameworks
   - Analysis tools
   - Industry standards

10. **Reference Materials** (optional but recommended)
    - Key standards and regulations
    - Authoritative sources
    - Best practice resources

11. **How to Engage** (or Activation Protocol)
    - Step-by-step engagement process
    - What happens when invoked
    - How agent processes requests

12. **Closing Statement**
    - Ready statement
    - Call to action

### README.md Specifications

**Minimum Length**: 250+ lines

**Required Sections**:

1. **Agent Title**
   - Welcome message
   - One-paragraph overview

2. **What This Agent Does**
   - Bullet list of capabilities
   - Clear value proposition

3. **How to Use This Agent**
   - Via command (`/agent [name]`)
   - Via conversation (examples)

4. **Agent Capabilities**
   - Organized by category
   - Specific abilities
   - Depth of expertise

5. **Reference Materials**
   - Description of `/reference` contents
   - Description of `/templates` contents

6. **Example Use Cases**
   - 3-5 detailed scenarios
   - User input → Agent process → Output
   - Realistic and practical

7. **Expertise Areas**
   - Industries covered
   - Company stages
   - Specific domains
   - Standards and regulations

8. **Agent Personality & Approach**
   - Communication style
   - Operating principles
   - Work methodology

9. **Best Practices for Engagement**
   - For best results tips
   - What users will get
   - How to interact effectively

10. **Technical Foundation**
    - Knowledge sources
    - Methodologies employed
    - Industry standards followed

11. **Limitations & Disclaimers**
    - What agent CAN do
    - What agent CANNOT do
    - Professional judgment required

12. **Support & Feedback**
    - How to get help
    - How to improve agent

13. **Quick Start Examples**
    - 5-10 example prompts
    - Ready to copy/paste

14. **Closing**
    - Final encouragement
    - Attribution

### Reference Files Specifications

**Minimum Files**: 2-3

**Standard Reference Files**:

1. **[agent-name]-responsibilities.md**
   - Detailed breakdown of each responsibility
   - How to execute each function
   - Best practices
   - Common pitfalls
   - 40-100 lines typical

2. **[sector]-guide.md** (if sector-specific)
   - Industry overview
   - Key metrics and KPIs
   - Regulatory landscape
   - Major players
   - Trends and innovations
   - 60-120 lines typical

3. **Additional References** (as needed)
   - Methodology guides
   - Framework documentation
   - Best practices compilation
   - Standards documentation

### Template Files Specifications

**Minimum Files**: 3-5

**Template Requirements**:
- Ready-to-use quality
- Include instructions or guidance
- Based on real deliverables
- Professional formatting
- Practical and actionable

**Common Template Types**:
- Frameworks (SWOT, RACI, etc.)
- Document templates (reports, plans)
- Checklists (evaluation, audit)
- Calculators (ROI, metrics)
- Process guides (step-by-step)
- Assessment tools

**Template Structure**:
```markdown
# [Template Name]

## Purpose
Brief description of what this template is for

## How to Use
Step-by-step instructions

## Template
[The actual template content]

## Example
[Filled example if helpful]

## Notes
Additional guidance or tips
```

## Naming Conventions

### Agent Names
- **Format**: kebab-case (all lowercase, hyphens for spaces)
- **Examples**:
  - `cfo` (not CFO or Cfo)
  - `product-manager` (not ProductManager or Product_Manager)
  - `data-scientist` (not DataScientist)
  - `marketing-strategist` (not Marketing-Strategist)

### File Names
- **Reference files**: `[topic]-[type].md`
  - `cfo-responsibilities.md`
  - `telehealth-sector-guide.md`
- **Template files**: `[descriptive-name]-template.md` or `[name]-guide.md`
  - `budget-template.md`
  - `dcf-valuation-guide.md`
  - `risk-matrix-template.md`

## Content Standards

### Language
- **Documentation**: English (all .md files)
- **Code comments**: English
- **User communication**: Portuguese (Brazilian)

### Tone & Style
- **Professional**: Maintain expert credibility
- **Accessible**: Explain complex concepts clearly
- **Actionable**: Focus on practical application
- **Comprehensive**: Cover topic thoroughly

### Formatting
- **Markdown**: Use proper markdown syntax
- **Headers**: Consistent hierarchy (# ## ###)
- **Lists**: Use bullets for items, numbers for steps
- **Code blocks**: Use ``` for code or examples
- **Emphasis**: Bold for important points

## Quality Checklist

Before an agent is considered complete:

### Structure
- ☐ All required directories exist
- ☐ All required files present
- ☐ Proper naming conventions followed
- ☐ YAML frontmatter valid

### AGENT.md
- ☐ 200+ lines minimum
- ☐ All required sections present
- ☐ Sector expertise included (if applicable)
- ☐ Operating principles defined
- ☐ Activation protocol clear

### README.md
- ☐ 250+ lines minimum
- ☐ Usage instructions clear
- ☐ 3-5 example use cases
- ☐ 5-10 quick start prompts
- ☐ Limitations documented

### Reference Materials
- ☐ Minimum 2 files present
- ☐ Responsibilities guide complete
- ☐ Sector guide included (if applicable)
- ☐ Professional quality throughout

### Templates
- ☐ Minimum 3 files present
- ☐ Ready-to-use quality
- ☐ Instructions included
- ☐ Based on real deliverables

### Overall
- ☐ No placeholder content
- ☐ Consistent formatting
- ☐ Professional tone
- ☐ Immediately usable

## Common Patterns

### For Executive Roles (CFO, CTO, CMO)
- Emphasize strategic thinking
- Include board-level communication
- Focus on leadership and governance
- Add stakeholder management

### For Technical Roles (Engineer, Developer, Architect)
- Detail technical frameworks
- Include code examples where relevant
- Focus on implementation
- Add troubleshooting guides

### For Creative Roles (Designer, Writer, Strategist)
- Emphasize creative process
- Include inspiration sources
- Focus on ideation methods
- Add portfolio examples

### For Analytical Roles (Analyst, Scientist, Researcher)
- Detail methodologies
- Include statistical approaches
- Focus on data integrity
- Add visualization examples

## Version Control

Agents should be treated as living documents:
- Regular updates based on user feedback
- Version tracking in git
- Change documentation in commits
- Continuous improvement mindset

## Integration Points

### With Other Agents
- Agents can reference each other
- Shared templates possible
- Cross-domain expertise

### With Claude Ecosystem
- Follow Claude conventions
- Integrate with existing tools
- Maintain compatibility

## Success Metrics

A successful agent:
- Works immediately after creation
- Requires no additional configuration
- Provides value from first use
- Includes practical deliverables
- Maintains professional quality
- Matches hand-crafted agent standards

---

This guide ensures every agent created meets the highest standards of quality, usability, and comprehensiveness. Follow these specifications to create agents that provide immediate value and professional-grade assistance.