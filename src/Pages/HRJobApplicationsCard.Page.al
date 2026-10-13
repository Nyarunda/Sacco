Page 50862 "HR Job Applications Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Other Details,Job Details';
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(DateApplied; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(ApplicantType; Rec."Applicant Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationReffNo; Rec."Employee Requisition No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Reff No.';
                    Importance = Promoted;
                }
                field(PositionAppliedFor; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                    Caption = 'Position Applied For';
                    Editable = false;
                    Enabled = true;
                    Importance = Promoted;
                }
                field(JobAppliedforDescription; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }

                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }

                group(Control20)
                {
                    Caption = 'Languages';
                    grid(Control19)
                    {
                        GridLayout = Rows;
                        group(Control17)
                        {
                            Caption = '';
                            field("1stLanguageRWS"; Rec."First Language (R/W/S)")
                            {
                                ApplicationArea = Basic;
                                Caption = '1st Language (R/W/S)';
                                Importance = Promoted;
                                StyleExpr = true;
                            }
                            field(R; Rec."First Language Read")
                            {
                                ApplicationArea = Basic;
                                Caption = 'R';
                            }
                            field(W; Rec."First Language Write")
                            {
                                ApplicationArea = Basic;
                                Caption = 'W';
                            }
                            field(S; Rec."First Language Speak")
                            {
                                ApplicationArea = Basic;
                                Caption = 'S';
                            }
                            field("2ndLanguageRWS"; Rec."Second Language (R/W/S)")
                            {
                                ApplicationArea = Basic;
                                Caption = '2nd Language (R/W/S)';
                                Importance = Promoted;
                            }
                            field(SecondLanguageRead; Rec."Second Language Read")
                            {
                                ApplicationArea = Basic;
                                Caption = 'R';
                            }
                            field(SecondLanguageWrite; Rec."Second Language Write")
                            {
                                ApplicationArea = Basic;
                                Caption = 'W';
                            }
                            field(SecondLanguageSpeak; Rec."Second Language Speak")
                            {
                                ApplicationArea = Basic;
                                Caption = 'S';
                            }
                            field(AdditionalLanguage; Rec."Additional Language")
                            {
                                ApplicationArea = Basic;
                            }
                        }
                    }
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field(PostCode; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(PostalAddress; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(ResidentialAddress; Rec."Residential Address")
                {
                    ApplicationArea = Basic;
                }
                field(HomePhoneNumber; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(CellPhoneNumber; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(WorkPhoneNumber; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                }

                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }

                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Country Details"; Rec."Citizenship Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }

                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(DocumentStatus; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(ProposedSalary; Rec."Proposed Salary")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control3; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(OtherDetails)
            {
                Caption = 'Other Details';
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = field("Job Application No.");
                }
                action(Referees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = field("Job Application No.");
                }
                action(Hobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = field("Job Application No.");
                }
            }
            group(JobDetails)
            {
                Caption = 'Job Details';
                action(Requirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job ID" = field("Job Applied For");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job Applied For");
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Applicant Type":="Applicant Type"::Internal;
    end;

    var
        HRJobApplications: Record "HR Job Applications";
        //SMTP: Codeunit UnknownCodeunit400;
        //HREmailParameters: Record UnknownRecord39003942;
        Employee: Record Employee;
        Text19064672: label 'Shortlisting Summary';
        DAge: Text[100];
        Text0000: label '                     ';
}

