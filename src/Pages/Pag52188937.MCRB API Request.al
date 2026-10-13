
page 50640 "MCRB API Request List"
{
    PageType = List;
    SourceTable = "MCRB API Request";
    ApplicationArea = All;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("RequestID"; Rec."RequestID")
                {
                    ApplicationArea = All;
                }
                field("ReportType"; Rec."ReportType")
                {
                    ApplicationArea = All;
                }
                field("IdentityNumber"; Rec."IdentityNumber")
                {
                    ApplicationArea = All;
                }
                field("IdentityType"; Rec."IdentityType")
                {
                    ApplicationArea = All;
                }
                field("LoanAmount"; Rec."LoanAmount")
                {
                    ApplicationArea = All;
                }
                field("ReportReason"; Rec."ReportReason")
                {
                    ApplicationArea = All;
                }
                field(MobileScore; Rec.MobileScore)
                {
                    ApplicationArea = All;
                }
            }
        }

        area(factboxes)
        {

            part(Control3; "MCRB Integration Log")
            {
                ApplicationArea = BasicHR;
                SubPageLink = RequestID = field(RequestID);
            }
        }

    }

    actions
    {
        area(processing)
        {
            action(SubmitReport)
            {
                Caption = 'Request Report';
                Image = Sales;
                trigger OnAction()
                var
                    MCRBIntegration: Codeunit "MCRB API Integration";
                    Loans: Record Loans;
                begin
                    if Loans.Get(Rec."LoanNo") then
                        Rec."LoanAmount" := Loans."Approved Amount";

                    Rec."ReportReason" := 1;
                    // Call ProcessReport using the values from the current record.
                    MCRBIntegration.ProcessReport(
                        '',
                        '',
                        Rec.RequestID,
                        Rec."ReportType",
                        Rec."IdentityNumber",
                        Rec."IdentityType",
                        Rec."LoanAmount",
                        Rec."ReportReason",
                        Rec.MobileScore
                    );
                    //Message('Request Done');
                end;
            }
        }
    }



}

