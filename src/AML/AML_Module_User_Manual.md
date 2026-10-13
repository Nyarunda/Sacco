# AML Module User Manual
## Kentours SACCO Anti-Money Laundering System

### Version 1.0 | January 2026

---

## Table of Contents

1. [Getting Started](#1-getting-started)
2. [User Roles and Permissions](#2-user-roles-and-permissions)
3. [Daily Operations](#3-daily-operations)
4. [Customer Risk Management](#4-customer-risk-management)
5. [Transaction Monitoring](#5-transaction-monitoring)
6. [Alert Investigation](#6-alert-investigation)
7. [Reporting and Compliance](#7-reporting-and-compliance)
8. [System Configuration](#8-system-configuration)
9. [Troubleshooting](#9-troubleshooting)
10. [Best Practices](#10-best-practices)

---

## 1. Getting Started

### 1.1 What is the AML Module?

The AML (Anti-Money Laundering) module is an automated system that monitors all financial transactions at Kentours SACCO to detect suspicious activities and ensure compliance with regulatory requirements. The system operates in real-time, analyzing every transaction as it occurs.

### 1.2 Key Benefits

- **Automatic Monitoring**: Every transaction is automatically analyzed
- **Risk-Based Approach**: Focus on high-risk customers and transactions
- **Regulatory Compliance**: Meet FRC and other regulatory requirements
- **Reduced Manual Work**: Automated alerts reduce manual monitoring
- **Audit Trail**: Complete documentation for regulatory examinations

### 1.3 System Access

The AML module integrates seamlessly with your existing Business Central system. Access is controlled through standard Business Central permissions.

**To access AML functions:**
1. Log into Business Central
2. Navigate to the **AML Management** role center
3. Access specific functions through the ribbon or search

---

## 2. User Roles and Permissions

### 2.1 Compliance Officer
**Primary AML system user responsible for oversight and investigations**

**Key Responsibilities:**
- Review daily alerts and suspicious activities
- Conduct investigations on flagged transactions
- Manage customer risk assessments
- Generate regulatory reports
- Configure system thresholds

**Access Rights:**
- Full read/write access to all AML tables
- Alert assignment and status updates
- Customer risk profile modifications
- System configuration changes
- Reporting functions

### 2.2 AML Investigator
**Staff member assigned to investigate specific cases**

**Key Responsibilities:**
- Investigate assigned suspicious activity cases
- Document investigation findings
- Update case status and resolution notes
- Escalate complex cases to Compliance Officer

**Access Rights:**
- Read access to customer risk profiles
- Write access to assigned suspicious activity cases
- Transaction monitoring data access
- Basic reporting functions

### 2.3 Branch Manager
**Management oversight of AML compliance**

**Key Responsibilities:**
- Review escalated cases
- Approve regulatory reporting decisions
- Monitor overall AML compliance metrics
- Authorize case closures

**Access Rights:**
- Read access to all AML data
- Case approval and escalation rights
- Management reporting access
- Risk threshold review permissions

### 2.4 System Administrator
**Technical configuration and maintenance**

**Key Responsibilities:**
- Configure system parameters
- Manage user permissions
- System maintenance and updates
- Technical troubleshooting

**Access Rights:**
- Full system configuration access
- User permission management
- System setup and maintenance
- Technical diagnostic functions

---

## 3. Daily Operations

### 3.1 Morning Routine Checklist

**For Compliance Officers (Recommended daily tasks):**

1. **Review Overnight Alerts** (5-10 minutes)
   - Check for any Critical or High priority alerts generated overnight
   - Assign urgent cases to investigators
   - Escalate time-sensitive matters

2. **Monitor System Health** (2-3 minutes)
   - Verify AML monitoring is active
   - Check for any system errors or warnings
   - Review transaction processing volumes

3. **Priority Case Updates** (10-15 minutes)
   - Review cases approaching due dates
   - Follow up on pending investigations
   - Update case statuses as needed

### 3.2 How to Access Daily Alerts

1. **Navigate to Suspicious Activities:**
   - Search for "AML Suspicious Activities" in Business Central
   - Or use the direct menu path: `Financial Management > AML > Suspicious Activities`

2. **Filter for Today's Alerts:**
   ```
   Alert Date: Filter = TODAY
   Status: Filter = Open|Investigation Pending|Under Review
   ```

3. **Sort by Priority:**
   - Click on the Priority column
   - Review Critical and High priority items first

### 3.3 Quick Alert Assessment

**For each new alert, perform quick triage:**

1. **Check Alert Type:**
   - High Value: Review transaction amount and context
   - Velocity: Check customer's recent transaction history
   - PEP: Verify customer's political exposure status
   - Unusual: Review pattern deviation details

2. **Assess Urgency:**
   - Critical: Immediate investigation required
   - High: Assign within 24 hours
   - Medium: Assign within 3 days
   - Low: Assign within 1 week

3. **Initial Assignment:**
   - Assign to appropriate investigator
   - Set investigation due date
   - Add preliminary notes if needed

---

## 4. Customer Risk Management

### 4.1 Understanding Risk Levels

**Low Risk (Green):**
- Standard customers with normal transaction patterns
- Regular review cycle: 12 months
- Standard monitoring thresholds apply

**Medium Risk (Yellow):**
- Customers requiring enhanced monitoring
- Regular review cycle: 6 months
- Lower alert thresholds
- Examples: High-volume customers, multiple account holders

**High Risk (Orange):**
- Customers requiring frequent review
- Regular review cycle: 3 months
- Significantly lower alert thresholds
- Examples: Cash-intensive businesses, foreign nationals

**Prohibited (Red):**
- Customers with restricted access
- Transactions may be blocked
- Immediate review required for any activity
- Examples: Sanctioned individuals, proven money launderers

### 4.2 How to Review Customer Risk Profile

1. **Search for Customer:**
   - Navigate to "AML Customer Risk Profiles"
   - Search by Customer No. or Name

2. **Review Key Information:**
   - Current Risk Level and Score
   - Last Review Date and Next Review Due
   - PEP Status and Details
   - Transaction Volume Metrics
   - Historical Risk Score Trends

3. **Update Risk Assessment:**
   - Click "Edit" to modify the profile
   - Update Risk Level if justified
   - Add notes explaining the change
   - Set new review frequency if needed

### 4.3 Conducting Risk Reviews

**Monthly Risk Review Process:**

1. **Generate Review List:**
   ```
   Filter: Next Review Date <= TODAY + 30 days
   Sort by: Next Review Date (ascending)
   ```

2. **For Each Customer:**
   - Review recent transaction activity
   - Check for any new alerts or investigations
   - Verify PEP status and geographic risk
   - Update risk metrics using "Update Risk Metrics" action
   - Assess if risk level change is warranted

3. **Document Review:**
   - Update Last Review Date
   - Add review notes
   - Set next review date
   - Save changes

### 4.4 PEP (Politically Exposed Person) Management

**Identifying PEPs:**
- Government officials and their families
- Senior executives of state-owned enterprises
- Important political party officials
- Senior judicial or military officials

**Enhanced PEP Monitoring:**
1. Flag customer record with PEP status
2. Lower transaction alert thresholds automatically apply
3. Enhanced documentation required for all transactions
4. More frequent risk reviews (quarterly minimum)

---

## 5. Transaction Monitoring

### 5.1 Real-Time Monitoring Dashboard

**To access transaction monitoring:**
1. Navigate to "AML Transaction Monitor"
2. Use filters to focus on specific criteria:
   ```
   Transaction Date: TODAY
   Alert Generated: Yes (to see flagged transactions)
   Customer Risk Level: High (to focus on high-risk customers)
   ```

### 5.2 Understanding Transaction Alerts

**Alert Types and What They Mean:**

1. **High Value Transactions**
   - **Trigger:** Transaction exceeds configured threshold (default: 1M KES)
   - **Action:** Review transaction purpose and supporting documentation

2. **Velocity Alerts**
   - **Trigger:** Unusual frequency or volume of transactions
   - **Check:** Daily transaction count > 20 or daily amount > 5M KES
   - **Action:** Analyze transaction pattern and customer behavior

3. **Structured Transactions**
   - **Trigger:** Multiple transactions just under reporting threshold
   - **Pattern:** Amounts between 450K-499K KES (90-99% of 500K threshold)
   - **Action:** Investigate potential threshold avoidance

4. **Unusual Pattern Alerts**
   - **Trigger:** Statistical deviation from customer's normal behavior
   - **Threshold:** 200% deviation from historical average
   - **Action:** Analyze recent behavior changes

5. **PEP Alerts**
   - **Trigger:** PEP customer transaction above 100K KES
   - **Action:** Enhanced documentation and review required

### 5.3 Transaction Analysis Workflow

**Step 1: Initial Review**
1. Review transaction details (amount, type, date/time)
2. Check customer risk profile
3. Examine recent transaction history
4. Look for supporting documentation

**Step 2: Pattern Analysis**
1. Compare to customer's historical patterns
2. Check for multiple transactions on same day
3. Review geographic or channel anomalies
4. Assess business relationship context

**Step 3: Decision Making**
- **Clear Transaction:** Mark as reviewed, no further action
- **Requires Investigation:** Create suspicious activity case
- **Immediate Concern:** Escalate to management

---

## 6. Alert Investigation

### 6.1 Investigation Process Overview

Every suspicious activity alert follows a structured investigation process:

```
Alert Generated → Assigned → Investigation → Resolution → Closure
```

### 6.2 Starting an Investigation

**Step 1: Case Assignment**
1. Open the suspicious activity record
2. Set "Assigned To" field to investigator
3. Update status to "Investigation Pending"
4. Set appropriate due date based on priority

**Step 2: Initial Assessment**
1. Review triggering transaction details
2. Examine customer background information
3. Check for similar historical alerts
4. Gather relevant documentation

### 6.3 Conducting the Investigation

**Customer Due Diligence:**
1. **Identity Verification:**
   - Verify customer identity documents
   - Check for any name variations or aliases
   - Confirm current address and contact information

2. **Business Relationship Review:**
   - Understand customer's business or employment
   - Review source of funds documentation
   - Assess legitimacy of transaction purposes

3. **Transaction Analysis:**
   - Trace funds source and destination
   - Review supporting documentation
   - Check for business justification
   - Compare to customer's declared activities

**Information Gathering:**
1. **Internal Sources:**
   - Customer account history
   - Previous AML investigations
   - Relationship manager notes
   - Account opening documentation

2. **External Sources (if necessary):**
   - Public records searches
   - Media and internet searches
   - Industry databases
   - Regulatory databases

### 6.4 Investigation Documentation

**Required Documentation:**
1. **Investigation Summary:**
   - Clear description of suspicious activity
   - Investigation steps taken
   - Evidence reviewed
   - Findings and conclusions

2. **Supporting Evidence:**
   - Transaction records and documentation
   - Customer communications
   - External research findings
   - Relevant screenshots or reports

3. **Decision Rationale:**
   - Reasons for classification decision
   - Risk assessment considerations
   - Regulatory compliance factors

### 6.5 Investigation Outcomes

**False Positive:**
- Legitimate activity that triggered automated alert
- Document reasons for false positive classification
- Consider system threshold adjustments if necessary
- Update case status to "False Positive"

**Legitimate Concern - Internal Action:**
- Suspicious pattern but not requiring external reporting
- Enhanced monitoring may be implemented
- Customer education or account restrictions possible
- Update case status to "Cleared"

**Suspicious Activity - Reporting Required:**
- Activity meets regulatory reporting thresholds
- Prepare Suspicious Transaction Report (STR)
- Report to relevant authorities (FRC)
- Update case status to "Reported to Authorities"

---

## 7. Reporting and Compliance

### 7.1 Regulatory Reporting Requirements

**Suspicious Transaction Reports (STRs):**
- Required for all transactions meeting regulatory thresholds
- Must be filed within 7 days of detection
- Include detailed investigation findings
- Maintain strict confidentiality

**Threshold Reports:**
- Cash transactions over 500K KES
- Cross-border transfers over specified amounts
- Regular reporting to Central Bank and FRC

### 7.2 Generating STR Reports

**Step 1: Prepare Report Data**
1. Open suspicious activity record
2. Ensure investigation is complete
3. Verify all supporting documentation
4. Review management approval

**Step 2: STR Completion**
1. Access STR reporting function
2. Complete all required fields:
   - Customer identification details
   - Transaction details and amounts
   - Reason for suspicion
   - Investigation summary
   - Supporting documentation references

3. Management review and approval
4. Submit to regulatory authorities
5. Update case with FRC reference number

### 7.3 Management Reporting

**Daily Reports:**
- New alerts summary
- High priority cases status
- System performance metrics

**Weekly Reports:**
- Investigation case pipeline
- Resolution statistics
- Trending analysis

**Monthly Reports:**
- Comprehensive compliance dashboard
- Risk assessment summaries
- Regulatory reporting statistics
- System effectiveness metrics

**Annual Reports:**
- AML program effectiveness assessment
- Risk trend analysis
- Training and awareness summaries
- Regulatory compliance certification

---

## 8. System Configuration

### 8.1 AML Setup Configuration

**Accessing Setup:**
1. Navigate to "AML Setup"
2. Configure key parameters (Compliance Officer access required)

**Key Configuration Parameters:**

**Transaction Thresholds:**
```
High Value Threshold: 1,000,000 KES (default)
Cash Reporting Threshold: 500,000 KES (regulatory requirement)
PEP Alert Threshold: 100,000 KES (enhanced monitoring)
```

**Velocity Limits:**
```
Max Daily Transactions: 20 (default)
Max Daily Amount: 5,000,000 KES (default)
Max Monthly Transactions: 100 (default)
Max Monthly Amount: 20,000,000 KES (default)
```

**Risk Assessment:**
```
Alert Risk Threshold: 70 points (auto-alert trigger)
Pattern Deviation Threshold: 200% (statistical variance)
```

**Operational Parameters:**
```
Business Hours Start: 08:00 AM
Business Hours End: 05:00 PM
Enable Real-time Monitoring: Yes
Auto Generate Alerts: Yes
Send Email Notifications: Yes
```

### 8.2 User Configuration

**Setting Up Users:**
1. Navigate to "Users" in Business Central
2. Assign appropriate AML permissions:
   - AML-COMPLIANCE-OFFICER: Full AML access
   - AML-INVESTIGATOR: Investigation access
   - AML-MANAGER: Management reporting access
   - AML-ADMIN: System configuration access

**Email Notifications:**
1. Configure SMTP settings in Business Central
2. Set up notification recipients in AML Setup:
   - Compliance Officer Email
   - AML Manager Email

---

## 9. Troubleshooting

### 9.1 Common Issues and Solutions

**Issue: Alerts Not Being Generated**
- **Check:** Verify "Enable Real-time Monitoring" is active
- **Check:** Confirm transaction thresholds are properly set
- **Check:** Verify event subscribers are functioning
- **Solution:** Contact system administrator

**Issue: False Positive Rate Too High**
- **Analysis:** Review alert types generating most false positives
- **Solution:** Adjust thresholds in AML Setup
- **Solution:** Refine customer risk profiles
- **Solution:** Update pattern deviation parameters

**Issue: Investigation Backlog Building**
- **Analysis:** Review investigator workload distribution
- **Solution:** Reassign cases to balance workload
- **Solution:** Adjust priority classifications
- **Solution:** Consider additional investigator resources

**Issue: Customer Complaints About Monitoring**
- **Education:** Explain regulatory requirements
- **Documentation:** Ensure proper customer notification
- **Review:** Assess if customer risk level is appropriate
- **Escalation:** Involve senior management if necessary

### 9.2 Performance Optimization

**System Performance:**
- Regularly review and archive old investigation cases
- Monitor database performance with high transaction volumes
- Schedule risk profile updates during off-peak hours
- Optimize filtering and search parameters

**User Experience:**
- Train users on efficient navigation and filtering
- Provide quick reference guides for common tasks
- Regular refresher training on new features
- Feedback collection and system improvement

---

## 10. Best Practices

### 10.1 Daily Operations

**Morning Routine:**
- Review overnight alerts within 30 minutes of starting work
- Prioritize Critical and High-priority cases
- Check system health and transaction processing status
- Respond to any urgent escalations immediately

**Investigation Quality:**
- Document all investigation steps thoroughly
- Maintain objective, factual investigation notes
- Seek supervisory guidance on complex cases
- Ensure timely completion within due dates

**Customer Interaction:**
- Maintain confidentiality of AML investigations
- Professional, courteous customer communication
- Explain regulatory requirements when necessary
- Never disclose investigation details to customers

### 10.2 Risk Management

**Customer Risk Assessment:**
- Regular review of customer risk profiles
- Prompt updates based on new information
- Enhanced monitoring for high-risk customers
- Proper documentation of risk decisions

**Threshold Management:**
- Regular review of system thresholds
- Adjustment based on regulatory changes
- Consideration of false positive rates
- Balancing compliance with operational efficiency

### 10.3 Regulatory Compliance

**Documentation Standards:**
- Complete, accurate investigation records
- Timely STR submissions
- Proper approval workflows
- Secure storage of sensitive information

**Training and Awareness:**
- Regular AML training for all staff
- Updates on regulatory changes
- System user training and refreshers
- Industry best practice awareness

**Audit Preparation:**
- Regular internal compliance reviews
- Document retention procedures
- System control testing
- Regulatory examination readiness

### 10.4 Continuous Improvement

**System Effectiveness:**
- Regular review of alert quality and investigation outcomes
- Analysis of false positive trends
- User feedback collection and implementation
- Technology and process improvements

**Risk Assessment:**
- Periodic review of institutional money laundering risk
- Industry and geographic risk factor updates
- Customer base risk profiling analysis
- Regulatory requirement gap analysis

---

## Contact Information

**For System Support:**
- IT Help Desk: [Contact Information]
- System Administrator: [Contact Information]

**For AML Compliance Questions:**
- Compliance Officer: [Contact Information]
- AML Manager: [Contact Information]

**For Emergency Escalation:**
- Senior Management: [Contact Information]
- External Legal Counsel: [Contact Information]

---

## Appendices

### Appendix A: Quick Reference Card
[One-page summary of key procedures and contacts]

### Appendix B: Regulatory References
[Links to relevant FRC guidelines and regulations]

### Appendix C: Investigation Checklist
[Step-by-step investigation checklist template]

### Appendix D: STR Filing Guide
[Detailed STR completion instructions]

---

*This user manual is a living document and will be updated as the system evolves and regulatory requirements change. Please ensure you are using the latest version.*

**Document Version:** 1.0  
**Last Updated:** January 5, 2026  
**Next Review Date:** July 5, 2026
