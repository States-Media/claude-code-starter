# Agent Creation Workflow - Technical Documentation

This document provides detailed technical documentation for the 6-step automated agent creation workflow. Each step includes implementation details, data flows, validation checks, and error handling.

## Workflow Overview

```
User Input → Step 1: Analysis → Step 2: Prompt Generation → Step 3: Research
→ Step 4: Processing → Step 5: Generation → Step 6: Validation → Delivery
```

## Step 1: Request Analysis & Planning

### Purpose
Parse and understand user requirements to establish agent specifications.

### Input
- User description (natural language)
- Context about intended use
- Any specific requirements

### Processing Logic

```python
# Pseudo-code for request analysis
def analyze_request(user_input):
    # Extract key components
    agent_type = extract_role(user_input)        # "Product Manager", "CFO", etc.
    sector = extract_sector(user_input)          # "SaaS", "Healthcare", etc.
    specialization = extract_specialization(user_input)
    capabilities = extract_capabilities(user_input)
    deliverables = extract_deliverables(user_input)

    # Generate metadata
    agent_name = generate_name(agent_type)       # "product-manager", "cfo"
    description = generate_description(agent_type, sector)

    # Determine requirements
    needs_sector_guide = sector is not None
    template_count = estimate_templates(deliverables)

    return {
        'agent_name': agent_name,
        'agent_type': agent_type,
        'sector': sector,
        'description': description,
        'capabilities': capabilities,
        'deliverables': deliverables,
        'needs_sector_guide': needs_sector_guide,
        'template_count': template_count
    }
```

### Extraction Patterns

**Role Extraction**:
- Look for titles: "Manager", "Officer", "Engineer", "Analyst"
- Professional roles: "CFO", "CTO", "PM", "UX"
- Descriptive roles: "strategist", "advisor", "consultant"

**Sector Extraction**:
- Industries: "healthcare", "finance", "retail", "manufacturing"
- Market types: "B2B", "B2C", "D2C", "marketplace"
- Technologies: "SaaS", "mobile", "AI/ML", "blockchain"

**Capability Extraction**:
- Action verbs: "analyze", "create", "optimize", "manage"
- Deliverables: "reports", "dashboards", "models", "strategies"
- Processes: "planning", "forecasting", "debugging", "designing"

### Name Generation Rules

```python
def generate_name(agent_type):
    # Convert to kebab-case
    name = agent_type.lower()
    name = name.replace(' ', '-')
    name = name.replace('_', '-')

    # Handle common abbreviations
    abbreviations = {
        'chief-financial-officer': 'cfo',
        'chief-technology-officer': 'cto',
        'chief-marketing-officer': 'cmo',
        'product-manager': 'product-manager',
        'user-experience': 'ux',
        'user-interface': 'ui'
    }

    if name in abbreviations:
        return abbreviations[name]
    return name
```

### Validation Checks
- Agent name doesn't already exist
- Description is meaningful (not empty or too generic)
- At least one capability identified
- Request is ethical and appropriate

### Output
```json
{
    "agent_name": "product-manager",
    "agent_type": "Product Manager",
    "sector": "SaaS B2B",
    "description": "Product management expert for B2B SaaS...",
    "capabilities": ["roadmap creation", "OKR setting", "user research"],
    "deliverables": ["PRDs", "roadmaps", "user stories"],
    "needs_sector_guide": true,
    "estimated_templates": 4
}
```

## Step 2: Research Prompt Generation

### Purpose
Create an optimized research prompt using the prompt-engineer agent.

### Input
- Parsed requirements from Step 1
- Agent type and sector
- Capabilities and deliverables list

### Task Tool Invocation

```python
def generate_research_prompt(requirements):
    task_prompt = f"""
    Act as the prompt-engineer agent. Create a comprehensive research prompt for
    developing a complete {requirements['agent_type']} agent profile.

    Context:
    - Role: {requirements['agent_type']}
    - Sector: {requirements['sector'] or 'General'}
    - Key Capabilities: {', '.join(requirements['capabilities'])}
    - Deliverables: {', '.join(requirements['deliverables'])}

    The research prompt should request:
    1. Complete professional profile (education, experience, certifications)
    2. Core responsibilities and functions (5-7 major areas)
    3. Key competencies and skills (technical and soft)
    4. Industry-standard methodologies and frameworks
    5. Common deliverables and outputs
    6. Best practice sources and authoritative references
    7. Sector-specific requirements (regulations, standards, metrics)
    8. Modern trends and emerging capabilities
    9. Typical use cases and scenarios
    10. Tools and technologies used

    Create a detailed, specific prompt that will yield comprehensive research results.
    """

    return invoke_task(
        subagent_type="general-purpose",
        description="Generate research prompt",
        prompt=task_prompt
    )
```

