page 50389 "Exit Loan Guarantors"
{
    Caption = 'Exit Loan Guarantors';
    PageType = ListPart;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Loan Security";
    SourceTableView = where("Outstanding Principal" = filter(> 0), Substituted = filter(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loanee Name field.';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Type field.';
                }
                field("Loan Type Name"; Rec."Loan Type Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Type Name field.';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Guaranteed field.';
                }
                field("Current Committed"; Rec."Current Committed")
                {
                    ApplicationArea = All;
                    Caption = 'Current Obligation';
                    ToolTip = 'Specifies the value of the Current Committed field.';
                }
            }
        }
    }



    actions
    {
        area(processing)
        {
            action(ReplaceGuarantor)
            {
                ApplicationArea = Basic;
                Caption = 'Replace Guarantor';
                Image = SendApprovalRequest;


                trigger OnAction()
                var
                    SubHeader: Record "Security Sub.";
                    SubLines: Record "Security Sub. Lines";
                    Loans: Record Loans;
                    ProductFactory: Record "Service Item";
                    SavingsAccountRegistration: Record "Service Item";
                    DocumentType: Enum "Custom Document Type";
                    VarVariant: Variant;
                    CalwideApprovals: Codeunit "Calwide Approvals";
                begin
                    if Rec."Sub. No." = '' then
                        if Confirm('Are you sure you want to open guarantor substitution for this loan?') then begin
                            Loans.Get(Rec."Loan No.");
                            SubHeader.Init();
                            SubHeader."No." := '';
                            SubHeader.Insert(true);
                            SubHeader.validate("Member No.", Loans."Member No.");
                            SubHeader.Validate("Loan No.", Loans."Loan No.");
                            SubHeader.Modify();
                            Rec."Sub. No." := SubHeader."No.";
                            Rec.Modify();
                        end
                        else
                            Error('Aborted');

                    SubHeader.Reset();
                    SubHeader.SetRange("No.", Rec."Sub. No.");
                    if SubHeader.FindFirst() then
                        Page.Run(50281, SubHeader);
                end;
            }
        }
    }
}

