page 50363 "Portal Loans List"
{
    ApplicationArea = All;
    Caption = 'Portal Loans';
    PageType = List;
    SourceTable = "Portal Loans";
    CardPageId = "Portal Loans Card";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Loan Name"; Rec."Loan Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Name field.';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Amount field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("Loan Period"; Rec."Loan Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Period field.';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Remarks; Rec.Remarks)
                {

                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telephone No field.';
                }
            }
        }
    }
    actions
    {
        /* area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Documents)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PortalDocs: Record "Portal Uploads";
                    begin
                        PortalDocs.Reset();
                        PortalDocs.SetRange("Loan Application No.", Rec."Application No.");
                        if PortalDocs.FindFirst() then begin
                            Page.Run(Page::"Portal Uploads", PortalDocs);
                        end;

                    end;
                }
                action("Loan Security")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PortalDocs: Record "Portal Guarantors";
                    begin
                        PortalDocs.Reset();
                        PortalDocs.SetRange("Loan Entry No.", Rec."Application No.");
                        if PortalDocs.FindFirst() then begin
                            Page.Run(Page::"Portal Guarantors", PortalDocs);
                        end;

                    end;
                }
                action("Send To Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Loans: Record Loans;
                        LoanProduct: Record "Product Setup";
                        PortalGuarantors: Record "Portal Guarantors";
                        LoanSecurity: Record "Loan Security";
                        Legacy: COdeunit Legacy;
                        Members: Record Members;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        Loans.Reset();
                        Loans.SetRange("Portal Loan Code", Rec."Application No.");
                        if Loans.FindFirst() then begin
                            Error('Already Transfered to Loan Applications: %1', Loans."Loan No.");
                        end;

                        if Confirm('Are you sure you want to send this loan to Applications?') then begin


                            LoanProduct.Get(Rec."Loan Product Type");
                            Loans.Init;
                            Loans."Portal Loan" := true;
                            Loans."Loan No." := '';
                            Loans."Application Date" := DT2Date(Rec.Date);
                            Loans.Validate("Member No.", Rec."Member No.");
                            Loans.validate("Loan Product Type", LoanProduct."Product ID");
                            Loans.validate("Requested Amount", Rec."Requested Amount");
                            Loans."Disbursement Date" := Today;
                            Loans."Portal Loan Code" := Rec."Application No.";
                            Loans.validate(Installments, LoanProduct."Default Installments");
                            Loans.Insert(true);


                            Rec."Loan No." := Loans."Loan No.";


                            Rec.Modify();

                            PortalGuarantors.Reset();
                            PortalGuarantors.SetRange("Loan Entry No.", Rec."Application No.");
                            if PortalGuarantors.FindFirst() then begin
                                repeat
                                    if members.Get(PortalGuarantors."Guarantor Member No.") then begin


                                        LoanSecurity.Init();
                                        LoanSecurity."Loan No." := Loans."Loan No.";
                                        LoanSecurity."Guarantor Type" := LoanSecurity."Guarantor Type"::Guarantor;
                                        LoanSecurity.Validate("Account No.", Legacy.GetDepositAccount(PortalGuarantors."Guarantor Member No."));
                                        LoanSecurity.Validate("Amount Guaranteed", PortalGuarantors."Amount Guaranteed");
                                        LoanSecurity.Insert();

                                    end;
                                until PortalGuarantors.Next() = 0;
                            end;
                            Message('Loan Application Created: Loan No. %1', Rec."Loan No.");
                        end;
                    end;

                }


                action("Reject Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Loans: Record Loans;
                        PortalLoans: Record "Portal Loans";
                        LoanProduct: Record "Product Setup";
                        RejectPortalLoan: Page "Reject Portal Loan Application";

                    begin

                        if Confirm('Are you sure you want to Reject this Applications?') then begin

                            PortalLoans.Reset();
                            PortalLoans.SetRange("Application No.", Rec."Application No.");
                            if PortalLoans.FindFirst() then begin
                                Page.Run(50364, PortalLoans);
                            end;
                        end;
                    end;
                }

                action("Test Reject All")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Loans: Record Loans;
                        PortalLoans: Record "Portal Loans";
                        LoanProduct: Record "Product Setup";
                        RejectPortalLoan: Page "Reject Portal Loan Application";

                    begin

                        if Confirm('Are you sure you want to Reject this Applications?') then begin

                            PortalLoans.Reset();
                            PortalLoans.SetRange("Member No.", rec."Member No.");
                            PortalLoans.SetFilter(Status, '<>%1', PortalLoans.Status::Failed);
                            if PortalLoans.FindFirst() then begin
                                PortalLoans.Modifyall(PortalLoans.Status, PortalLoans.Status::Failed)
                            end;
                        end;
                    end;
                }
            }
        } */
    }

}
