# United Women SACCO — System Guide

**Platform:** Microsoft Dynamics 365 Business Central  
**Version:** 1.0.0.133  
**Extension ID Range:** 50000–59999  
**Total AL Files:** 2,739

---

## Table of Contents

1. [System Overview](#system-overview)
2. [Architecture](#architecture)
3. [How Posting Works](#how-posting-works)
4. [UI Design & Pages](#ui-design--pages)
5. [Reports & Layouts](#reports--layouts)
6. [Approval Workflows](#approval-workflows)
7. [Number Series](#number-series)
8. [Membership Module](#membership-module)
9. [Savings (FOSA)](#savings-fosa)
10. [Credit & Loans](#credit--loans)
11. [Finance & General Ledger](#finance--general-ledger)
12. [Sacco Journals](#sacco-journals)
13. [Banking & Payments](#banking--payments)
14. [Mobile & Agency Banking](#mobile--agency-banking)
15. [Dividends & Share Trading](#dividends--share-trading)
16. [HR & Payroll](#hr--payroll)
17. [Procurement](#procurement)
18. [SASRA & Compliance](#sasra--compliance)
19. [AML Module](#aml-module)
20. [CRM Module](#crm-module)
21. [APIs & Integrations](#apis--integrations)
22. [SMS & Email](#sms--email)
23. [Role Centers](#role-centers)
24. [Object Ranges](#object-ranges)

---

## System Overview

This is a full-stack SACCO (Savings and Credit Cooperative) management platform built as a Business Central 365 AL extension. It manages the complete lifecycle of member services — from registration to loan disbursement, from teller transactions to regulatory SASRA reporting.

The system extends BC 365's standard financial backbone (General Ledger, Chart of Accounts) with SACCO-specific tables, pages, and business logic.

### Codebase Statistics

| Category | Count |
|----------|-------|
| Tables (including extensions) | 762 |
| Pages (including extensions) | 1,144 |
| Reports (including extensions) | 598 |
| Codeunits | 93 |
| Enums | 22 |
| XMLports | 40 |
| Queries | 1 |
| API Pages | 7 |
| Role Center Pages | 9 |
| Setup/Config Tables | 36 |

### Module Map

| Module | Description |
|--------|-------------|
| **Membership** | Member registration, KYC, accounts, exits |
| **Savings (FOSA)** | Deposits, withdrawals, standing orders, interest |
| **Credit & Loans** | Applications, appraisal, disbursement, repayment |
| **Finance & GL** | Chart of accounts, journals, bank reconciliation, budgets |
| **Banking** | Cheques, EFT, RTGS, Coop B2B, ATM |
| **Mobile Banking** | M-Pesa, Sky Mobile, Agency banking, SpotCash, MZawadi |
| **HR & Payroll** | Employee records, leave, appraisal, payslips, P9 |
| **Procurement** | Purchase requisitions, RFQ, LPO, goods receipt |
| **CRM** | Ticketing, SLA tracking, customer support (47 files) |
| **AML** | Transaction monitoring, risk profiles, alerts (17 files) |
| **Communications** | SMS dispatch, email, custom notifications |
| **Compliance** | SASRA reports, CRB, IFRS staging, provisioning |

---

## Architecture

### AL Object Model

Business Central uses a typed object model where every piece of the application has a numeric ID:

| Object Type | Purpose | Count | Example |
|-------------|---------|-------|---------|
| **Table** | Data schema (fields, keys, triggers) | 723 + 39 ext | `Table 50350 "Sacco Journal Header"` |
| **Page** | UI screens: cards, lists, factboxes, role centers | 1,076 + 68 ext | `Page 50437 "Sacco Journal Card"` |
| **Codeunit** | Business logic, processing, integrations | 93 | `Codeunit 52188427 "Sacco Activities"` |
| **Report** | Data retrieval + rendering (RDLC/Word layouts) | 594 + 4 ext | `Report "Loan Appraisal List"` |
| **Enum** | Option sets and type-safe choices | 22 | `Enum "Approval Status Enum"` |
| **XMLport** | Data import/export (Excel, CSV, XML) | 40 | `XMLport "Import Checkoff Buffer"` |
| **Query** | Optimized read-only data retrieval | 1 | `Query "GL Transactions"` |

### How Objects Connect

```
Table (Data schema)
  → Page (UI for table)
    → Codeunit (Business logic)
      → Gen. Journal Line (Staging)
        → G/L Entry (Posted ledger)
```

### Extension Pattern

This codebase uses **TableExt** and **PageExt** objects to extend standard BC tables without modifying them. Custom fields like `"Member No."`, `"Loan No."`, and `"Transaction Type"` are added to the standard `Gen. Journal Line` table via extensions. The SACCO logic rides on top of BC's standard posting engine.

### Key Codeunits (Business Logic)

| Codeunit | Responsibility |
|----------|---------------|
| `Sacco Activities` | Core SACCO operations: posting journals, loan calculations, interest computation, checkoff processing |
| `Member Activities` | Member registration, KYC validation, account creation, member exits |
| `Banking Activities` | Teller transactions, cash management, bank reconciliation posting |
| `Calwide Approvals` | Custom approval workflow engine on top of BC's standard approval framework |
| `Payroll Processing` | Salary computation, deductions, payslip generation, statutory (NHIF, NSSF, PAYE) |
| `Gen. Jnl.-Post New` | Extended posting engine for SACCO-specific account types (Savings, Credit) |

---

## How Posting Works

### The Posting Concept

**Posting** is the act of converting a draft transaction into permanent ledger entries. Before posting, data lives in editable staging tables (like `Gen. Journal Line`). After posting, it becomes immutable entries in ledger tables (like `G/L Entry`, `Customer Ledger Entry`).

> Think of posting like signing a check: once posted, the transaction is permanent. You can't edit it — you can only reverse it by posting a correcting entry.

### The Posting Pipeline

```
1. Capture → 2. Validate → 3. Approve → 4. Preview → 5. Post
   (Enter data)  (Check rules)  (Workflow)   (Dry run)   (Commit to GL)
```

### Standard BC Posting (Gen. Jnl.-Post)

BC ships with `Codeunit "Gen. Jnl.-Post"` which handles posting Gen. Journal Lines to the GL. It creates:

- **G/L Entry** — The core financial record (debit/credit to a G/L account)
- **Customer Ledger Entry** — When Account Type = Customer
- **Vendor Ledger Entry** — When Account Type = Vendor
- **Bank Account Ledger Entry** — When Account Type = Bank Account

The SACCO extension adds two custom account types: `Savings` and `Credit`, handled by `"Gen. Jnl.-Post New"`.

### SACCO Journal Posting (PostNewSaccoJournal)

The `Sacco Activities` codeunit's `PostNewSaccoJournal` procedure orchestrates:

1. **Validation** — `ValidateSaccoJournalBeforePosting` runs `GenJnlCheckLine.RunCheck` on each line
2. **Duplicate check** — Checks if any line's Document No. was already posted in `Sacco Journal Line`
3. **Balance check** — `CalcSums("Amount (LCY)")` must equal zero
4. **Preparation** — Copies lines to temp records, sets `Channel := "Sacco Journal"`, clears `Posting No. Series`
5. **Posting** — Calls `Lines.SendToPosting(Codeunit::"Gen. Jnl.-Post")`
6. **Archival** — Copies posted lines into `Sacco Journal Line` table
7. **Cleanup** — Marks header as Posted, deletes the Gen. Journal Batch

If posting fails, `ResetFailedSaccoJournalPostingState` rolls back the Posted flag.

### Loan Posting

Loan disbursement posts journal entries that debit the loan (Credit) account and credit the member's savings or bank account. Interest posting runs on a schedule. The `Gen. Jnl.-Post New` codeunit intercepts standard posting to create entries in custom ledger tables alongside standard GL entries.

### What Gets Created When You Post

| Account Type | Ledger Created | Example |
|-------------|---------------|---------|
| G/L Account | G/L Entry | Interest income recognition |
| Customer | Customer Ledger Entry + G/L Entry | Member fee invoicing |
| Savings | Savings Ledger Entry + G/L Entry | Member deposit |
| Credit | Credit Ledger Entry + G/L Entry | Loan disbursement / repayment |
| Bank Account | Bank Ledger Entry + G/L Entry | Cash disbursement |

---

## UI Design & Pages

### Page Types

| PageType | Purpose | Example |
|----------|---------|---------|
| **Card** | Single record view/edit (like a form) | Member Card, Loan Application Card, Sacco Journal Card |
| **List** | Multiple records in a grid (browse/filter/search) | Member Listing, Sacco Journals List |
| **ListPart** | Embedded list inside a Card (subpage) | Custom Journal Lines (lines inside Journal Card) |
| **CardPart / FactBox** | Side panel showing related info | Member statistics, loan balance summary |
| **RoleCenter** | Dashboard homepage per user role | SuperAdmin, Credit, Finance, HR, Audit |
| **Worksheet** | Editable grid for batch operations | Payroll processing worksheet |
| **Document** | Header + Lines pattern (like an invoice) | Purchase orders, loan applications |
| **API** | REST endpoint for external access | SwartMembers, SwartLoans (Analytics API) |

### Page Structure in AL

```al
page 50437 "Sacco Journal Card"
{
    PageType = Card;                      // The page type
    SourceTable = "Sacco Journal Header"; // Which table it displays
    DeleteAllowed = true;                 // User can delete records

    layout { }     // Fields arranged in groups
    actions { }    // Buttons and menu items
    
    // Triggers (lifecycle events):
    trigger OnOpenPage()       // When page opens
    trigger OnNewRecord()      // When user creates new record
    trigger OnAfterGetRecord() // After each record loads
}
```

### Layout: Groups and Fields

Fields are organized in `group` containers inside `area(content)`. Groups appear as collapsible sections (FastTabs) on the card:

```al
layout {
    area(content) {
        group(General) {                    // FastTab: "General"
            field("Document No."; Rec."Document No.") { }
            field("Posting Date"; Rec."Posting Date") { }
            field(Status; Rec.Status) { Editable = false; }
        }
        part(Lines; "Custom Journal Lines") { // Embedded subpage
            SubPageLink = "Journal Batch Name" = field("Document No.");
        }
    }
}
```

### Actions: Buttons and Menus

Actions appear in the ribbon (action bar) at the top. They can be promoted to appear prominently:

```al
actions {
    area(processing) {
        action("Post Entries") {
            Image = Post;
            Promoted = true;               // Show in ribbon
            PromotedCategory = Process;     // Which ribbon tab
            trigger OnAction()
            begin
                SaccoActivities.PostNewSaccoJournal(Rec."Document No.");
            end;
        }
    }
}
```

### The Header + Lines Pattern

Most transaction documents follow a **header + lines** pattern:

- **Header** (`Sacco Journal Header`) — Document No., Posting Date, Status, Captured By
- **Lines** (`Gen. Journal Line`) — Individual debit/credit entries linked by `Journal Batch Name = Document No.`

The Card page shows header fields at top and embeds lines as a `ListPart` subpage at bottom. When posted, the subpage switches from editable lines (`Custom Journal Lines`) to read-only posted lines (`Posted Custom Journal Lines`).

---

## Reports & Layouts

### Report Architecture

A BC report has two parts:

1. **Report Object (.al file)** — Defines the data model: which tables to query, filters, calculated fields, request page parameters
2. **Layout File** — Defines the visual output: RDLC (pixel-perfect), Word (template-based), or Excel

### Report Data Model

```al
report 50100 "Member Statement"
{
    dataset {
        dataitem(Member; Members)  // Primary table
        {
            column(MemberNo; "No.") { }
            column(MemberName; Name) { }
            
            dataitem(Ledger; "Savings Ledger Entry")  // Child table
            {
                DataItemLink = "Member No." = field("No.");
                column(PostingDate; "Posting Date") { }
                column(Amount; Amount) { }
            }
        }
    }
    requestpage { }  // Filter dialog shown before running
}
```

### Report Categories

| Category | Key Reports | Purpose |
|----------|-------------|---------|
| **Financial** | Bank Income Statement, Executive Summary, GL Transactions by Channel, Trial Balance | Financial position and performance |
| **Loan** | Loan Appraisal, Loan Performance Analysis, Loans Provisioning, NPL Report, Gross Loan Portfolio | Credit portfolio monitoring |
| **Member** | Member Bio Data, Member Register, Member Statement, Counter Service Statement | Member information and account activity |
| **Savings** | FOSA Balance, FOSA Interest Analysis, Fixed Deposit Certificate | Savings account monitoring |
| **Operations** | Checkoff Report, Checkoff Variance, Dividend Analysis/Register/Slip | Day-to-day SACCO operations |
| **Compliance** | CRB Generation, SASRA Loan Categorization, IFRS Staging Summary, Insider Lending | Regulatory submissions |
| **HR** | Payslip, P9 Tax, Leave Schedule, Employee List, Appraisal/BSC Scorecard | Human resources management |

### Layout Files

This system uses primarily **RDLC** layouts (40+ layout files in `Layouts/` and `Reports/` directories). Some reports also have Word (.docx) and Excel (.xlsx) layouts. Layout files are referenced by the report's `RDLCLayout` or `WordLayout` property.

---

## Approval Workflows

### The Approval Flow

```
Open (Draft) → Pending (Sent for approval) → Approved (Ready to post) → Posted (Permanent)
```

### Custom Approval Engine

This system uses `Calwide Approvals` built on top of BC's standard `Approvals Mgmt.` codeunit. It adds an `Approval Tracker` table that links any document to standard approval entries.

**Workflow:**

1. User clicks **Send Approval Request** — calls `CalwideApprovals.CreateCustomTracker`
2. System creates an Approval Tracker record with document's table ID, Document No., and Document Type
3. Standard BC approval entries are created, notifying the approver
4. Approver approves/rejects via the Approval Entries page
5. On approval, the document's Status changes to `Approved`
6. Document can now be posted (posting checks `TestField(Status, Approved)`)

### Documents That Require Approval

| Document | Document Type Enum |
|----------|-------------------|
| Sacco Journal Vouchers | `"Journal Vouchers"` |
| Loan Applications | `"Loan Application"` |
| Member Applications | `"Member Application"` |
| Purchase Requisitions | Procurement workflow |
| Leave Applications | HR workflow |

---

## Number Series

### How Number Series Work

A Number Series defines a pattern (e.g., `JVH00001..JVH99999`) and tracks the last used number. On insert, the system calls `NoSeries.GetNextNo()`:

```al
// In OnInsert trigger of Sacco Journal Header:
NoSetup.Get();
NoSetup.TestField("Sacco Journal Nos");
"Document No." := NoSeries.GetNextNo(
    NoSetup."Sacco Journal Nos",  // Series code (e.g., 'JVH')
    WorkDate(),                    // Reference date
    true                           // Modify = consume the number
);
```

### Key Number Series

| Document | Series Setup Field | Example Pattern |
|----------|-------------------|-----------------|
| Sacco Journal Header | `"Sacco Journal Nos"` | JVH00001 |
| Journal Lines (Document No.) | Gen. Journal Batch `"No. Series"` = 'JV' | JV-000001 |
| Member Numbers | Sacco Setup | MBR00001 |
| Loan Application No. | Sacco Setup | LN00001 |

> **BC v20+ uses NumberSequence** — The modern `No. Series` codeunit uses SQL `NumberSequence` internally, which operates outside the SQL transaction. The number is consumed the instant `GetNextNo` is called, even if the transaction rolls back. This prevents duplicate numbers across concurrent sessions.

### The Renumber Pattern

The Custom Journal Lines page includes a **Renumber Document Numbers** action that reassigns document numbers using the batch's No. Series, preventing "Document No. already posted" errors.

---

## Membership Module

### Member Registration Flow

```
Application (KYC data) → Approval (Committee) → Account Setup (Savings + shares) → Active Member
```

### Key Tables

- **Members** — Core member data: personal details, ID, phone, employer, next of kin
- **Savings Accounts** — Member deposit accounts (linked to Products)
- **Credit Accounts** — Member loan accounts
- **Product Setup** — Defines savings/loan product types with interest rates, limits, and rules

### Member Activities Codeunit

Handles:
- Member number generation and validation
- Account creation (auto-creates savings accounts per product type)
- KYC verification and ID validation (integrates with IDM module)
- Member exit processing (checks outstanding loans, refunds shares)
- Blacklist checking (phone numbers, IDs, accounts via imported lists)

---

## Savings (FOSA)

### Account Types

Savings accounts are defined by **Product Setup** records. Each product defines interest rates, minimum balances, withdrawal rules, and linked GL accounts:

- **Ordinary Savings** — Regular member deposits
- **Share Capital** — Member equity contributions
- **Fixed Deposits** — Term deposits with maturity dates
- **Junior Savings** — Minor accounts
- **Holiday Savings** — Special purpose accounts

### Transaction Flow

When a member deposits or withdraws, the transaction flows through the Gen. Journal Line with `Account Type = Savings`. The extended posting engine creates entries in the **Savings Ledger Entry** table alongside standard G/L entries.

### Standing Orders

Automatic recurring transfers between accounts, configured via the Standing Orders table and processed by `Sacco Activities` on schedule.

---

## Credit & Loans

### Loan Lifecycle

```
Application → Appraisal (Guarantors, collateral) → Approval (Credit committee) → Disbursement → Repayment (Checkoff / manual)
```

### Key Tables

| Table | Purpose |
|-------|---------|
| Credit Accounts | Active loan records: balance, status, product type, disbursement date |
| Loan Application | Application details before disbursement |
| Loan Guarantors | Members guaranteeing the loan |
| Loan Collateral | Security pledged against the loan |
| Loan Schedule | Repayment schedule: principal, interest, balance per period |
| Credit Ledger Entry | Posted transaction history for each loan |

### Interest Calculation

Interest is calculated by `Sacco Activities` based on the loan product's rate, method (reducing balance, flat rate, amortized), and outstanding principal. `GetInterestArrearsSASRA` computes interest arrears for regulatory reporting.

### Checkoff Processing

Monthly salary deductions (checkoff) are the primary repayment method. The system imports checkoff data via XMLport, validates against member accounts, and posts deductions. The **Checkoff Variance** report identifies discrepancies between expected and actual deductions.

### Loan Graduation

`LoanGraduationCalculator` determines whether a member qualifies for a higher loan tier based on repayment history and saving patterns.

---

## Finance & General Ledger

### Chart of Accounts

Standard BC Chart of Accounts extended with SACCO-specific account mappings. Product Setup records link savings/loan products to specific G/L accounts.

### Journal Types

- **Sacco Journal** — Custom journal for SACCO-specific transactions
- **General Journal** — Standard BC journal for GL entries
- **HR Leave Journal** — Leave accrual and consumption entries
- **Payroll Journal** — Salary and deduction entries from payroll processing

### Bank Reconciliation

Custom bank reconciliation logic extends BC's standard with:
- Import from bank statement files (`BankRecImport`)
- Automatic matching against posted entries (`BankRecMatching`)
- Validation (`BankRecValidation`)
- Channel-based filtering (M-Pesa, RTGS, Cheque, etc.)

### Budgetary Control

`Budgetary Control` codeunit enforces spending limits against approved budgets. Checks remaining budget for account and period before procurement transactions post.

### Account Schedules

`AccountScheduleManagement` provides custom financial statement generation for SACCO-specific financial reporting.

---

## Sacco Journals

### How It Works

The Sacco Journal wraps BC's standard General Journal, adding:
- **Approval workflow** — Journals must be approved before posting
- **Document tracking** — Header with status, captured-by, and posting history
- **Import capability** — Bulk import journal lines from Excel
- **Preview before posting** — See what entries will be created
- **Posted archive** — Lines copied to Sacco Journal Line table after posting

### Data Flow

```
Sacco Journal Header (Document No. = "JVH00011")
  │
  ├── Gen. Journal Line (Batch = "JVH00011", Template = "GENERAL")
  │     Line 1: Debit  Member L13-002803  (Credit account)  500.00
  │     Line 2: Credit G/L 30109         (School Fees Loan) 500.00
  │
  └── On Post:
        Gen. Jnl.-Post creates G/L Entries + Credit Ledger Entries
        Lines archived to Sacco Journal Line table
        Gen. Journal Batch "JVH00011" deleted
        Header marked Posted = true
```

### Excel Import Format

14 columns:

| # | Column | # | Column |
|---|--------|---|--------|
| 1 | Line No. | 8 | Credit Amount |
| 2 | Posting Date | 9 | Transaction Type |
| 3 | Document No. | 10 | Loan No. |
| 4 | Account Type | 11 | External Document No. |
| 5 | Account No. | 12 | Activity Code (Dim 1) |
| 6 | Description | 13 | Branch Code (Dim 2) |
| 7 | Debit Amount | 14 | Batch No. |

---

## Banking & Payments

### Payment Channels

| Channel | Description |
|---------|-------------|
| **Teller / Counter** | Cash deposits and withdrawals at branch |
| **Cheque** | Cheque book management, printing, and clearing |
| **EFT / RTGS** | Electronic funds transfer and real-time gross settlement |
| **Coop B2B / P2F** | Co-operative Bank Business-to-Business and Pesalink |
| **ATM** | ATM integration via Coop ATM setup |
| **Checkoff** | Employer salary deductions for loan repayment |

### Banking Activities Codeunit

Handles teller operations: opening cash registers, posting cash transactions, end-of-day balancing, and cash transfer between tellers and the vault.

### Banking User Setup

Each teller/cashier has a `Banking User Setup` record defining cash limits, assigned bank account, and responsibility center.

---

## Mobile & Agency Banking

### Integrations

| Channel | Codeunit | Purpose |
|---------|----------|---------|
| M-Pesa | `MpesaActivities` | Paybill and C2B integration for deposits |
| Sky Mobile | `SkyMBanking`, `SkyMobileBanking` | Mobile banking app transactions |
| Sky Agency | `SkyAgencyBanking` | Agent-assisted transactions at partner locations |
| SpotCash | `SpotCash`, `SpotCash Agency` | Mobile money and agency cash-out |
| MZawadi | `MZawadi` | Loyalty/rewards integration |
| SkyWorld | `SkyWorldMbanking` | Extended mobile banking services |

### Transaction Flow

Mobile transactions arrive via API, are validated against member accounts and limits, and posted through the standard journal posting pipeline. Each transaction is tagged with its `Channel` for reconciliation and reporting.

---

## Dividends & Share Trading

### Dividend Processing

Annual dividends calculated based on member share balances and approved rates. Reports:
- **Dividend Analysis** — Breakdown by member
- **Dividend Register** — Official record of all dividends
- **Dividend Slip** — Individual member statements
- **Dividend Progression** — Year-over-year comparison

### Share Trading

`Share Trading Management` and `Share Trading Post` codeunits handle member-to-member share transfers via the Share Trading Setup table.

---

## HR & Payroll

### HR Features

| Feature | Description |
|---------|-------------|
| **Employee Records** | Personal details, qualifications, contracts |
| **Leave Management** | Leave types, applications, balances, carry-over |
| **Appraisals / BSC** | Performance scorecards, KPIs, reviews |
| **Payroll** | Salary computation, deductions, PAYE, NHIF, NSSF |
| **Training** | Training needs, applications, tracking |
| **Discipline** | Disciplinary cases and tracking |

### Payroll Processing

`Payroll Processing` codeunit computes gross pay, applies tax tables (PAYE), statutory deductions (NHIF, NSSF, HELB), voluntary deductions (staff loans, insurance), and generates net pay. Results posted to GL via payroll journal entries.

### Leave Journal Pipeline

```
Check Line → Post Line → Make Ledger Entry → Post Batch
```

### Key Reports

Payslip, P9 Tax Certificate, Leave Schedule, Employee List, BSC Scorecard, Shift Closure Report, Transport Requisitions, Medical Scheme.

---

## Procurement

### Procurement Flow

```
Requisition (User requests) → RFQ (Vendor quotes) → LPO (Purchase order) → Receipt (Goods received) → Invoice (Payment)
```

### Key Codeunits

- `GoodsReceiptManagement` — Goods receipt note processing
- `LPOManagement` — Local purchase order management
- `RFQQuotationManagement` — Request for quotation scoring and evaluation
- `ProcurementWorkflowManagement` — Procurement-specific approval workflows

### Budgetary Control Integration

Before an LPO is approved, the system checks available budget for the requesting cost center and GL account.

---

## SASRA & Compliance

### SASRA Reporting

`SASRA Categorization Mgt` codeunit and related reports generate regulatory submissions:

- **Loan Categorization** — NPL classification (Normal, Watch, Substandard, Doubtful, Loss) based on days in arrears
- **Loans Provisioning** — Required loss provisions per categorization
- **IFRS Staging Summary** — IFRS 9 expected credit loss staging
- **Insider Lending** — Related-party loan tracking

### Credit Reference Bureau (CRB)

Two integrations:
- `CRB` codeunit — Standard CRB data generation and submission
- `TransUnionAPIIntegration` — Direct API integration with TransUnion Kenya for credit checks

### Compliance Reports

Statutory Notices, Demand Letters, Defaulter SMS Generation, Debt Collection Reports, MFI Reports.

---

## AML Module

### Architecture (17 files)

| Component | Objects |
|-----------|---------|
| Tables | Customer Risk Profile, Transaction Monitor, Suspicious Activity, AML Setup |
| Pages | Setup, Transaction Monitor List/Card, Suspicious Activity List/Card, Customer Risk Profile List/Card |
| Enums | Risk Level, Transaction Type, Alert Type, Status |
| Codeunits | AML Management, AML Job Queue Processing |

### How It Works

1. **Risk Profiling** — Each customer gets a risk level (Low/Medium/High) based on transaction patterns
2. **Transaction Monitoring** — `AMLManagement` screens transactions against thresholds and patterns
3. **Alert Generation** — Suspicious transactions create Suspicious Activity records
4. **Job Queue** — `AMLJobQueueProcessing` runs monitoring on a schedule

---

## CRM Module

### Ticket Lifecycle

```
New Ticket (Member complaint) → Assignment (Auto-assign) → In Progress (Agent working) → Resolved (Closed)
```

### Key Features

- **Auto-Assignment** — `AssignmentAlgorithm` distributes tickets based on agent workload and skills
- **SLA Tracking** — Response and resolution time targets per priority, with escalation rules
- **Escalation** — Automatic escalation when SLA deadlines approach
- **Communication Log** — Track all interactions (SMS, email, calls) with members
- **API Access** — REST APIs for external ticket submission (Customers API, Tickets API)

---

## APIs & Integrations

### Outbound Integrations

| System | Codeunit | Purpose |
|--------|----------|---------|
| TransUnion Kenya | `TransUnionAPIIntegration` | Credit reference checks |
| MCRB | `MCRBAPIIntegration` | Credit bureau API |
| EDMS (Coseke) | `EDMS`, `CosekeEDMS` | Electronic document management |
| Azure Blob | `AzureBlobStorageHandler` | File/document storage |
| ID Verification | `IDMAPIIntegration` | National ID verification |
| Power Automate | `UWPowerAutomateBusinessEvents` | Business event triggers |

### Inbound APIs (Analytics)

5 read-only API pages for external analytics tools:

- `SwartMembers` — Member demographics
- `SwartLoans` — Loan portfolio data
- `SwartSavingsAccounts` — Savings account balances
- `SwartSavingsLedgerEntries` — Savings transaction history
- `SwartCreditLedgerEntries` — Loan transaction history

### Portal Integration

`SaccoPortal` and `SkyPortal` handle member self-service portal interactions (balance inquiries, mini-statements, loan applications). `OnlineRegistration` processes new member applications from the portal.

---

## SMS & Email

### SMS

`SMSDispatcher` sends transactional SMS (deposit confirmations, loan disbursement alerts, payment reminders). Supports dynamic templates and bulk campaigns.

### Email

- `EmailManagement` — Standard transactional emails (statements, loan notices)
- `BulkEmailManagement` — Mass email campaigns
- `CustomSMTPSetup` — Independent email server configuration

### Custom Notifications

`CustomNotifications` and `MemberNotificationManagement` provide rule-based member alerts (loan due reminders, maturity notices, account activity alerts).

---

## Role Centers

| Role Center | Target User | Key Features |
|-------------|-------------|--------------|
| **SuperAdmin** | System administrators | Full access to all modules, setup, and configuration |
| **Finance Module** | Finance officers | GL, journals, bank reconciliation, financial reports, budgets |
| **Credit** | Credit officers | Loan applications, appraisals, disbursements, portfolio monitoring |
| **HR** | HR managers | Employee records, leave, payroll, appraisals |
| **Registry** | Registry/front desk | Member registration, KYC, document management |
| **Audit** | Internal auditors | Audit trails, reports, compliance checks |
| **Admin Secretary** | Administrative support | Correspondence, scheduling, document flow |
| **FOSA (Teller)** | Front office tellers | Cash transactions, deposits, withdrawals, teller balancing |

---

## Object Ranges

### ID Range

The extension uses **50000–59999** as defined in `app.json`:

| Range | Usage |
|-------|-------|
| 50000–50999 | Core tables, pages, reports (membership, savings, credit) |
| 52188400–52188499 | Core codeunits and business logic |
| 52188500–52188699 | Integrations, setup tables, extended features |
| 52188700–52188899 | Banking, mobile, HR, procurement |
| 52188900–52188999 | AML, share trading, newer modules |

### File Naming Conventions

Files follow `<Prefix><ID>.<ObjectName>.al`:

- `Tab52188687.SaccoJournalHeader.al` — Table
- `Pag52188755.SaccoJournalCard.al` — Page
- `Cod52188450.CalwideEventSubscriptions.al` — Codeunit
- `Rep52188XXX.ReportName.al` — Report

Older files use spaces: `Table 52188457.Sacco Setup.al`, `Codeunit 52188427.Sacco Activities.al`

### Version History

~130 compiled `.app` packages tracking versions from `1.0.0.0` through `1.0.0.131`, current source at `1.0.0.133`.
