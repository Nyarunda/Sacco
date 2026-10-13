
Page 50236 "EFT Lines"
{
    PageType = ListPart;
    SourceTable = "EFT Lines.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(RecordTotal; Rec."Record Total")
                {
                    ApplicationArea = Basic;
                }
                field(RecordCount; Rec."Record Count")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentType; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(DateFilter; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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
                field(DateTransferred; Rec."Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field(TimeTransferred; Rec."Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field(TransferredBy; Rec."Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryProcessingNo; Rec."Salary Processing No.")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryOptions; Rec."Salary Options")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCentre; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field(StandingOrderEFTDone; Rec."Standing Order EFT Done")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNoFilter; Rec."Document No. Filter")
                {
                    ApplicationArea = Basic;
                }
                field(SwiftCode; Rec."Swift Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

