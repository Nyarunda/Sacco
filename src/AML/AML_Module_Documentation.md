# AML (Anti-Money Laundering) Module Documentation

## Overview

The AML module is a comprehensive Anti-Money Laundering system designed for the  SACCO to monitor all financial transactions, assess customer risk profiles, detect suspicious activities, and ensure regulatory compliance. The system provides real-time transaction monitoring, automated alert generation, and comprehensive reporting capabilities.

## System Architecture

### Core Components

1. **Enums** - Type-safe categorization for AML processes
2. **Tables** - Data storage for risk profiles, transaction monitoring, and investigations
3. **Codeunit** - Business logic for transaction analysis and risk assessment
4. **Event Subscribers** - Real-time integration with ledger posting processes

---

## 1. ENUMS

### 1.1 AML Risk Level (Enum 50690)
**Purpose**: Categorize customer and transaction risk levels for compliance purposes.

**Values**:
- `Low` (0) - Standard customers with normal transaction patterns
- `Medium` (1) - Customers requiring enhanced monitoring
- `High` (2) - High-risk customers requiring frequent review
- `Prohibited` (3) - Customers with restricted access/transactions blocked

### 1.2 AML Transaction Type (Enum 50691)
**Purpose**: Classify different types of financial transactions for monitoring.

**Values**:
- `Deposit` (0) - Money deposited into accounts
- `Withdrawal` (1) - Money withdrawn from accounts
- `Transfer` (2) - Money transferred between accounts
- `LoanDisbursement` (3) - Loan amount disbursed to customers
- `LoanRepayment` (4) - Loan repayments from customers
- `SharePurchase` (5) - Share capital purchases
- `ShareWithdrawal` (6) - Share capital withdrawals
- `MobileBanking` (7) - Mobile banking transactions
- `AgentBanking` (8) - Agent banking transactions
- `OnlineTransfer` (9) - Online transfer transactions

### 1.3 AML Alert Type (Enum 50692)
**Purpose**: Categorize different types of suspicious activity alerts.

**Values**:
- `HighValue` (0) - Transactions above specified thresholds
- `Velocity` (1) - High frequency or volume of transactions
- `Structured` (2) - Transactions designed to avoid reporting thresholds
- `Unusual` (3) - Patterns that deviate from customer's normal behavior
- `Threshold` (4) - Breach of regulatory or internal thresholds
- `PEP` (5) - Transactions involving Politically Exposed Persons
- `Dormant` (6) - Activity on previously dormant accounts
- `Geographic` (7) - Transactions from high-risk geographic locations
- `KYC` (8) - Know Your Customer compliance issues
- `Multiple` (9) - Multiple risk factors present simultaneously

### 1.4 AML Status (Enum 50693)
**Purpose**: Track the lifecycle status of suspicious activity investigations.

**Values**:
- `Open` (0) - New alert requiring initial assessment
- `InvestigationPending` (1) - Alert assigned for investigation
- `UnderReview` (2) - Active investigation in progress
- `EscalatedToManagement` (3) - Case escalated to senior management
- `ReportedToAuthorities` (4) - Reported to regulatory authorities (e.g., FRC)
- `FalsePositive` (5) - Determined to be legitimate activity
- `Cleared` (6) - Investigation completed, no issues found
- `Closed` (7) - Case closed with documented resolution

---

## 2. TABLES

### 2.1 AML Customer Risk Profile (Table 50690)

**Purpose**: Maintains comprehensive risk assessment profiles for all customers.

#### Key Fields:
- **Customer No.** (Code[20]): Links to customer account
- **Risk Level** (Enum): Current risk classification
- **Risk Score** (Decimal 0-100): Calculated risk score
- **Risk Level Date/Updated By**: Audit trail for risk assessments
- **Total Deposits/Withdrawals/Loan Amount**: Transaction volume metrics
- **Is PEP** (Boolean): Politically Exposed Person flag
- **PEP Details**: Description of political exposure
- **High Risk Country**: Geographic risk indicator
- **Review Dates**: Scheduled risk assessment reviews

#### Key Procedures:
- `UpdateRiskMetrics()`: Recalculates customer transaction volumes and patterns
- `CalculateRiskScore()`: Applies risk scoring algorithm based on multiple factors

#### Risk Scoring Algorithm:
```
Base Score: Customer Risk Level (10-90 points)
+ High Volume Deposits (>10M): +20 points
+ High Volume Withdrawals (>5M): +15 points
+ High Loan Amounts (>20M): +10 points
+ High Transaction Frequency (>100/month): +15 points
+ PEP Status: +25 points
+ High Risk Country: +20 points
Final Score: Capped at 100 points
```

### 2.2 AML Transaction Monitor (Table 50992)

**Purpose**: Captures and analyzes every financial transaction for suspicious patterns.