### Expected Output Format

The prompt-engineer should return a structured research prompt like:

```
Research the complete profile of a Senior [Agent Type] with expertise in [Sector].

Investigate and document:

PROFESSIONAL PROFILE:
- Educational background typically required
- Years and types of experience needed
- Professional certifications and credentials
- Career progression path

CORE RESPONSIBILITIES:
- Primary job functions and duties
- Strategic vs operational responsibilities
- Stakeholder management requirements
- Reporting and communication duties

[... continue for all 10 areas ...]
```

### Validation
- Prompt covers all required areas
- Specific to the agent type
- Includes sector-specific aspects
- Actionable and clear

## Step 3: Deep Research Execution

### Purpose
Execute comprehensive research using the deep-research agent.

### Input
- Generated research prompt from Step 2
- Target output file path

### Task Tool Invocation

```python
def execute_deep_research(research_prompt, agent_name):
    output_file = f"/Users/denismarinho/{agent_name}-research.md"

    task_prompt = f"""
    Act as the deep-research agent. Execute the following research request:

    {research_prompt}

    Requirements:
    - Conduct comprehensive research using web searches
    - Validate findings across multiple sources
    - Include specific examples and real-world applications
    - Document frameworks, methodologies, and best practices
    - Identify 3-5 practical templates needed
    - List authoritative sources and references

    Save the complete research report to: {output_file}

    The research should be thorough enough to build a complete agent profile.
    """

    return invoke_task(
        subagent_type="general-purpose",
        description="Research agent profile",
        prompt=task_prompt
    )
```

### Research Depth Requirements
- Minimum 15-25 web searches
- Cross-reference at least 10 sources
- Include recent information (last 2 years)
- Cover both theory and practice
- Identify specific tools and frameworks

### Expected Research Sections
1. Executive Summary
2. Professional Profile
3. Core Responsibilities
4. Required Competencies
5. Methodologies & Frameworks
6. Standard Deliverables
7. Industry Best Practices
8. Sector-Specific Knowledge
9. Tools & Technologies
10. Emerging Trends
11. Template Recommendations
12. Reference Sources

### Output File Format
- Markdown format
- 500+ lines typical
- Structured with clear sections
- Includes citations and sources

## Step 4: Research Processing & Structuring

### Purpose
Transform raw research into structured agent components.

### Input
- Research file from Step 3
- Original requirements

### Processing Logic

```python
def process_research(research_file, requirements):
    # Read research content
    research_content = read_file(research_file)

    # Parse into sections
    sections = {
        'identity': extract_identity_section(research_content),
        'responsibilities': extract_responsibilities(research_content),
        'competencies': extract_competencies(research_content),
        'frameworks': extract_frameworks(research_content),
        'deliverables': extract_deliverables_section(research_content),
        'sector_expertise': extract_sector_info(research_content),
        'principles': extract_principles(research_content),
        'communication': extract_communication_style(research_content),
        'references': extract_references(research_content)
    }

    # Identify templates needed
    templates = identify_templates(research_content, requirements)

    # Identify reference docs needed
    reference_docs = identify_reference_docs(research_content, requirements)

    # Extract use cases
    use_cases = extract_use_cases(research_content)

    # Extract quick start examples
    quick_starts = extract_quick_starts(research_content, requirements)

    return {
        'sections': sections,
        'templates': templates,
        'reference_docs': reference_docs,
        'use_cases': use_cases,
        'quick_starts': quick_starts
    }
```

### Section Extraction Patterns

**Identity Extraction**:
- Look for: qualifications, experience levels, credentials
- Format as: years of experience, areas of expertise, unique value

**Responsibilities Extraction**:
- Identify 5-7 major function areas
- Group related duties
- Prioritize by importance

**Frameworks Extraction**:
- Standard methodologies mentioned
- Industry frameworks
- Analysis tools and techniques

**Templates Identification**:
- Documents mentioned frequently
- Standard deliverables
- Assessment tools
- Frameworks that can be templated

### Structuring Rules
- Group related information
- Maintain hierarchy
- Preserve specific examples
- Keep actionable elements

## Step 5: Complete Agent Generation

### Purpose
Generate all agent files with complete content.

### Input
- Processed research from Step 4
- Original requirements
- Template and reference lists

### File Generation Process

#### 5.1 Generate AGENT.md

