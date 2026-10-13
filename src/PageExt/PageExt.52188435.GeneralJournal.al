
PageExtension 50078 pageextension50078 extends "General Journal"
{
    layout
    {


        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify(AccountName)
        {
            Visible = false;
        }

        modify("Business Unit Code")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        addafter(CurrentJnlBatchName)
        {
            field(GenJnlLineApprovalStatuss; GenJnlLineApprovalStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Status';
                Editable = false;
                //Visible = EnabledGenJnlLineWorkflowsExist;
                ToolTip = 'Specifies the approval status for general journal line.';
            }
        }
        addafter("Transaction Information")
        {
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No."; Rec."Loan No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Account Type")
        {
            field("Member No."; Rec."Member No.")
            {
                ApplicationArea = Basic;
                LookupPageId = "Member Listing";
            }
            field("Member Name"; Rec."Member Name")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }



        modify("Account No.")
        {

            trigger OnLookup(var Text: Text): Boolean
            var
                Members: Record Members;
                Accounts: Record "Savings Accounts";
                Customer: Record Customer;
                Vendor: Record Vendor;
                GLAcc: Record "G/L Account";
                Bank: Record "Bank Account";
            begin
                if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                    Rec."Account No." := '';
                    GLAcc.Reset();
                    if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                        Rec."Account No." := GLAcc."No.";
                end
                else
                    if Rec."Account Type" = Rec."Account Type"::Customer then begin
                        Rec."Account No." := '';
                        Customer.Reset();
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                            Rec."Account No." := Customer."No.";
                    end
                    else
                        if Rec."Account Type" = Rec."Account Type"::Vendor then begin
                            Rec."Account No." := '';
                            Vendor.Reset();
                            if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                Rec."Account No." := Vendor."No.";
                        end
                        else
                            if Rec."Account Type" = Rec."Account Type"::"Bank Account" then begin
                                Rec."Account No." := '';
                                Bank.Reset();
                                if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                    Rec."Account No." := Bank."No.";
                            end

                            else
                                if Rec."Account Type" = Rec."Account Type"::Savings then begin

                                    Rec."Account No." := '';
                                    Accounts.Reset();
                                    if Rec."Member No." <> '' then
                                        Accounts.SetRange("Member No.", Rec."Member No.");
                                    if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                        Rec."Account No." := Accounts."No.";
                                end
                                else
                                    if Rec."Account Type" = Rec."Account Type"::Credit then begin
                                        Members.Reset();
                                        if Rec."Member No." <> '' then
                                            Members.SetRange("No.", Rec."Member No.");
                                        if Page.RunModal(Page::"Member Listing", Members) = Action::LookupOK then
                                            Rec."Account No." := Members."No.";
                                    end;

                Rec.Validate("Account No.");
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        SetUserInteractions();
        ApprovalMgmt.GetGenJnlLineApprovalStatus(Rec, GenJnlLineApprovalStatus, EnabledGenJnlLineWorkflowsExist);
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        GenJnlLineApprovalStatus: Text[50];
        EnabledGenJnlLineWorkflowsExist: Boolean;
}
