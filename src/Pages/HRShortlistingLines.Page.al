Page 50916 "HR Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    Editable = false;
    PageType = ListPart;
    SourceTable = "HR Shortlisted Applicants";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualified';

                    trigger OnValidate()
                    begin
                        Rec."Manual Change" := true;
                        Rec.Modify;
                    end;
                }
                field(JobApplicationNo; Rec."Job Application No")
                {
                    ApplicationArea = Basic;
                }
                field(FullName; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;


    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