```python
def generate_agent_md(data):
    content = f"""---
name: {data['agent_name']}
description: {data['description']}
model: opus
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebFetch
  - WebSearch
---

# {data['agent_type']} Agent

{generate_introduction(data)}

## Core Identity & Expertise

{data['sections']['identity']}

## Core Responsibilities

{format_responsibilities(data['sections']['responsibilities'])}

## Key Competencies & Skills

{format_competencies(data['sections']['competencies'])}

## Primary Deliverables

{format_deliverables(data['sections']['deliverables'])}

{generate_sector_section(data) if data['sector'] else ''}

## Operating Principles

{data['sections']['principles']}

## Communication Style

{data['sections']['communication']}

## Key Frameworks & Tools

{format_frameworks(data['sections']['frameworks'])}

## Reference Materials

{format_references(data['sections']['references'])}

## How to Engage

{generate_engagement_protocol(data)}

---

**Your {data['agent_type']} is ready. {generate_closing(data)}**
"""

    write_file(f"~/.claude/agents/{data['agent_name']}/AGENT.md", content)
```

#### 5.2 Generate README.md

```python
def generate_readme_md(data):
    content = f"""# {data['agent_type']} Agent

{generate_welcome_message(data)}

## What This Agent Does

{generate_capabilities_list(data)}

## How to Use This Agent

### Via Agent Command
```
/agent {data['agent_name']}
```

### Via Conversation
{generate_conversation_examples(data)}

## Agent Capabilities

{organize_capabilities_by_category(data)}

## Reference Materials

{describe_reference_contents(data)}

## Example Use Cases

{format_use_cases(data['use_cases'])}

## Expertise Areas

{format_expertise_areas(data)}

## Best Practices for Engagement

{generate_best_practices(data)}

## Technical Foundation

{format_technical_foundation(data)}

## Limitations & Disclaimers

{generate_limitations(data)}

## Quick Start Examples

{format_quick_starts(data['quick_starts'])}

---

**{generate_footer(data)}**
"""

    write_file(f"~/.claude/agents/{data['agent_name']}/README.md", content)
```

#### 5.3 Generate Reference Files

```python
def generate_reference_files(data):
    # Responsibilities guide
    responsibilities_content = expand_responsibilities(data['sections']['responsibilities'])
    write_file(
        f"~/.claude/agents/{data['agent_name']}/reference/{data['agent_name']}-responsibilities.md",
        responsibilities_content
    )

    # Sector guide (if applicable)
    if data['sector']:
        sector_content = expand_sector_knowledge(data['sections']['sector_expertise'])
        write_file(
            f"~/.claude/agents/{data['agent_name']}/reference/{data['sector']}-guide.md",
            sector_content
        )

    # Additional references as identified
    for ref_doc in data['reference_docs']:
        generate_reference_doc(ref_doc, data)
```

#### 5.4 Generate Template Files

```python
def generate_template_files(data):
    for template in data['templates']:
        template_content = create_template_content(template, data)
        filename = generate_template_filename(template)
        write_file(
            f"~/.claude/agents/{data['agent_name']}/templates/{filename}",
            template_content
        )
```

### Content Generation Rules
- Use research content as base
- Expand with logical extensions
- Maintain consistency across files
- Ensure practical applicability
- Follow formatting standards

## Step 6: Validation & Delivery

### Purpose
Validate all created files and deliver success report to user.

### Validation Process

```python
def validate_agent_creation(agent_name):
    validation_results = {
        'structure': validate_directory_structure(agent_name),
        'agent_md': validate_agent_md(agent_name),
        'readme_md': validate_readme_md(agent_name),
        'references': validate_reference_files(agent_name),
        'templates': validate_template_files(agent_name),
        'overall': True
    }

    # Check each validation
    for check, result in validation_results.items():
        if not result['passed']:
            validation_results['overall'] = False
            log_validation_error(check, result['errors'])

    return validation_results
```

### Validation Checks

**Directory Structure**:
- All required directories exist
- Correct permissions
- No missing folders

**AGENT.md Validation**:
```python
def validate_agent_md(agent_name):
    file_path = f"~/.claude/agents/{agent_name}/AGENT.md"
    content = read_file(file_path)

    checks = {
        'exists': os.path.exists(file_path),
        'min_length': len(content.split('\n')) >= 200,
        'has_frontmatter': content.startswith('---'),
        'has_sections': all(section in content for section in REQUIRED_SECTIONS),
        'no_placeholders': '[placeholder]' not in content.lower()
    }

    return {
        'passed': all(checks.values()),
        'checks': checks
    }
```

