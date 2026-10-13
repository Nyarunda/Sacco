page 50521 "Vendor Quotation Card"
{
    SourceTable = "Vendor Quotation Header";
    PageType = Card;

    layout
    {
        area(Content)
        {
             group(General)
            {
                Caption = 'General';
                field("Quotation No."; Rec."Quotation No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quotation number.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                    Editable = false;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related RFQ number.';
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quotation submission date.';
                }
                field("Delivery Timeframe"; Rec."Delivery Timeframe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the promised delivery date used for delivery scoring.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quotation status.';
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total quoted amount.';
                    Editable = false;
                }
            }

            group("RFQ Matrix Scores")
            {
                Caption = 'RFQ Matrix Scores';
                field("Statutory Score"; Rec."Statutory Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter statutory compliance score (0 to 10).';
                }
                field("Quality Score"; Rec."Quality Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter quality assessment score (0 to 35).';
                }
                field("Delivery Score"; Rec."Delivery Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows auto-calculated delivery score (0, 2.5, or 5).';
                    Editable = false;
                }
                field("Pricing Score"; Rec."Pricing Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows auto-calculated RFQ pricing score (0 to 50).';
                    Editable = false;
                }
            }

            group("RFP Matrix Scores")
            {
                Caption = 'RFP Matrix Scores';
                field("Technical Capability Score"; Rec."Technical Capability Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter technical capability score (0 to 50).';
                }
                field("Track Record Score"; Rec."Track Record Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter track record score (0 to 10).';
                }
                field("RFP Price Score"; Rec."RFP Price Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows auto-calculated RFP price score (0 to 40).';
                    Editable = false;
                }
            }

            group(Result)
            {
                Caption = 'Result';
                field("Evaluation Score"; Rec."Evaluation Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total computed score used for ranking.';
                    Editable = false;
                }
                field(Ranking; Rec.Ranking)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the computed ranking among qualified quotations.';
                    Editable = false;
                }
                field(Disqualified; Rec.Disqualified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this quotation is disqualified by evaluation rules.';
                    Editable = false;
                }
                field("Disqualification Reason"; Rec."Disqualification Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies why this quotation was disqualified.';
                    Editable = false;
                }
                field("Award Letter Sent"; Rec."Award Letter Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the award letter has been sent.';
                    Editable = false;
                }
                field("Regret Letter Sent"; Rec."Regret Letter Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the regret letter has been sent.';
                    Editable = false;
                }
            }

            part(Lines; "Vendor Quotation Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Quotation No." = field("Quotation No.");
            }
        }
    }


}