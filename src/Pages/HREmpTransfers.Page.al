Page 51135 "HR Emp Transfers"
{
    PageType = List;
    SourceTable = "HR Employee Transfer Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RequestNo; Rec."Request No")
                {
                    ApplicationArea = Basic;
                }
                field(DateRequested; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field(DateApproved; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field(TransferdetailsUpdated; Rec."Transfer details Updated")
                {
                    ApplicationArea = Basic;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = Basic;
                }
                field(ReasonforTransfer; Rec."Reason for Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension1Code; Rec."Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension1Description; Rec."Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension2Code; Rec."Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension2Description; Rec."Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension3Code; Rec."Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension3Description; Rec."Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobID; Rec."New Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobDescription; Rec."New Job Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension1Code; Rec."New Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension1Description; Rec."New Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension2Code; Rec."New Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension2Description; Rec."New Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension3Code; Rec."New Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension3Description; Rec."New Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension4Code; Rec."New Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension4Description; Rec."New Dimension 4 Description")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryNotch; Rec."Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(NewSalaryGrade; Rec."New Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field(NewSalaryNotch; Rec."New Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(EffectiveFrom; Rec."Effective From")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(EffectiveTo; Rec."Effective To")
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

