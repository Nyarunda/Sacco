
PageExtension 50115 pageextension50115 extends "Employee Card"
{
    layout
    {
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = BasicHR;
        }
        modify("E-Mail")
        {
            Caption = 'Personal Email';
        }
        modify("Phone No.2")
        {
            ApplicationArea = BasicHR;
            Visible = false;
        }
        modify("Address 2")
        {
            ApplicationArea = BasicHR;
            Visible = false;
        }
        modify("Bank Account No.")
        {
            ApplicationArea = BasicHR;

        }
        modify(County)
        {
            ApplicationArea = BasicHR;
            Visible = true;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("Alt. Address Code")
        {
            Visible = false;
        }
        modify("Alt. Address Start Date")
        {
            Visible = false;
        }
        modify("Alt. Address End Date")
        {
            Visible = false;
        }
        modify(ShowMap)
        {
            Visible = false;
        }
        modify("Grounds for Term. Code")
        {
            Visible = false;
        }
        modify("Emplymt. Contract Code")
        {
            Visible = false;
        }
        modify("Statistics Group Code")
        {
            Visible = false;
        }
        modify("Resource No.")
        {
            Visible = false;
        }

        modify("Social Security No.")
        {
            Visible = false;
        }
        modify("Union Code")
        {
            Visible = false;
        }
        modify("Union Membership No.")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }


        modify(Iban)
        {
            Visible = false;
        }
        modify("Job Title")
        {
            Visible = false;
        }
        modify("SWIFT Code")
        {
            Visible = false;
        }
        modify("Board Member")
        {
            Visible = false;
        }
        modify(Payroll)
        {
            Visible = false;
        }
        addafter("Last Name")
        {
            field("Member No"; Rec."Member No")
            {
                ApplicationArea = BasicHR;
                LookupPageID = "Member Listing";
            }
        }
        addafter("Birth Date")
        {
            field(Age; Rec.Age)
            {
                ApplicationArea = All;
            }
        }
        addafter("Privacy Blocked")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = BasicHR;
            }
            field("Last Employer Name"; Rec."Last Employer Name")
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            field("Last Employer Phone"; Rec."Last Employer Phone")
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            field("Last Employer Email"; Rec."Last Employer Email")
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            field("Last Employer Address"; Rec."Last Employer Address")
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            field("Interests & Hobbies"; Rec."Interests & Hobbies")
            {
                ApplicationArea = BasicHR;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = BasicHR;

                trigger OnValidate()
                begin
                    UpdateSpouseDetailsVisibility();
                end;
            }
            field(District; Rec.District)
            {
                ApplicationArea = BasicHR;
                Caption = 'County';
            }
            field(Location; Rec.Location)
            {
                ApplicationArea = BasicHR;

            }
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = BasicHR;
            }
            field("Supervisor Code"; Rec."Supervisor Code")
            {
                ApplicationArea = BasicHR;
            }
            field("Location County"; Rec."Location County")
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            field("Sub-Location"; Rec."Sub-Location")
            {
                ApplicationArea = BasicHR;
                Caption = 'Landmark';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = Basic;
            }

        }
        addbefore("Employment Date")
        {
            field(ContractStartDate; Rec."Contract Start Date")
            {
                ApplicationArea = BasicHR;
            }
            field(ContractEndDate; Rec."Contract End Date")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Marital Status")
        {
            group("Spouse Details")
            {
                Caption = 'Spouse Details';
                Visible = ShowSpouseDetails;

                field("Spouse Name"; Rec."Spouse Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Spouse Contact No."; Rec."Spouse Contact No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Spouse Email"; Rec."Spouse Email")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
        addafter("Birth Date")
        {
            field("Personal ID No."; Rec."Personal ID No.")
            {
                ApplicationArea = BasicHR;
            }
            field(PIN; Rec.PIN)
            {
                ApplicationArea = BasicHR;
            }
            field("NSSF No."; Rec."NSSF No.")
            {
                ApplicationArea = BasicHR;
            }
            field("NHIF No."; Rec."NHIF No.")
            {
                ApplicationArea = BasicHR;
            }
            field("HELB No."; Rec."HELB No.")
            {
                ApplicationArea = BasicHR;
            }
            field("Passport No."; Rec."Passport No.")
            {
                ApplicationArea = BasicHR;
            }

        }
        addafter("Employee Posting Group")
        {
            field("Bank Code"; Rec."Bank Code")
            {
                ApplicationArea = BasicHR;
            }
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter(Payments)
        {
            group(Contract)
            {
                field("Years of Service"; Rec."Years of Service")
                {
                    ApplicationArea = BasicHR;
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = BasicHR;
                }
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                    ApplicationArea = BasicHR;
                }
                field("Probation End Date"; Rec."Probation End Date")
                {
                    ApplicationArea = BasicHR;
                }
                field("Salary Increment Month"; Rec."Salary Increment Month")
                {
                    ApplicationArea = BasicHR;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = BasicHR;
                }
            }
        }

        addafter("Job Title")
        {
            field("Job ID"; Rec."Job ID")
            {
                ApplicationArea = BasicHR;
            }
            field("Job Description"; Rec."Job Description")
            {
                ApplicationArea = BasicHR;
                Caption = 'Job Designation';
            }
            field("Job Reference"; Rec."Job Reference")
            {
                ApplicationArea = BasicHR;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = BasicHR;
            }
        }

        addafter(Control3)
        {
            part("Leave Statistics"; "HR Leave Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
        moveafter("Job Title"; "Salespers./Purch. Code")
        moveafter("Employee Posting Group"; "Bank Account No.")
    }
    actions
    {
        modify("E&mployee")
        {

            Caption = 'Attachments';
            ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

        }


        modify("Co&nfidential Info. Overview")
        {
            Caption = 'Co&mments';
            ToolTip = 'View or add comments for the record.';
            ApplicationArea = Comments;


        }
        modify("Ledger E&ntries")
        {
            Caption = 'Co&nfidential Info. Overview';
            ToolTip = 'View confidential information that is registered for the employee.';
            ApplicationArea = BasicHR, Suite;

        }

        addafter("E&mployee")
        { // Area Name not used in orignal object
            group(EmployeeDetails)
            {
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Image = NewLotProperties;
                    Promoted = true;
                    Caption = 'Emergency Contact Details';
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee KinSF";
                    RunPageLink = "Employee Code" = field("No."),
                                  Type = const("Next of Kin");
                    RunPageView = where(Type = filter("Next of Kin"));
                }
                action(Beneficiaries)
                {
                    ApplicationArea = Basic;

                    Image = Opportunity;

                    Promoted = true;
                    PromotedCategory = Category5;
                    Caption = 'Nominee';
                    RunObject = Page "HR Employee Beneficiary";
                    RunPageLink = "Employee Code" = field("No."),
                                  Type = const(Beneficiary);
                    RunPageView = where(Type = filter(Beneficiary));
                }
            }
        }



        modify("Co&mments")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }

        modify("&Relatives")
        {
            Visible = false;
        }

        moveafter("E&mployee"; "Co&nfidential Info. Overview")
        moveafter("Co&mments"; "Misc. Articles &Overview")
        moveafter(Dimensions; Action61)
        moveafter("Co&nfidential Info. Overview"; Action23)
    }

    var
        ShowSpouseDetails: Boolean;

    trigger OnOpenPage()
    begin
        UpdateSpouseDetailsVisibility();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        UpdateSpouseDetailsVisibility();

        if Rec."Birth Date" <> 0D then begin

            Rec."Retirement Date" := CalcDate('60Y', Rec."Birth Date");
            Rec.Age := Date2DMY(Today, 3) - Date2DMY(Rec."Birth Date", 3);


        end;
    end;

    local procedure UpdateSpouseDetailsVisibility()
    begin
        ShowSpouseDetails := Rec."Marital Status" = Rec."Marital Status"::Married;
    end;
}