**README.md Validation**:
- Minimum 250 lines
- Has all required sections
- Includes examples
- No placeholder content

**Reference Files Validation**:
- Minimum 2 files exist
- Responsibilities guide present
- Reasonable length (40+ lines each)
- Proper formatting

**Template Files Validation**:
- Minimum 3 files exist
- Each has purpose and instructions
- Practical content (not just headers)
- Ready-to-use format

### Delivery Report Generation

```python
def generate_delivery_report(agent_name, validation_results):
    if validation_results['overall']:
        return f"""
## ✅ Agente Criado com Sucesso!

**Nome do Agente**: {agent_name}
**Localização**: ~/.claude/agents/{agent_name}/

### Arquivos Criados:
- ✓ AGENT.md (especificação principal do agente)
- ✓ README.md (documentação completa para usuário)
- ✓ {count_files('reference')} arquivos de referência
- ✓ {count_files('templates')} templates práticos

### Como Usar:
1. **Via comando**: Digite `/agent {agent_name}`
2. **Via conversa**: Mencione que precisa de ajuda do {format_agent_type(agent_name)}

### Teste Rápido:
Experimente estes prompts:
{generate_test_prompts(agent_name)}

### Próximos Passos:
- Teste o agente com casos reais
- Ajuste templates conforme necessário
- Adicione exemplos na pasta examples/

**Seu agente está pronto para uso imediato!**
"""
    else:
        return generate_error_report(validation_results)
```

## Error Handling

### Common Errors and Recovery

**Research Timeout**:
```python
def handle_research_timeout(agent_name):
    # Break research into smaller chunks
    subtopics = divide_research_topic(agent_name)
    results = []
    for subtopic in subtopics:
        result = execute_research_with_timeout(subtopic, timeout=180)
        results.append(result)
    return combine_research_results(results)
```

**File Write Failures**:
```python
def safe_write_file(path, content):
    try:
        # Ensure directory exists
        os.makedirs(os.path.dirname(path), exist_ok=True)

        # Write with backup
        backup_path = path + '.backup'
        if os.path.exists(path):
            shutil.copy(path, backup_path)

        with open(path, 'w') as f:
            f.write(content)

        # Verify write
        with open(path, 'r') as f:
            if f.read() != content:
                raise ValueError("Content verification failed")

    except Exception as e:
        # Restore backup if exists
        if os.path.exists(backup_path):
            shutil.copy(backup_path, path)
        raise e
```

**Agent Name Conflicts**:
```python
def handle_name_conflict(proposed_name):
    if agent_exists(proposed_name):
        # Generate alternatives
        alternatives = [
            f"{proposed_name}-v2",
            f"{proposed_name}-advanced",
            f"{proposed_name}-specialist"
        ]

        for alt in alternatives:
            if not agent_exists(alt):
                return alt

        # If all alternatives taken, use timestamp
        return f"{proposed_name}-{datetime.now().strftime('%Y%m%d')}"
```

## Performance Optimization

### Parallel Processing
- Execute research searches in parallel when possible
- Generate templates concurrently
- Write files asynchronously

### Caching
- Cache research results for similar requests
- Store common templates for reuse
- Keep reference materials for common sectors

### Token Management
- Summarize research before processing
- Use efficient prompt structures
- Batch similar operations

## Monitoring & Metrics

### Success Metrics
- Time to complete: Target < 5 minutes
- File completeness: 100% required files
- Content quality: No placeholders, meaningful content
- Validation pass rate: > 95%

### Performance Tracking
```python
def track_performance(agent_name, metrics):
    log_entry = {
        'timestamp': datetime.now(),
        'agent_name': agent_name,
        'total_time': metrics['end_time'] - metrics['start_time'],
        'research_time': metrics['research_time'],
        'generation_time': metrics['generation_time'],
        'files_created': metrics['file_count'],
        'validation_passed': metrics['validation_passed']
    }

    append_to_log('~/.claude/agents/agent-creator/metrics.log', log_entry)
```

## Continuous Improvement

### Feedback Loop
1. Collect user feedback on generated agents
2. Identify common patterns in successful agents
3. Update templates based on usage
4. Refine research prompts for better results
5. Optimize file generation based on patterns

### Template Evolution
- Track which templates are used most
- Identify missing template types
- Update based on industry changes
- Add new frameworks as they emerge

---

This technical documentation ensures consistent, high-quality agent creation through the automated workflow. Each step is designed to be robust, efficient, and produce production-ready results.