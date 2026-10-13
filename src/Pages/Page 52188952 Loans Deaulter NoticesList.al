page 50654 "Loans Deaulter Notices List"
{
    Caption = 'Loans Deaulter Notices List';
    PageType = List;
    SourceTable = "Loans Defaulter Notices";
    Editable = true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                    LookupPageID = "Member Listing";
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product field.';
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Name field.';
                }
                field(Notice; Rec.Notice)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Noticee field.';
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date notice sent field.';
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent field.';
                }

            }
        }
    }
    actions
    {

        area(processing)
        {
            group(GenerateEntries)
            {

                action(Generate)
                {
                    ApplicationArea = Basic;
                    Image = GetLines;
                    PromotedCategory = Process;
                    Promoted = true;
                    RunObject = report "Generate Defaulter Notices";
                    PromotedIsBig = true;

                }
                action("Generate Notice-1")
                {
                    ApplicationArea = Basic;
                    Image = GetLines;
                    PromotedCategory = Process;
                    Promoted = true;
                    RunObject = report "Generate Defaulter Notice-1";
                    PromotedIsBig = true;

                }
                action("Generate Notice-2")
                {
                    ApplicationArea = Basic;
                    Image = GetLines;
                    PromotedCategory = Process;
                    Promoted = true;
                    RunObject = report "Generate Defaulter Notice-2";
                    PromotedIsBig = true;

                }
                action("Generate Notice-3")
                {
                    ApplicationArea = Basic;
                    Image = GetLines;
                    PromotedCategory = Process;
                    Promoted = true;
                    RunObject = report "Generate Defaulter Notice-3";
                    PromotedIsBig = true;

                }
                action("Statutory Notice-1")
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    PromotedCategory = Process;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanRec: Record Loans;
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange("Loan No.", Rec."Loan No");
                        if LoanRec.FindFirst() then
                            Report.Run(Report::"Statutory Notice-1", true, false, LoanRec);
                    end;
                }
                action("First Demand Letter Savings")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Demand Letter-Loan Within Savings';
                    Image = Print;
                    PromotedCategory = Process;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanRec: Record Loans;
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange("Loan No.", Rec."Loan No");
                        if LoanRec.FindFirst() then
                            Report.Run(Report::"First Demand Letter Savings", true, false, LoanRec);
                    end;
                }
                action("First Demand Letter Security")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Demand Letter - With Security';
                    Image = Print;
                    PromotedCategory = Process;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanRec: Record Loans;
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange("Loan No.", Rec."Loan No");
                        if LoanRec.FindFirst() then
                            Report.Run(Report::"First Demand Letter Security", true, false, LoanRec);
                    end;
                }
                action("Approve to Send")
                {
                    ApplicationArea = All;
                    Caption = 'Approve to Send';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec."Notice Sent" then
                            Error('This notice has already been sent.');

                        Rec."Approved to Send" := true;
                        Rec.Modify(true);
                        CurrPage.Update(false);

                        Message('Notice approved. It will be sent on the next run.');
                    end;
                }
            }
        }
    }

}