#### Key Fields:
- **Entry No.** (Integer): Auto-increment primary key
- **Customer No.** (Code[20]): Transaction originator
- **Transaction Type** (Enum): Category of transaction
- **Transaction Date/Time**: When the transaction occurred
- **Amount/Amount (LCY)**: Transaction value in local currency
- **Risk Score** (Decimal): Calculated risk score for this transaction
- **Alert Generated** (Boolean): Whether this transaction triggered an alert
- **Daily/Monthly Transaction Counts/Amounts**: Velocity metrics
- **Source Table ID/Entry No.**: Links back to original ledger entry

#### Key Procedures:
- `CreateFromSavingsEntry()`: Creates monitoring record from Savings Ledger Entry
- `CreateFromCreditEntry()`: Creates monitoring record from Credit Ledger Entry
- `CalculateTransactionMetrics()`: Computes velocity and pattern metrics
- `AnalyzeTransaction()`: Triggers risk analysis via AML Management codeunit

### 2.3 AML Suspicious Activity (Table 50692)

**Purpose**: Manages investigation workflow for detected suspicious activities.

#### Key Fields:
- **Entry No.** (Integer): Case reference number
- **Customer No.** (Code[20]): Subject of investigation
- **Alert Type** (Enum): Type of suspicious activity detected
- **Status** (Enum): Current investigation status
- **Priority** (Option): Low/Medium/High/Critical priority
- **Description/Detailed Description**: Alert details and investigation notes
- **Transaction Monitor Entry**: Links to triggering transaction
- **Assigned To**: Investigator responsible for the case
- **Due Date**: Required resolution date based on priority
- **Risk Score**: Associated risk score
- **FRC Reference**: External reporting reference number

#### Key Procedures:
- `CreateFromTransactionMonitor()`: Creates case from transaction alert
- `AssignToUser()`: Assigns case to investigator
- `EscalateToManagement()`: Escalates high-priority cases
- `ReportToAuthorities()`: Reports to regulatory authorities
- `CloseCase()`: Closes investigation with resolution notes

### 2.4 AML Setup (Table 50693)

**Purpose**: Configuration parameters for the AML monitoring system.

#### Key Configuration Fields:
- **High Value Threshold** (1M default): Transaction amount triggering high-value alerts
- **Cash Reporting Threshold** (500K default): Regulatory cash reporting limit
- **Max Daily Transactions/Amount**: Velocity monitoring limits
- **Alert Risk Threshold** (70 default): Risk score triggering automatic alerts
- **PEP Alert Threshold** (100K default): Lower threshold for PEP transactions
- **Pattern Deviation Threshold** (200% default): Statistical variance trigger
- **Business Hours**: Normal operating hours for off-hours detection
- **Email Notifications**: Compliance officer contact information

---

## 3. AML MANAGEMENT CODEUNIT (50991)

**Purpose**: Core business logic engine for transaction analysis and risk assessment.

### 3.1 Main Procedures

#### `AnalyzeTransaction(var TransactionMonitor: Record "AML Transaction Monitor")`
**Purpose**: Comprehensive analysis of each transaction for suspicious patterns.

**Process Flow**:
1. Retrieves/creates customer risk profile
2. Calculates transaction-specific risk score
3. Analyzes for suspicious patterns
4. Generates alerts if thresholds breached
5. Creates suspicious activity records

#### `CalculateTransactionRiskScore()`: Returns Decimal
**Purpose**: Applies sophisticated risk scoring algorithm.

**Risk Factors**:
- Customer base risk level (10-90 points)
- High value transactions (+25 points)
- Velocity violations (+20 points for count, +15 for amount)
- Round amount structuring (+10 points)
- Off-hours/weekend transactions (+5 points each)
- Cash transactions (+10 points)
- Cross-border elements (+15 points)
- PEP involvement (+20 points)
- High-risk geography (+15 points)

#### `AnalyzeSuspiciousPatterns()`
**Purpose**: Pattern recognition for different types of suspicious activities.

**Detection Logic**:
1. **High Value**: Exceeds configured threshold
2. **Velocity**: Exceeds daily/monthly transaction limits
3. **Structuring**: Just under reporting thresholds (90-99% of limit)
4. **PEP**: PEP customer above lower threshold
5. **Unusual Pattern**: Statistical deviation from historical behavior
6. **High Risk Score**: Calculated score above alert threshold

### 3.2 Utility Procedures

#### Customer Management:
- `CreateCustomerRiskProfile()`: Initializes new customer risk profile
- `UpdateAllCustomerRiskProfiles()`: Batch update of all customer metrics

#### Transaction Processing:
- `ProcessSavingsTransaction()`: Handles savings account transactions
- `ProcessCreditTransaction()`: Handles loan account transactions

#### Pattern Detection:
- `IsRoundAmount()`: Detects potentially structured round amounts
- `IsWeekendOrHoliday()`: Identifies off-hours transactions
- `IsOffHours()`: Business hours validation
- `DetectUnusualPattern()`: Statistical variance analysis
- `CalculateHistoricalAverage()`: Baseline behavior calculation

### 3.3 Event Subscribers

