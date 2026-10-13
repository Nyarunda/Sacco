# Procurement User Manual

## 1. Purpose
This manual explains how to run the procurement process in this module from requisition to vendor award and order execution.

## 2. Scope
The current solution supports:
- Store Requisition creation, release, approval, and posting.
- Automatic External Requisition creation for out-of-stock lines.
- RFQ creation and vendor quotation evaluation (RFQ and RFP scoring models).
- Vendor award and LPO/LSO creation.
- LPO release/approval and Purchase Order creation.
- Procurement Role Center with activity cues and navigation.

## 3. Key Roles
- Requester: creates store requisitions.
- Approver(s): approve Store Requisitions, External Requisitions, and LPO/LSO documents.
- Procurement Officer: creates RFQs, manages quotations, evaluates and awards.
- Procurement Manager: maintains setup, scoring criteria, and workflow thresholds.

## 4. First-Time Setup

### 4.1 Procurement Setup
Open **Procurement Setup** and configure:
- Number series:
  - Store Requisition Nos.
  - External Requisition Nos.
  - RFQ Nos.
  - LPO Nos.
  - GRN Nos.
- Approval thresholds:
  - Finance Approval Threshold
  - Procurement Committee Threshold
  - Board Approval Threshold
- Enable/disable approval workflow.
- Email template fields (if used).

### 4.2 RFQ Scoring Criteria Setup (Dynamic Matrix)
Open **RFQ Scoring Criteria Setup**:
- Click **Initialize Defaults** (first time).
- Maintain lines by:
  - Document Type (`Goods (RFQ)` or `Services (RFP)`)
  - Criteria Type
  - Min/Max Threshold/Days
  - Points Awarded
  - Weight %
  - Active

Used at evaluation time for:
- Delivery band points.
- Price weight cap.
- Minimum qualifying thresholds.

### 4.3 Role Center Assignment
Assign users profile **Procurement User** to use the Procurement Role Center dashboard.

## 5. End-to-End Process

### Step 1: Create Store Requisition
1. Open **Store Requisition Card**.
2. Enter header details.
3. Add lines in **Store Requisition Lines**.
4. Click **Release**.

System behavior:
- Validates at least one line exists.
- Checks stock availability.
- If out-of-stock lines exist, creates an External Requisition automatically.
- Sets status to `Pending Approval` (if workflow enabled) or `Approved` (if disabled).

### Step 2: Approve Store Requisition (if workflow enabled)
Approvers complete approvals through configured workflow entries.
When all required approvals are complete, status becomes `Approved`.

### Step 3: Post Store Requisition (in-stock issue)
For approved requisitions where stock is available:
1. Open requisition.
2. Click **Post**.

Result:
- Inventory issue is posted.
- Requisition status becomes `Posted`.

### Step 4: Process External Requisition (for out-of-stock items)
1. Open **External Requisition Card**.
2. Review lines and budget dimensions.
3. Click **Release**.
4. Complete approvals if required.

Status becomes `Approved` when done.

### Step 5: Create RFQ
From approved External Requisition:
1. Click **Create RFQ**.
2. Open the RFQ card.
3. Set:
  - **Evaluation Matrix Type** (`RFQ`/`RFP`)
  - **Scoring Document Type** (`Goods (RFQ)`/`Services (RFP)`)
  - **Budget/Base Amount** (required for RFP)

### Step 6: Send RFQ and Capture Quotations
1. On RFQ, click **Send RFQ to Vendors**.
2. Capture vendor quotations in **Vendor Quotation Card/List**.
3. Enter manual scores where applicable:
  - RFQ: Statutory Score, Quality Score
  - RFP: Technical Capability Score, Track Record Score

### Step 7: Evaluate Quotations
On RFQ card, click **Evaluate Quotations**.

System calculates:
- Delivery score from configured threshold bands.
- Pricing/RFP price score from configured price weight.
- Total evaluation score and ranking.
- Disqualification flag and reason using configured minimum thresholds.

### Step 8: Award Vendor
On RFQ card, click **Award Vendor**.

System behavior:
- Awards only qualified quotation with Ranking = 1.
- Updates RFQ status to `Awarded`.
- Sends award/regret flags on quotation records.

### Step 9: Create and Process LPO/LSO
From awarded quotation:
1. Create LPO (via LPO Management process).
2. Open **LPO/LSO Card**.
3. Click **Release**.
4. Complete approvals if required.
5. Click **Create Purchase Order** after approval.

### Step 10: Receive and Post GRN
1. Open **Goods Receipt Note Card**.
2. Enter receipt details and lines.
3. Click **Verify**.
4. Click **Post**.

## 6. Status Reference

### Store Requisition
- `Open` -> `Pending Approval`/`Approved` -> `Posted`

### External Requisition
- `Open` -> `Pending Approval`/`Approved` -> `RFQ Created` (after RFQ creation)

### RFQ
- `Open` -> `Quotations Received` -> `Under Evaluation` -> `Awarded`

### Vendor Quotation
- `Submitted` -> `Under Evaluation` -> `Awarded` or `Rejected`

### LPO/LSO
- `Open` -> `Pending Approval`/`Approved` -> `Posted` (after PO creation)

## 7. Procurement Role Center Usage
The **Procurement Role Center** provides:
- Cue tiles:
  - Open/Pending Store Requisitions
  - Open/Under Evaluation/Awarded RFQs
  - Submitted/Under Evaluation Quotations
  - Open/Pending/Approved LPOs/LSOs
  - Open GRNs
- Quick navigation to operational and setup pages.

## 8. Common Errors and Fixes
- `You must add at least one line...`
  - Add lines before releasing requisition/LPO.
- `No active scoring criteria found...`
  - Open **RFQ Scoring Criteria Setup**, activate or initialize lines.
- `...score is above configured maximum...`
  - Reduce entered manual score or increase criterion weight in setup.
- `Budget/Base Amount` required for RFP
  - Enter budget amount on RFQ before evaluation.
- `No qualified quotation found to award.`
  - Review scoring, disqualification thresholds, and quotation data.

## 9. Current Functional Notes
- RFQ email sending and quotation upload are placeholder/TODO in current code.
- Award/regret email sending is placeholder/TODO.
- GRN Verify/Post actions require corresponding management codeunit implementation in your environment.

## 10. Recommended Operating Controls
- Lock scoring criteria updates to authorized procurement admins only.
- Attach bid opening/evaluation reports on the RFQ record.
- Keep approval workflow thresholds aligned with procurement policy.
- Review and approve matrix changes before live use.
