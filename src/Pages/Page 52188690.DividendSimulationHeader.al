Page 50353 "Dividend Simulation Header"
{
    PageType = Document;
    SourceTable = "Dividend Simulation Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(AllProducts; Rec."All Products")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(GLAccount; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Deposits; Rec.Deposits)
                {
                    ApplicationArea = Basic;
                }
                field(WeightedAmount; Rec."Weighted Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalPay; Rec."Total Pay")
                {
                    ApplicationArea = Basic;
                }
                field(TotalWTax; Rec."Total W/Tax")
                {
                    ApplicationArea = Basic;
                }
                field(TotalNet; Rec."Total Net")
                {
                    ApplicationArea = Basic;
                }
                field(TotalPayout; Rec."Total Payout")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        CurrPage.Update(true);
                    end;
                }
            }
            part(Control1; "Dividend Simulation Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Simulation)
            {
                Caption = 'S&imulation';
                Image = "Order";
                action(Dividends)
                {
                    ApplicationArea = Basic;
                    Caption = 'Simulate Dividends';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        DividendPeriod: Integer;
                        DividendAccount: Code[20];
                        ErrDivPeriod: label 'Dividend Period cannot be Zero';
                        ErrDivAccount: label 'A Dividend Account is Expected';
                        MsgComplete: label 'Simulation Complete Enter the Total Amount available to calculate the Dividend Rate ';
                    begin
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        GetSavingsContribution.getDividendRate(Rec);
                        Message(MsgComplete);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action("Calculate Overall Dividends")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Dividends';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Visible = false;
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(Posting)
            {
                Caption = 'P&osting';
                Image = Post;
                action("Remove From Job Queue")
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        //CancelBackgroundPosting;
                    end;
                }
                action("Preview Dividends")
                {
                    ApplicationArea = Basic;
                    Caption = 'Preview Dividends';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        JobQueueVisible: Boolean;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        GetSavingsContribution: Codeunit "Member Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

