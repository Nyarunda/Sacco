Page 50846 "HR Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            field(GeneralInfo; GeneralInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field(JobApplicationNo; Rec."Job Application No.")
            {
                ApplicationArea = Basic;
            }
            field(DateApplied; Rec."Date Applied")
            {
                ApplicationArea = Basic;
            }
            field(FirstName; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field(MiddleName; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field(LastName; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field(Qualified; Rec.Qualified)
            {
                ApplicationArea = Basic;
            }
            field(InterviewInvitationSent; Rec."Interview Invitation Sent")
            {
                ApplicationArea = Basic;
            }
            field(IDNumber; Rec."ID Number")
            {
                ApplicationArea = Basic;
            }
            field(PersonalInfo; PersonalInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(Age; Rec.Age)
            {
                ApplicationArea = Basic;
            }
            field(MaritalStatus; Rec."Marital Status")
            {
                ApplicationArea = Basic;
            }
            field(CommunicationInfo; CommunicationInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field(CellPhoneNumber; Rec."Cell Phone Number")
            {
                ApplicationArea = Basic;
                //ExtendedDatatype = PhoneNo;
            }
            field(EMail; Rec."E-Mail")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = EMail;
            }
            field(WorkPhoneNumber; Rec."Work Phone Number")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = PhoneNo;
            }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: label 'General Applicant Information';
        PersonalInfo: label 'Personal Infomation';
        CommunicationInfo: label 'Communication Information';
}