#### Real-time Integration:
```al
[EventSubscriber(ObjectType::Table, Database::"Savings Ledger Entry", 'OnAfterInsertEvent')]
local procedure OnAfterSavingsEntryInsert(var Rec: Record "Savings Ledger Entry")

[EventSubscriber(ObjectType::Table, Database::"Credit Ledger Entry", 'OnAfterInsertEvent')]
local procedure OnAfterCreditEntryInsert(var Rec: Record "Credit Ledger Entry")
```

**Purpose**: Automatically monitors all transactions as they are posted to the ledgers, ensuring no transaction escapes AML analysis.

---

## 4. SYSTEM WORKFLOW

### 4.1 Transaction Processing Flow

1. **Transaction Posted** → Savings/Credit Ledger Entry created
2. **Event Subscriber Triggered** → AML Management codeunit activated
3. **Transaction Monitor Created** → Record created in AML Transaction Monitor
4. **Risk Analysis Performed** → Risk score calculated and patterns analyzed
5. **Alert Generation** (if applicable) → Suspicious Activity record created
6. **Investigation Workflow** → Case assigned and tracked through resolution

### 4.2 Risk Assessment Process

1. **Customer Onboarding** → Initial risk profile created (Low risk default)
2. **Periodic Review** → Risk profiles updated based on configured frequency
3. **Transaction-based Updates** → Risk scores adjusted based on transaction patterns
4. **PEP/High-Risk Flagging** → Enhanced monitoring applied
5. **Regulatory Reporting** → Suspicious activities reported to authorities

### 4.3 Alert Management Lifecycle

1. **Alert Generation** → Automatic detection creates suspicious activity record
2. **Initial Triage** → Priority assignment and investigator allocation
3. **Investigation** → Analysis of transaction patterns and customer behavior
4. **Resolution** → Classification as false positive, escalation, or reporting
5. **Closure** → Documentation and case closure with audit trail

---

## 5. COMPLIANCE FEATURES

### 5.1 Regulatory Compliance
- **Real-time monitoring** of all financial transactions
- **Threshold-based alerting** for regulatory reporting requirements
- **PEP monitoring** for politically exposed persons
- **Geographic risk assessment** for high-risk jurisdictions
- **Audit trail** for all risk assessments and investigations

### 5.2 Risk Management
- **Customer risk profiling** with regular review cycles
- **Transaction pattern analysis** using statistical methods
- **Velocity monitoring** for unusual activity detection
- **Structuring detection** to identify threshold avoidance
- **False positive management** to reduce investigation overhead

### 5.3 Operational Efficiency
- **Automated monitoring** requiring minimal manual intervention
- **Configurable thresholds** adaptable to regulatory changes
- **Priority-based workflow** for efficient resource allocation
- **Integration points** with existing core banking systems

---

## 6. TECHNICAL IMPLEMENTATION

### 6.1 Object IDs Used
- **Enums**: 50690, 50691, 50692, 50693
- **Tables**: 50690, 50992, 50692, 50693
- **Codeunit**: 50991

### 6.2 Integration Points
- **Savings Ledger Entry**: Real-time monitoring via event subscribers
- **Credit Ledger Entry**: Real-time monitoring via event subscribers
- **Savings Accounts**: Customer information lookup
- **Business Central User Management**: Audit trail and assignment

### 6.3 Data Classification
- All customer data classified as `CustomerContent` per GDPR requirements
- Audit fields tracked for compliance and investigation purposes
- FlowFields used for calculated values to maintain data integrity

---

## 7. NEXT STEPS

### Planned Enhancements (Per Todo List):
1. **Dashboard Pages** - User interface for monitoring and case management
2. **Transaction Processing Integration** - Enhanced event subscriber implementation
3. **Regulatory Reports** - STR generation and compliance reporting
4. **Configuration Interface** - Setup pages for threshold management

### Recommended Operational Procedures:
1. **Daily monitoring** of high-priority alerts
2. **Weekly risk profile reviews** for high-risk customers
3. **Monthly system threshold reviews** and adjustments
4. **Quarterly compliance reporting** to management and regulators

---

## 8. SYSTEM BENEFITS

### For Compliance Officers:
- **Automated detection** reduces manual monitoring workload
- **Risk-based approach** focuses attention on genuine threats
- **Comprehensive audit trails** support regulatory examinations
- **Configurable parameters** adapt to changing regulations

### For Management:
- **Real-time visibility** into institutional money laundering risk
- **Quantitative risk metrics** support decision-making
- **Regulatory compliance** reduces legal and reputational risk
- **Operational efficiency** through automated processes

### For the Institution:
- **Regulatory compliance** meets AML/CFT requirements
- **Risk mitigation** protects against money laundering exposure
- **Competitive advantage** through robust compliance framework
- **Operational excellence** via automated monitoring systems

This comprehensive AML module provides the  SACCO with enterprise-grade anti-money laundering capabilities, ensuring regulatory compliance while maintaining operational efficiency.
