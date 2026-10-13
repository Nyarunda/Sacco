report 50052 "Savings Advice"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings Advice.rdlc';

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            DataItemTableView = WHERE("Table No." = CONST(50446),
                                      //"Field Caption"=FILTER("Monthly Contribution"),
                                      "Type of Change" = CONST(Modification));
            RequestFilterFields = "Date and Time";
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(OldValue_ChangeLogEntry; "Change Log Entry"."Old Value")
            {
            }
            column(NewValue_ChangeLogEntry; "Change Log Entry"."New Value")
            {
            }
            column(SavingsAccountNo; "Change Log Entry"."Primary Key Field 1 Value")
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(StaffNo; StaffNo)
            {
            }
            column(EmployerCode; EmployerCode)
            {
            }
            column(DateandTime_ChangeLogEntry; "Change Log Entry"."Date and Time")
            {
            }
            column(DateFilter; FORMAT("Change Log Entry".GETRANGEMIN("Date and Time")) + '..' + FORMAT("Change Log Entry".GETRANGEMAX("Date and Time")))
            {
            }
            column(Balance; Balance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MemberName := '';
                StaffNo := '';
                EmployerCode := '';
                Balance := 0;

                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE("No.", "Change Log Entry"."Primary Key Field 1 Value");
                IF EmpCodeFilter <> '' THEN
                    SavingsAccounts.SETRANGE("Employer Code", EmpCodeFilter);
                IF ProductId <> '' THEN
                    SavingsAccounts.SETRANGE("Product Type", ProductId);
                IF SavingsAccounts.FINDFIRST THEN BEGIN
                    SavingsAccounts.CALCFIELDS(Balance);
                    MemberName := SavingsAccounts.Name;
                    StaffNo := SavingsAccounts."Payroll/Staff No.";
                    EmployerCode := SavingsAccounts."Employer Code";
                    Balance := SavingsAccounts.Balance;
                END ELSE
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field("Employer Code"; EmpCodeFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No."; //WHERE (Account Type=CONST(Employer));
                    }
                    field("Product ID"; ProductId)
                    {
                        ApplicationArea = All;
                        Caption = 'Savings Product ID';
                        TableRelation = "Product Setup"."Product ID" WHERE("Product Class" = CONST(Savings));
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission.Reports, TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        SavingsAccounts: Record "Savings Accounts";
        MemberName: Code[100];
        StaffNo: Code[20];
        EmployerCode: Code[20];
        CompanyInformation: Record "Company Information";
        EmpCodeFilter: Code[20];
        ProductId: Code[20];
        Balance: Decimal;
        StatusPermission: Record "User Setup";
}

