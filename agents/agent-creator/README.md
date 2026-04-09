# Agent Creator - Automated AI Agent Builder

Welcome to the Agent Creator, your automated solution for building comprehensive, production-ready AI agents from simple descriptions. This powerful orchestrator transforms basic requirements into fully-documented agents with templates, reference materials, and complete implementation.

## What This Agent Does

The Agent Creator is a master orchestrator that:

- **Automates Agent Development**: Converts simple descriptions into complete agent structures
- **Conducts Deep Research**: Uses prompt-engineer and deep-research agents to build comprehensive profiles
- **Generates Full Documentation**: Creates 200+ line AGENT.md files with complete specifications
- **Produces Practical Templates**: Develops ready-to-use templates based on agent capabilities
- **Ensures Production Quality**: Matches the depth and quality of hand-crafted agents like CFO advisor
- **Provides Sector Expertise**: Adapts agents to specific industries and domains

## How to Use This Agent

### Via Agent Command
```bash
/agent agent-creator
```

### Via Conversation
Simply describe your agent need:
- "I need an agent to help with product management for SaaS"
- "Create a marketing strategist agent for e-commerce"
- "Build me a CTO advisor agent for startups"
- "I need a data scientist agent specializing in healthcare"

## The 6-Step Creation Process

### Step 1: Request Analysis
- Parses your description to understand requirements
- Extracts agent purpose, expertise, and capabilities
- Generates appropriate agent name and metadata

### Step 2: Prompt Engineering
- Invokes prompt-engineer agent
- Creates optimized research prompt for the specific persona
- Ensures comprehensive coverage of all aspects

### Step 3: Deep Research
- Executes deep-research agent with generated prompt
- Gathers qualifications, methodologies, frameworks, best practices
- Identifies sector-specific requirements and standards

### Step 4: Research Processing
- Structures research into organized sections
- Identifies templates and reference materials needed
- Extracts practical deliverables and use cases

### Step 5: Agent Generation
- Creates complete directory structure
- Writes comprehensive AGENT.md (200+ lines)
- Generates user-friendly README.md (250+ lines)
- Produces reference materials and templates

### Step 6: Validation & Delivery
- Verifies all files created correctly
- Validates structure and completeness
- Delivers success report with usage instructions

## Agent Capabilities

### Research & Analysis
- Comprehensive persona research across multiple sources
- Industry best practices identification
- Framework and methodology documentation
- Competitive landscape analysis
- Trend and innovation tracking

### Documentation Generation
- Professional AGENT.md with complete specifications
- User-friendly README.md with examples
- Detailed reference guides
- Sector-specific documentation
- Best practices and standards guides

### Template Creation
- Ready-to-use professional templates
- Framework implementations
- Checklists and assessment tools
- Process guides and workflows
- Example deliverables

### Quality Assurance
- Structure validation
- Completeness checking
- Professional formatting
- Consistency verification
- Immediate usability testing

## Reference Materials

The Agent Creator includes comprehensive reference materials:

### `/reference` Directory
- **agent-structure-guide.md**: Complete guide to agent file structure and requirements
- **workflow-steps.md**: Detailed technical documentation of the 6-step process

### `/templates` Directory
- **agent-md-template.md**: Base template for AGENT.md files
- **readme-template.md**: Base template for README.md documentation

## Example Use Cases

### 1. Creating a Product Manager Agent
**You**: "I need a Product Manager agent specialized in SaaS B2B. Should help with roadmaps, OKRs, user discovery, and PRDs."

**Agent Creator will**:
- Research PM best practices and methodologies
- Identify key frameworks (OKR, RICE, Jobs-to-be-Done)
- Generate templates for roadmaps, PRDs, user stories
- Create sector-specific SaaS B2B guidance
- Deliver complete agent ready for PM tasks

**Result**: `~/.claude/agents/product-manager/` with full structure

### 2. Creating a Marketing Strategist Agent
**You**: "Build a marketing strategist for D2C e-commerce brands, focusing on growth marketing and performance."

**Agent Creator will**:
- Research growth marketing methodologies
- Document performance marketing frameworks
- Create templates for campaigns, funnels, attribution
- Include D2C specific strategies and metrics
- Generate customer acquisition playbooks

**Result**: `~/.claude/agents/marketing-strategist/` with specialized e-commerce focus

### 3. Creating a Data Scientist Agent
**You**: "I need a data scientist agent for predictive analytics in healthcare, including ML models and statistical analysis."

**Agent Creator will**:
- Research healthcare data science requirements
- Document HIPAA compliance considerations
- Create ML pipeline templates
- Include statistical analysis frameworks
- Generate healthcare-specific model templates

**Result**: `~/.claude/agents/data-scientist/` with healthcare specialization

### 4. Creating a Legal Advisor Agent
**You**: "Create a legal advisor for tech startups, focusing on contracts, IP, and compliance."

**Agent Creator will**:
- Research startup legal requirements
- Document standard contract types
- Create IP protection checklists
- Include compliance frameworks
- Generate template agreements

**Result**: `~/.claude/agents/legal-advisor/` with startup focus

### 5. Creating a Sales Engineer Agent
**You**: "Build a sales engineer agent for B2B SaaS, handling demos, POCs, and technical objections."

**Agent Creator will**:
- Research sales engineering best practices
- Document demo methodologies
- Create POC templates and success criteria
- Include objection handling frameworks
- Generate technical evaluation guides

**Result**: `~/.claude/agents/sales-engineer/` with B2B SaaS expertise

## Input Format Guidelines

### Effective Descriptions
To get the best results, include:

