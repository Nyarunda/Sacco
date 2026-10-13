Page 51042 "HR Employment HistoryLines"
{
    Caption = 'Employment History Lines';
    PageType = List;
    SourceTable = "HR Employment History";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(CompanyName; Rec."Company Name")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field(ToDate; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(KeyExperience; Rec."Key Experience")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryOnLeaving; Rec."Salary On Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(PostalAddress; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field(Address2; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(ReasonForLeaving; Rec."Reason For Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
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

