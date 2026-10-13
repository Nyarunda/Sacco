
TableExtension 50186 tableextension52188423 extends Employee
{
    fields
    {
        modify("Job Title")
        {
            TableRelation = "HR Jobs";
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                "Retirement Date" := 0D;
                Age := 0;
                if "Birth Date" <> 0D then begin

                    "Retirement Date" := CalcDate('60Y', "Birth Date");
                    Age := Date2DMY(Today, 3) - Date2DMY("Birth Date", 3);


                end;


            end;
        }

        modify("Phone No.")
        {
            Caption = 'Phone No.';
        }

        field(50002; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            begin
                "Branch Name" := '';

                if BankBranches.Get("Bank Code", "Branch Code") then
                    "Branch Name" := BankBranches."Branch Name";
            end;
        }
        field(50011; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
            end;
        }
        field(50021; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50023; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "Personal ID No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; PIN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "NSSF No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "NHIF No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Physically Challenged"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
        }
        field(50204; "Physically Challenged Details"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50205; "Physically Challenged Grade"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50218; Department; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Departments".Department;

            trigger OnLookup()
            var
                HRSetup: Record "Human Resources Setup";
                DimensionValue: Record "Dimension Value";
                frmDimensionValues: Page "Dimension Values";
            begin
            end;
        }
        field(50221; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Customer where("Payroll/Staff No." = field("No."));
            TableRelation = Members;

            trigger OnValidate()
            begin
                ValidateUniqueMemberNo();
            end;
        }
        field(50222; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(50223; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50224; "Supervisor Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50225; "Reimbursed Leave Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries."."No. of days" where("Staff No." = field("No."),
                                                                              "Posting Date" = field("Date Filter"),
                                                                              "Leave Entry Type" = const(Reimbursement),
                                                                              Reversed = const(false),
                                                                              "Leave Type" = field("Leave Type Filter"),
                                                                              Closed = const(false)));
            Description = '62008';
            FieldClass = FlowField;
        }
        field(50226; "Total Leave Taken"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries."."No. of days" where("Staff No." = field("No."),
                                                                              "Posting Date" = field("Date Filter"),
                                                                              "Leave Entry Type" = const(Negative),
                                                                              Reversed = const(false), "Leave Type" = field("Leave Type Filter"),
                                                                              //"Leave Calendar Code" = field("Current Leave Calender Filter"),
                                                                              Closed = const(false))
                                                                            );
            DecimalPlaces = 2 : 2;
            Editable = true;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days" + "Brought Froward Leave Days";
                "Leave Balance" := "Total (Leave Days)" + "Total Leave Taken";
            end;
        }
        field(50227; "Total (Leave Days)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days" + "Brought Froward Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                "Leave Balance" := "Total (Leave Days)" + "Total Leave Taken";
                //TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(50230; "Brought Froward Leave Days"; Decimal)
        {
            Caption = 'Brought Forward Leave Days';
            Description = '62008';
            FieldClass = FlowField;

            CalcFormula = sum("HR Leave Ledger Entries."."No. of days"
                                                                    where(
                                                                        "Staff No." = field("No."),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        "Leave Entry Type" = const(LeaveBroughtForward),
                                                                        Reversed = const(false),
                                                                        "Leave Type" = field("Leave Type Filter"),
                                                                        Closed = const(false)
                                                                    ));
        }
        field(50231; "Allocated Leave Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries."."No. of days" where("Staff No." = field("No."),
                                                                              "Posting Date" = field("Date Filter"),
                                                                              "Leave Entry Type" = const(Positive),
                                                                              Reversed = const(false),
                                                                              "Leave Type" = field("Leave Type Filter"),
                                                                              Closed = const(false)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*
                CALCFIELDS("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";
                //TotalDaysVal := Rec."Total Leave Taken";
                */

                CalcFields("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days" + "Brought Froward Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                "Leave Balance" := "Total (Leave Days)" + "Total Leave Taken";

            end;
        }
        field(50232; "End of Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50233; "Leave Period Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50234; "Mutliple Bank A/Cs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50235; "No. Of Bank A/Cs"; Integer)
        {
            FieldClass = Normal;
        }
        field(50236; "Annual Leave Account"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50237; "Compassionate Leave Acc."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50238; "Maternity Leave Acc."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50239; "Paternity Leave Acc."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50240; "Sick Leave Acc."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50241; "Study Leave Acc"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50242; "Appraisal Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal Appraisal,360 Appraisal';
            OptionMembers = " ","Normal Appraisal","360 Appraisal";
        }
        field(50243; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table39005570.Field1;
        }
        field(50244; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Contract,Intern';
            OptionMembers = Permanent,Contract,Intern;
        }
        field(50245; "Leave Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50246; "Leave Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Leave Types.";
        }
        field(50247; "Employee Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Class A,Class B,Class C,Class D,Class E,Class F,Class G';
            OptionMembers = " ","Class A","Class B","Class C","Class D","Class E","Class F","Class G";
        }
        field(50248; "Last Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50249; "Last Employer Phone"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50250; "Last Employer Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50251; "Last Employer Address"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50252; "HELB No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50253; "Passport No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50254; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            ObsoleteReason = 'Replaced by Image field';
            ObsoleteState = Pending;
            SubType = Bitmap;
        }
        field(50255; "Interests & Hobbies"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50256; District; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50257; Location; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50258; "Sub-Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50259; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others;
        }
        field(50260; "Place of Birth"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50261; "National Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50262; CurrYearStart; Date)
        {
            CalcFormula = lookup("Company Information"."Year Start");
            Editable = false;
            FieldClass = FlowField;
        }
        field(50263; CurrYearEnd; Date)
        {
            CalcFormula = lookup("Company Information"."Year End");
            Editable = false;
            FieldClass = FlowField;
        }
        field(50264; "Probation Period"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(50265; "Probation Start Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Probation Start Date" <> xRec."Probation Start Date" then begin
                    if "Probation Start Date" <> 0D then begin
                        TestField("Probation Period");
                        "Probation End Date" := CalcDate("Probation Period", "Probation Start Date");
                    end;
                end;
            end;
        }
        field(50266; "Probation End Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50267; "Years of Service"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50268; "Salary Increment Month"; Text[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = Date."Period Name" where("Period Type" = const(Month));
        }
        field(50269; "Location County"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Location;
            // TableRelation = Location.Name where(Type=const(County)));
        }
        field(50270; "Retirement Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(50271; "Job Reference"; code[40])
        {
            DataClassification = CustomerContent;
        }

        field(50272; Grade; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,WAN 1,WAN 2,WAN 3,WAN 4,WAN 5,WAN 6,WAN 7,WAN 8,WAN 9,WAN 10';
            OptionMembers = " ","WAN 1","WAN 2","WAN 3","WAN 4","WAN 5","WAN 6","WAN 7","WAN 8","WAN 9","WAN 10";
        }
        field(50273; "Job ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs";
            trigger OnValidate()
            var
                HRJobs: Record "HR Jobs";
            begin
                if HRJobs.Get("Job ID") then begin
                    "Job Description" := HRJobs."Job Description";
                end;
            end;
        }
        field(50274; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50275; "Age"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50276; "Current Leave Calender Filter"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Calendar."."Calendar Code" where("Current Leave Calendar" = const(true));
        }
        field(50693; "Spouse Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50694; "Spouse Contact No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50695; "Spouse Email"; Text[80])
        {
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(50296; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(50297; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = true;
        }
    }

    trigger OnInsert()
    begin
        ValidateUniqueMemberNo();
    end;

    trigger OnModify()
    begin
        ValidateUniqueMemberNo();

        if "Marital Status" = "Marital Status"::Married then begin
            /* TestField("Spouse Name");
            TestField("Spouse Contact No.");
            TestField("Spouse Email"); */
        end;
    end;

    local procedure ValidateUniqueMemberNo()
    var
        ExistingEmployee: Record Employee;
    begin
        if "Member No" = '' then
            exit;

        ExistingEmployee.Reset();
        ExistingEmployee.SetRange("Member No", "Member No");
        ExistingEmployee.SetFilter("No.", '<>%1', "No.");

        if ExistingEmployee.FindFirst() then
            Error(MemberNoInUseErr, "Member No", ExistingEmployee."No.");
    end;

    procedure GetLeaveBalance(EmployeeNo: Code[20]; LeaveType: Code[20]; AsAt: Date) LeaveBal: Decimal
    var
        AllocatedDays: Decimal;
        EarnedDays: Decimal;
        ReImbursedDays: Decimal;
        TotalLeaveDays: Decimal;
        TotalTaken: Decimal;
        DaysTaken: Decimal;
    begin
        LeaveStatsMgt.GetLeaveStatistics(
            EmployeeNo,
            LeaveType,
            AllocatedDays,
            EarnedDays,
            ReImbursedDays,
            TotalLeaveDays,
            TotalTaken,
            LeaveBal,
            DaysTaken);
    end;





    var
        BankBranches: Record "Bank Branches";
        BankCodes: Record "Bank Codes";
        LeaveStatsMgt: Codeunit "HR Leave Statistics Mgt.";
        MemberNoInUseErr: Label 'Member No. %1 is already assigned to Employee No. %2.';
}