1. **Role/Title**: "Product Manager", "Data Scientist", "Marketing Director"
2. **Specialization**: "for SaaS", "in healthcare", "for e-commerce"
3. **Key Responsibilities**: What should the agent help with
4. **Specific Deliverables**: Documents, analyses, or outputs needed
5. **Industry Context**: B2B/B2C, startup/enterprise, sector

### Example Formats

**Detailed**:
```
"I need a Chief Revenue Officer agent for B2B SaaS scale-ups.
Should help with:
- Sales strategy and forecasting
- Revenue operations optimization
- Customer success alignment
- Pricing strategy
- Board reporting on revenue metrics"
```

**Simple**:
```
"Create a UX designer agent for mobile apps"
```

**With Context**:
```
"Build a financial analyst agent. My company is a Series B fintech.
Need help with financial modeling, investor reports, and unit economics."
```

## Generated Agent Structure

Every agent created includes:

```
~/.claude/agents/[agent-name]/
├── AGENT.md                    # Main agent specification (200+ lines)
├── README.md                   # User documentation (250+ lines)
├── reference/                  # Reference materials
│   ├── [agent]-responsibilities.md
│   ├── [sector]-guide.md (if applicable)
│   └── [additional guides].md
├── templates/                  # Practical templates (3-5 files)
│   ├── [framework].md
│   ├── [template].md
│   └── [checklist].md
└── examples/                   # Examples directory
```

## Quality Standards

### Every Agent Includes:
- ✅ Comprehensive role definition and expertise
- ✅ Clear responsibilities and capabilities
- ✅ Industry-specific knowledge when relevant
- ✅ 3-5 practical templates minimum
- ✅ 2-3 reference documents minimum
- ✅ 3-5 detailed use case examples
- ✅ 5-10 quick start prompts
- ✅ Professional documentation throughout

### Documentation Standards:
- AGENT.md: 200+ lines with complete specifications
- README.md: 250+ lines with user guidance
- Templates: Ready-to-use professional quality
- References: Comprehensive domain coverage

## Best Practices

### When Requesting an Agent:

**DO**:
- ✅ Specify the industry or sector if relevant
- ✅ Mention key deliverables or outputs needed
- ✅ Include level of seniority (Senior, Director, VP)
- ✅ Describe your company context if helpful
- ✅ List specific methodologies if required

**DON'T**:
- ❌ Use overly generic descriptions
- ❌ Mix multiple unrelated roles
- ❌ Request illegal or unethical capabilities
- ❌ Expect technical integrations beyond AI

### For Best Results:

1. **Be Specific**: "Financial analyst for Series B SaaS" > "Finance person"
2. **Include Context**: Share your industry, stage, and needs
3. **Mention Deliverables**: What documents/analyses do you need?
4. **Specify Expertise**: Any particular methodologies or frameworks?
5. **State Use Cases**: What will you primarily use the agent for?

## Technical Details

### Orchestration Method
- Uses Task tool to invoke specialized agents
- prompt-engineer agent for prompt optimization
- deep-research agent for comprehensive research
- Coordinates multi-agent workflow automatically

### File Generation
- All documentation in English (token-efficient)
- User communication in Portuguese
- Markdown formatting throughout
- YAML frontmatter for agent configuration

### Research Depth
- 15-25 web searches per agent
- Multiple authoritative sources
- Cross-validation of information
- Sector-specific deep dives

## Limitations & Considerations

### What Agent Creator CAN Do:
✅ Create comprehensive agent specifications
✅ Generate professional documentation
✅ Produce practical templates
✅ Adapt to any professional domain
✅ Include sector-specific expertise
✅ Ensure production-ready quality

### What Agent Creator CANNOT Do:
❌ Create agents for illegal activities
❌ Guarantee 100% accuracy without review
❌ Build technical integrations
❌ Access proprietary methodologies
❌ Create agents outside ethical bounds

### Time Expectations:
- Simple agent: 3-5 minutes
- Complex agent: 5-8 minutes
- Highly specialized: 8-10 minutes

## Support & Improvements

### Getting Help:
- Check generated README.md for agent usage
- Review templates for practical examples
- Consult reference materials for depth
- Test with quick start prompts

### Continuous Improvement:
The Agent Creator improves through:
- User feedback on generated agents
- Successful pattern identification
- Template effectiveness tracking
- Research depth optimization

## Quick Start Prompts

Try these to get started:

```
"Create a Chief Technology Officer agent for early-stage startups"

"I need a Customer Success Manager for B2B SaaS with focus on retention"

"Build a Growth Marketing agent specialized in performance marketing"

"Create a Business Analyst agent for digital transformation projects"

"I need a DevOps Engineer agent focusing on cloud architecture"

"Build a Content Strategist agent for B2B technology companies"

"Create a Compliance Officer agent for fintech regulations"

"I need a Supply Chain Manager agent for e-commerce operations"

"Build a UX Researcher agent for mobile app development"

"Create a Financial Controller agent for scale-ups"
```

## Validation Checklist

Every created agent passes these checks:
- ☐ Valid YAML frontmatter in AGENT.md
- ☐ All required sections present
- ☐ Minimum documentation length met
- ☐ Templates are practical and complete
- ☐ Reference materials comprehensive
- ☐ Examples are specific and actionable
- ☐ Directory structure correct
- ☐ No placeholder content
- ☐ Ready for immediate use

---

## Ready to Create Your Agent?

Simply invoke with `/agent agent-creator` and describe your needs. In minutes, you'll have a production-ready AI agent tailored to your specific requirements, complete with documentation, templates, and reference materials.

**Transform any professional role into an AI assistant. Start building your specialized agent now!**

---

*Agent Creator - Automating excellence in AI agent development. Part of the Claude agent ecosystem.*