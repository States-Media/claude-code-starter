#!/usr/bin/env python3
"""
Deep Research Executor
Executes the deep-research agent with the compounding pharmacist research request.
"""

import os
import sys

def main():
    """Execute deep research agent"""

    # Read the research request
    request_file = "/Users/denismarinho/deep-research-request.md"

    if not os.path.exists(request_file):
        print("ERROR: Research request file not found")
        sys.exit(1)

    with open(request_file, 'r') as f:
        research_request = f.read()

    print("=" * 80)
    print("DEEP RESEARCH AGENT - ACTIVATION PROTOCOL")
    print("=" * 80)
    print()
    print("Research Request Loaded:")
    print(f"- File: {request_file}")
    print(f"- Size: {len(research_request)} characters")
    print()
    print("STEP 1: AUTO-DETECT RESEARCH SCOPE")
    print("-" * 80)

    # Auto-detect research scope based on triggers from AGENT.md Phase 1.4
    triggers = {
        "Section Count (8+ sections)": False,
        "Depth Indicators": False,
        "Multiple Domains": False,
        "Template Requirements": False,
        "Estimated Output (>25k tokens)": False
    }

    # Check trigger 1: Section Count
    section_count = research_request.count("### ")
    if section_count >= 8:
        triggers["Section Count (8+ sections)"] = True
        print(f"✓ Trigger 1: Section Count = {section_count} sections (≥8) → YES")
    else:
        print(f"✗ Trigger 1: Section Count = {section_count} sections (<8) → NO")

    # Check trigger 2: Depth Indicators
    depth_keywords = ["comprehensive", "complete", "all aspects", "deep dive", "detailed", "extensive"]
    depth_found = [kw for kw in depth_keywords if kw in research_request.lower()]
    if depth_found:
        triggers["Depth Indicators"] = True
        print(f"✓ Trigger 2: Depth Indicators = {len(depth_found)} found ({', '.join(depth_found[:3])}) → YES")
    else:
        print(f"✗ Trigger 2: Depth Indicators = None found → NO")

    # Check trigger 3: Multiple Domains
    domains = []
    if "regulat" in research_request.lower() or "compliance" in research_request.lower():
        domains.append("Regulatory")
    if "clinical" in research_request.lower() or "pharmacist" in research_request.lower():
        domains.append("Clinical")
    if "technical" in research_request.lower() or "formulation" in research_request.lower():
        domains.append("Technical")
    if "business" in research_request.lower() or "supplier" in research_request.lower():
        domains.append("Business")
    if "quality" in research_request.lower() or "testing" in research_request.lower():
        domains.append("Quality")

    if len(domains) >= 3:
        triggers["Multiple Domains"] = True
        print(f"✓ Trigger 3: Multiple Domains = {len(domains)} domains ({', '.join(domains)}) → YES")
    else:
        print(f"✗ Trigger 3: Multiple Domains = {len(domains)} domains (<3) → NO")

    # Check trigger 4: Template Requirements
    template_indicators = ["template", "checklist", "matrix", "example", "model"]
    template_count = sum(research_request.lower().count(kw) for kw in template_indicators)
    if template_count >= 5:
        triggers["Template Requirements"] = True
        print(f"✓ Trigger 4: Template Requirements = {template_count} mentions (≥5) → YES")
    else:
        print(f"✗ Trigger 4: Template Requirements = {template_count} mentions (<5) → NO")

    # Check trigger 5: Estimated Output
    estimated_tokens = len(research_request.split()) * 50  # Rough estimate
    if estimated_tokens > 25000:
        triggers["Estimated Output (>25k tokens)"] = True
        print(f"✓ Trigger 5: Estimated Output = ~{estimated_tokens:,} tokens (>25k) → YES")
    else:
        print(f"✗ Trigger 5: Estimated Output = ~{estimated_tokens:,} tokens (≤25k) → NO")

    print()
    print("TRIGGER SUMMARY:")
    print("-" * 80)
    triggers_activated = sum(triggers.values())
    print(f"Total Triggers Activated: {triggers_activated}/5")
    for trigger_name, activated in triggers.items():
        status = "✓ YES" if activated else "✗ NO"
        print(f"  {status} - {trigger_name}")

    print()
    print("=" * 80)

    if triggers_activated > 0:
        print("DECISION: MULTI-PART RESEARCH REQUIRED")
        print("=" * 80)
        print()
        print("Reason: At least one trigger activated → Multi-part approach mandatory")
        print()
        print("NEXT STEPS (per AGENT.md Protocol):")
        print("1. Inform user in Portuguese about multi-part approach")
        print("2. Define 3-4 logical parts based on request structure")
        print("3. Execute research for each part, saving to separate files")
        print("4. Create consolidated report merging all parts")
        print("5. Return only summary to user with file paths")
        print()
        print("RECOMMENDED PARTS STRUCTURE:")
        print("-" * 80)
        print("Part 1: Regulatory Framework & Compliance (Sections 2, 6)")
        print("Part 2: Pharmacist Profile & Clinical Competencies (Sections 3, 4)")
        print("Part 3: Quality Standards & Operational Processes (Sections 5, 7, 8)")
        print("Part 4: Deliverables, Templates & Consolidated Report (Sections 9, 10, 11)")
        print()

        # Create instruction file for Claude
        instruction = """
DEEP RESEARCH AGENT EXECUTION - MULTI-PART PROTOCOL

This research has triggered MULTI-PART protocol. Follow these steps EXACTLY:

STEP 1: Inform User (in Portuguese)
--------------------------------------
Inform the user that this is a comprehensive research that will be divided into 4 parts to ensure maximum quality and avoid technical limitations.

Message template:
"Esta pesquisa é muito abrangente e será dividida em 4 partes para garantir qualidade máxima e evitar limitações técnicas. Cada parte será salva em arquivo separado, e ao final será criado um relatório consolidado completo."

STEP 2: Execute Multi-Part Research
--------------------------------------
Research and save each part to a separate file:

**Part 1: Regulatory Framework & Compliance**
- File: /Users/denismarinho/ed-compounding-pharmacist-part1-regulatory.md
- Sections: 2 (Regulatory Framework), 6 (Compounding Limits & Compliance)
- Focus: 503A vs 503B, USP standards, FDA/FTC/NABP guidelines, state boards, essentially a copy rule, advertising compliance

**Part 2: Pharmacist Profile & Clinical Competencies**
- File: /Users/denismarinho/ed-compounding-pharmacist-part2-profile-clinical.md
- Sections: 3 (Pharmacist Profile & Qualifications), 4 (Clinical Competencies ED)
- Focus: Education, certifications, formulation skills, QbD, PDE5i mechanisms, PK/PD, safety, contraindications, counseling

**Part 3: Quality Standards & Operational Processes**
- File: /Users/denismarinho/ed-compounding-pharmacist-part3-quality-operations.md
- Sections: 5 (Quality Standards & Testing), 7 (Standard Process SOP), 8 (Supplier Evaluation Matrix)
- Focus: QC by dosage form, stability, BUD, raw materials, testing, SOP from proposal to release, supplier checklist

**Part 4: Deliverables, Templates & Models**
- File: /Users/denismarinho/ed-compounding-pharmacist-part4-deliverables.md
- Sections: 9 (Formula Models), 10 (AI Agent Roadmap), 11 (Deliverables Summary)
- Focus: Educational formula examples, AI agent prompts/rules, templates, checklists, matrices

STEP 3: Create Consolidated Report
--------------------------------------
After ALL parts are complete, merge into:
- File: /Users/denismarinho/ed-compounding-pharmacist-complete-report.md
- Include: Unified Executive Summary, Master Table of Contents, all parts merged, consolidated bibliography

STEP 4: Return Summary to User
--------------------------------------
Provide concise summary (300-400 words) in Portuguese with:
- Files created (paths)
- Scope of research (sources, searches, templates)
- Key findings (3-4 bullets)
- Next steps

CRITICAL REMINDERS:
- NEVER try to return full research in response
- ALWAYS save each part to file
- ALWAYS create consolidated report
- ALWAYS return only summary with file paths
- Apply ALL quality standards from AGENT.md (templates, case studies, sources)

Research request is in: /Users/denismarinho/deep-research-request.md
"""

        instruction_file = "/Users/denismarinho/deep-research-execution-instructions.txt"
        with open(instruction_file, 'w') as f:
            f.write(instruction)

        print(f"Execution instructions saved to: {instruction_file}")
        print()
        print("=" * 80)
        print("READY TO EXECUTE")
        print("=" * 80)
        print()
        print("The deep-research agent should now:")
        print("1. Read the research request")
        print("2. Follow the multi-part protocol")
        print("3. Conduct comprehensive research with WebSearch and WebFetch")
        print("4. Save 4 separate part files + 1 consolidated report")
        print("5. Return summary in Portuguese")

    else:
        print("DECISION: STANDARD RESEARCH (NOT MULTI-PART)")
        print("=" * 80)
        print()
        print("Reason: No triggers activated → Standard research approach")
        print()
        print("Note: This should not happen for this request. Recheck triggers.")

    return 0

if __name__ == "__main__":
    sys.exit(main())
