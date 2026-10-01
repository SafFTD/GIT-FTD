# Workflow: document-discovery

> **M3 Implementor workflow — source of truth.**
> Use this workflow to discover, classify, and index documents for an active project.

---

## When to use

- At the start of a project engagement to understand what documentation exists.
- When asked "what documents do we have?" or "is there a spec for this?"
- When identifying gaps in the document set.

---

## Step 1 — Identify the source location

Determine where project documents are stored. For the active project, check `CONTEXT.md` for the source document path.

**For HSBC project:** `D:\GIT-FTD\Projects\GC-CR-26-014_HSBC H2H ISO 20022\`

Read the directory listing. Note every file and subdirectory.

---

## Step 2 — Classify each document

**Agent:** m3-document-classifier

For each document:
1. Read the filename and first section of the document (if readable).
2. Assign a role code from `knowledge/implementation/document-roles.md`.
3. Assign a knowledge classification label.
4. Identify the project and integration it relates to.
5. Note read status (READ / NOT READ / UNREADABLE).

---

## Step 3 — Build the document index

Create or update `projects/{project-code}/documents.md` with:
- Document number (D{NNN})
- Filename
- Role code
- Knowledge classification
- Read status
- Key content summary (if read)

---

## Step 4 — Build the document relationship graph

Map documents against the standard document chain:

```
BRD → FGA → FNS → IFS → MAP → TCS → SIT → UAT → DPL → RNB
```

Identify:
- Which stages have documents.
- Which stages are missing documents.

---

## Step 5 — Identify document gaps

For each gap in the document chain, create a gap entry:
- Gap type (from the gap taxonomy in IMPLEMENTOR.md)
- Missing document type
- What depends on it
- Recommended action

---

## Step 6 — Priority reading list

Identify which unread documents are most critical to answer current open questions. List them in priority order with the questions they would answer.

---

## Step 7 — Update project documents.md

Update `projects/{project-code}/documents.md` with all findings.

---

## Constraints

- Do not modify source documents.
- Classify documents from content, not just filename.
- Mark every document as READ or NOT READ — never claim content from an unread document.
